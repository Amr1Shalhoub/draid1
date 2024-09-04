// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ToothChart extends StatefulWidget {
  const ToothChart({super.key});

  @override
  State<ToothChart> createState() => _ToothChartState();
}

class _ToothChartState extends State<ToothChart> {
  Color cool=Colors.transparent;
  @override
  Widget build(BuildContext context) {

    return Center(
      child: Stack(
        children: [
          SvgPicture.asset(
            'images/tooth_chart.svg',
            fit: BoxFit.contain,
          ),
          Positioned(
            top: 300, // Adjust based on the actual position of tooth 1
            left: 40, // Adjust based on the actual position of tooth 1
            child: MouseRegion(
              onEnter: (pointerEvent){
                setState(() {
                  cool=Colors.grey;
                });

              },
              onHover: (pointerEvent ){
                setState(() {
                  cool=Colors.grey;
                });

              },
              onExit: (pointEvent){
                setState(() {
                  cool=Colors.transparent;
                });

              },
              child: Container(
                color: cool,
                child: GestureDetector(
                  onTap: () {
                    print('Tooth 1 clicked');
                  },
                  child: Container(
                    width: 40, // Adjust based on the size of the tooth
                    height: 40, // Adjust based on the size of the tooth
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 250, // Adjust based on the actual position of tooth 1
            left: 40, // Adjust based on the actual position of tooth 1
            child: Container(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  print('Tooth 2 clicked');
                },
                child: Container(
                  width: 40, // Adjust based on the size of the tooth
                  height: 40, // Adjust based on the size of the tooth
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          Positioned(
            top: 205, // Adjust based on the actual position of tooth 1
            left: 47, // Adjust based on the actual position of tooth 1
            child: Container(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  print('Tooth 3 clicked');
                },
                child: Container(
                  width: 40, // Adjust based on the size of the tooth
                  height: 40, // Adjust based on the size of the tooth
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          Positioned(
            top: 160, // Adjust based on the actual position of tooth 1
            left: 65, // Adjust based on the actual position of tooth 1
            child: Container(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  print('Tooth 4 clicked');
                },
                child: Container(
                  width: 40, // Adjust based on the size of the tooth
                  height: 40, // Adjust based on the size of the tooth
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          // Add more Positioned widgets for other teeth
          Positioned(
            top: 118, // Adjust based on the actual position of tooth 1
            left: 85, // Adjust based on the actual position of tooth 1
            child: Container(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  print('Tooth 5 clicked');
                },
                child: Container(
                  width: 40, // Adjust based on the size of the tooth
                  height: 40, // Adjust based on the size of the tooth
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          Positioned(
            top: 84, // Adjust based on the actual position of tooth 1
            left: 110, // Adjust based on the actual position of tooth 1
            child: Container(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  print('Tooth 6 clicked');
                },
                child: Container(
                  width: 33, // Adjust based on the size of the tooth
                  height: 33, // Adjust based on the size of the tooth
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          Positioned(
            top: 50, // Adjust based on the actual position of tooth 1
            left: 140, // Adjust based on the actual position of tooth 1
            child: Container(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  print('Tooth 7 clicked');
                },
                child: Container(
                  width: 35, // Adjust based on the size of the tooth
                  height: 35, // Adjust based on the size of the tooth
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          Positioned(
            top: 45, // Adjust based on the actual position of tooth 1
            left: 180, // Adjust based on the actual position of tooth 1
            child: Container(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  print('Tooth 8 clicked');
                },
                child: Container(
                  width: 35, // Adjust based on the size of the tooth
                  height: 35, // Adjust based on the size of the tooth
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          Positioned(
            top: 45, // Adjust based on the actual position of tooth 1
            left: 220, // Adjust based on the actual position of tooth 1
            child: Container(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  print('Tooth 9 clicked');
                },
                child: Container(
                  width: 35, // Adjust based on the size of the tooth
                  height: 35, // Adjust based on the size of the tooth
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          Positioned(
            top: 50, // Adjust based on the actual position of tooth 1
            left: 270, // Adjust based on the actual position of tooth 1
            child: Container(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  print('Tooth 10 clicked');
                },
                child: Container(
                  width: 35, // Adjust based on the size of the tooth
                  height: 35, // Adjust based on the size of the tooth
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          Positioned(
            top: 84, // Adjust based on the actual position of tooth 1
            left: 300, // Adjust based on the actual position of tooth 1
            child: Container(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  print('Tooth 11 clicked');
                },
                child: Container(
                  width: 33, // Adjust based on the size of the tooth
                  height: 33, // Adjust based on the size of the tooth
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          Positioned(
            top: 118, // Adjust based on the actual position of tooth 1
            left: 320, // Adjust based on the actual position of tooth 1
            child: Container(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  print('Tooth 12 clicked');
                },
                child: Container(
                  width: 40, // Adjust based on the size of the tooth
                  height: 40, // Adjust based on the size of the tooth
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          Positioned(
            top: 160, // Adjust based on the actual position of tooth 1
            left: 340, // Adjust based on the actual position of tooth 1
            child: Container(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  print('Tooth 13 clicked');
                },
                child: Container(
                  width: 40, // Adjust based on the size of the tooth
                  height: 40, // Adjust based on the size of the tooth
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          Positioned(
            top: 205, // Adjust based on the actual position of tooth 1
            left: 360, // Adjust based on the actual position of tooth 1
            child: Container(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  print('Tooth 14 clicked');
                },
                child: Container(
                  width: 40, // Adjust based on the size of the tooth
                  height: 40, // Adjust based on the size of the tooth
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          Positioned(
            top: 250, // Adjust based on the actual position of tooth 1
            left: 365, // Adjust based on the actual position of tooth 1
            child: Container(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  print('Tooth 15 clicked');
                },
                child: Container(
                  width: 40, // Adjust based on the size of the tooth
                  height: 40, // Adjust based on the size of the tooth
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          Positioned(
            top: 300, // Adjust based on the actual position of tooth 1
            left: 360, // Adjust based on the actual position of tooth 1
            child: Container(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  print('Tooth 16 clicked');
                },
                child: Container(
                  width: 40, // Adjust based on the size of the tooth
                  height: 40, // Adjust based on the size of the tooth
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          Positioned(
            top: 370, // Adjust based on the actual position of tooth 1
            left: 360, // Adjust based on the actual position of tooth 1
            child: Container(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  print('Tooth 17 clicked');
                },
                child: Container(
                  width: 40, // Adjust based on the size of the tooth
                  height: 45, // Adjust based on the size of the tooth
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          Positioned(
            top: 420, // Adjust based on the actual position of tooth 1
            left: 365, // Adjust based on the actual position of tooth 1
            child: Container(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  print('Tooth 18 clicked');
                },
                child: Container(
                  width: 40, // Adjust based on the size of the tooth
                  height: 40, // Adjust based on the size of the tooth
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          Positioned(
            top: 470, // Adjust based on the actual position of tooth 1
            left: 360, // Adjust based on the actual position of tooth 1
            child: Container(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  print('Tooth 19 clicked');
                },
                child: Container(
                  width: 40, // Adjust based on the size of the tooth
                  height: 40, // Adjust based on the size of the tooth
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          Positioned(
            top: 525, // Adjust based on the actual position of tooth 1
            left: 340, // Adjust based on the actual position of tooth 1
            child: Container(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  print('Tooth 20 clicked');
                },
                child: Container(
                  width: 40, // Adjust based on the size of the tooth
                  height: 40, // Adjust based on the size of the tooth
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          Positioned(
            top: 572, // Adjust based on the actual position of tooth 1
            left: 310, // Adjust based on the actual position of tooth 1
            child: Container(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  print('Tooth 21 clicked');
                },
                child: Container(
                  width: 40, // Adjust based on the size of the tooth
                  height: 40, // Adjust based on the size of the tooth
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          Positioned(
            top: 615, // Adjust based on the actual position of tooth 1
            left: 290, // Adjust based on the actual position of tooth 1
            child: Container(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  print('Tooth 22 clicked');
                },
                child: Container(
                  width: 30, // Adjust based on the size of the tooth
                  height: 30, // Adjust based on the size of the tooth
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          Positioned(
            top: 627, // Adjust based on the actual position of tooth 1
            left: 258, // Adjust based on the actual position of tooth 1
            child: Container(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  print('Tooth 23 clicked');
                },
                child: Container(
                  width: 30, // Adjust based on the size of the tooth
                  height: 30, // Adjust based on the size of the tooth
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          Positioned(
            top: 640, // Adjust based on the actual position of tooth 1
            left: 227, // Adjust based on the actual position of tooth 1
            child: Container(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  print('Tooth 24 clicked');
                },
                child: Container(
                  width: 30, // Adjust based on the size of the tooth
                  height: 30, // Adjust based on the size of the tooth
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          Positioned(
            top: 640, // Adjust based on the actual position of tooth 1
            left: 194, // Adjust based on the actual position of tooth 1
            child: Container(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  print('Tooth 25 clicked');
                },
                child: Container(
                  width: 30, // Adjust based on the size of the tooth
                  height: 30, // Adjust based on the size of the tooth
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          Positioned(
            top: 627, // Adjust based on the actual position of tooth 1
            left: 163, // Adjust based on the actual position of tooth 1
            child: Container(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  print('Tooth 26 clicked');
                },
                child: Container(
                  width: 30, // Adjust based on the size of the tooth
                  height: 30, // Adjust based on the size of the tooth
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          Positioned(
            top: 615, // Adjust based on the actual position of tooth 1
            left: 130, // Adjust based on the actual position of tooth 1
            child: Container(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  print('Tooth 27 clicked');
                },
                child: Container(
                  width: 30, // Adjust based on the size of the tooth
                  height: 30, // Adjust based on the size of the tooth
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          Positioned(
            top: 572, // Adjust based on the actual position of tooth 1
            left: 105, // Adjust based on the actual position of tooth 1
            child: Container(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  print('Tooth 28 clicked');
                },
                child: Container(
                  width: 40, // Adjust based on the size of the tooth
                  height: 40, // Adjust based on the size of the tooth
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          Positioned(
            top: 530, // Adjust based on the actual position of tooth 1
            left: 70, // Adjust based on the actual position of tooth 1
            child: Container(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  print('Tooth 29 clicked');
                },
                child: Container(
                  width: 40, // Adjust based on the size of the tooth
                  height: 40, // Adjust based on the size of the tooth
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          Positioned(
            top: 480, // Adjust based on the actual position of tooth 1
            left: 55, // Adjust based on the actual position of tooth 1
            child: Container(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  print('Tooth 30 clicked');
                },
                child: Container(
                  width: 40, // Adjust based on the size of the tooth
                  height: 40, // Adjust based on the size of the tooth
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          Positioned(
            top: 430, // Adjust based on the actual position of tooth 1
            left: 45, // Adjust based on the actual position of tooth 1
            child: Container(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  print('Tooth 31 clicked');
                },
                child: Container(
                  width: 40, // Adjust based on the size of the tooth
                  height: 40, // Adjust based on the size of the tooth
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          Positioned(
            top: 375, // Adjust based on the actual position of tooth 1
            left: 43, // Adjust based on the actual position of tooth 1
            child: Container(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  print('Tooth 32 clicked');
                },
                child: Container(
                  width: 40, // Adjust based on the size of the tooth
                  height: 45, // Adjust based on the size of the tooth
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}