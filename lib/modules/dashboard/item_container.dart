import 'package:draid/shared/styles/colors.dart';
import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  final String text;
  final int num;
  final Widget widget;
  const Item(
      {super.key, required this.text, required this.num, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: ColorManager.borderGreyColor, width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.all(10),
        height: 160,
        width: 330,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: ColorManager.babyGreyColor, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget,
                  Text(
                    "$num",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: ColorManager.greenColor),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Text(
                text,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AnimatedIconWidget extends StatefulWidget {
  final AnimatedIconData iconData;
  final String label;

  const AnimatedIconWidget({
    super.key,
    required this.iconData,
    required this.label,
  });

  @override
  // ignore: library_private_types_in_public_api
  _AnimatedIconWidgetState createState() => _AnimatedIconWidgetState();
}

class _AnimatedIconWidgetState extends State<AnimatedIconWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedIcon(
          icon: widget.iconData,
          progress: _controller,
          size: 50.0,
        ),
        const SizedBox(height: 8),
        Text(widget.label),
      ],
    );
  }
}

class DentalIconsPage extends StatelessWidget {
  const DentalIconsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dental Clinic Icons'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: const [
          AnimatedIconWidget(
              iconData: AnimatedIcons.menu_arrow, label: 'Patient Records'),
          AnimatedIconWidget(
              iconData: AnimatedIcons.event_add, label: 'Clinics'),
          AnimatedIconWidget(
              iconData: AnimatedIcons.play_pause, label: 'Treatments'),
          AnimatedIconWidget(
              iconData: AnimatedIcons.view_list, label: 'Invoices'),
          AnimatedIconWidget(
              iconData: AnimatedIcons.search_ellipsis, label: 'Appointments'),
        ],
      ),
    );
  }
}
