import 'package:draid/layout/cubit/cubit.dart';
import 'package:draid/layout/cubit/states.dart';
import 'package:draid/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:xml/xml.dart';
import 'package:draid/models/get_completed_treatments_model.dart';

typedef Data = ({
  Size size,
  Map<int, Tooth> teeth,
  List<Datum>? completedTreatments
});

class Foo extends StatefulWidget {
  const Foo({
    super.key,
    required this.asset,
    required this.idToString,
    required this.patientId,
    required this.token,
  });

  final String asset;
  final String Function(int id) idToString;
  final String patientId;
  final String token;

  @override
  State<Foo> createState() => _FooState();
}

class _FooState extends State<Foo> {
  Data data = (size: Size.zero, teeth: {}, completedTreatments: []);

  @override
  void initState() {
    super.initState();
    loadTeeth(widget.asset).then((value) {
      setState(() => data = value);
      DrAidCubit.get(context)
          .getAllCompletedTreatments(patientId: widget.patientId);
    });

    DrAidCubit.get(context).stream.listen((state) {
      if (state is DrAidAllCompletedTreatmentsSuccessState) {
        setState(() {
          data = (
            size: data.size,
            teeth: data.teeth,
            completedTreatments:
                state.getCompletedTreatmentsModel.data // Nullable
          );
          // Check if completedTreatments is not null before calling _updateTreatedTeeth
          if (state.getCompletedTreatmentsModel.data != null) {
            _updateTreatedTeeth(state.getCompletedTreatmentsModel.data!);
          }
        });
      }
    });
  }

  void _updateTreatedTeeth(List<Datum>? completedTreatments) {
    if (completedTreatments == null) return;

    for (final treatment in completedTreatments) {
      final fromTeeth = treatment.fromTeeth;
      final toTeeth = treatment.toTeeth;

      if (fromTeeth != null && toTeeth != null) {
        final start = fromTeeth <= toTeeth ? fromTeeth : toTeeth;
        final end = fromTeeth <= toTeeth ? toTeeth : fromTeeth;

        // Parse the color from the treatment's color property
        final color = Color(
            int.parse(treatment.treatment!.color!.replaceFirst('#', '0xff')));

        for (int i = start; i <= end; i++) {
          if (data.teeth.containsKey(i)) {
            setState(() {
              data.teeth[i]?.treated = true;
              data.teeth[i]?.treatmentTitle = treatment.treatment!.title!;
              data.teeth[i]?.treatmentCategory = treatment.treatment!.category!;
              data.teeth[i]?.treatedColor = color;
            });
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (data.size == Size.zero) return const UnconstrainedBox();

    return Scaffold(
      backgroundColor: coolWhite2,
      appBar: AppBar(
        backgroundColor: white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: blueText),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          child: FittedBox(
            child: SizedBox.fromSize(
              size: data.size,
              child: Stack(
                children: [
                  for (final MapEntry<int, Tooth> entry in data.teeth.entries)
                    Positioned.fromRect(
                      rect: entry.value.rect,
                      child: Tooltip(
                        message: '${widget.idToString(entry.key)}\n'
                            'Treatment: ${entry.value.treatmentTitle}\n'
                            'Category: ${entry.value.treatmentCategory}',
                        textAlign: TextAlign.center,
                        preferBelow: false,
                        decoration: const BoxDecoration(
                          color: Colors.black87,
                          border: Border.symmetric(
                              horizontal: BorderSide(color: Colors.white54)),
                        ),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 750),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: entry.value.treated
                                ? entry.value.treatedColor
                                : (entry.value.selected
                                    ? Colors.teal.shade400
                                    : Colors.white),
                            shadows: entry.value.treated
                                ? [
                                    const BoxShadow(
                                        blurRadius: 4, offset: Offset(0, 6))
                                  ]
                                : null,
                            shape: ToothBorder(entry.value.path),
                          ),
                          child: Material(
                            type: MaterialType.transparency,
                            child: InkWell(
                              splashColor: entry.value.selected
                                  ? Colors.white
                                  : Colors.teal.shade400,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                print(
                                    'tooth ${widget.idToString(entry.key)} pressed (id ${entry.key})');
                                setState(() => entry.value.selected =
                                    !entry.value.selected);
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 125, vertical: 150),
                    child: Center(
                      child: Builder(builder: (context) {
                        final selected = data.teeth.entries
                            .where((e) => e.value.selected)
                            .map((e) => Text(widget.idToString(e.key)))
                            .toList();
                        return DefaultTextStyle(
                          style: Theme.of(context).textTheme.headlineLarge!,
                          textAlign: TextAlign.center,
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: selected.isNotEmpty ? 1 : 0,
                            child: DecoratedBox(
                              decoration: const BoxDecoration(
                                border: Border.symmetric(
                                    horizontal: BorderSide(
                                        width: 3, color: Colors.black26)),
                              ),
                              child: ListView(
                                shrinkWrap: true,
                                children: selected,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<Data> loadTeeth(String asset) async {
    final xml = await rootBundle.loadString(asset);
    final doc = XmlDocument.parse(xml);
    final viewBox = doc.rootElement.getAttribute('viewBox')!.split(' ');
    final w = double.parse(viewBox[2]);
    final h = double.parse(viewBox[3]);

    final teeth = doc.rootElement.findAllElements('path');
    print('loaded ${teeth.length} paths');
    return (
      size: Size(w, h),
      teeth: <int, Tooth>{
        for (final tooth in teeth)
          int.parse(tooth.getAttribute('id')!): Tooth(
              parseSvgPathData(tooth.getAttribute('d')!),
              int.parse(tooth.getAttribute('id')!)),
      },
      completedTreatments: <Datum>[],
    );
  }
}

class Tooth {
  Tooth(Path originalPath, this.id) {
    rect = originalPath.getBounds();
    path = originalPath.shift(-rect.topLeft);
  }

  late final int id;
  late final Path path;
  late final Rect rect;
  bool selected = false;
  bool treated = false;
  String treatmentTitle = '';
  String treatmentCategory = '';
  Color treatedColor = Colors.white; // Default color for untreated teeth
}

class ToothBorder extends ShapeBorder {
  const ToothBorder(this.path);

  final Path path;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      getOuterPath(rect);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return rect.topLeft == Offset.zero ? path : path.shift(rect.topLeft);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.black54;
    canvas.drawPath(getOuterPath(rect), paint);
  }

  @override
  ShapeBorder scale(double t) => this;
}
