import 'package:flutter/material.dart';

class Largeheader extends StatelessWidget {
  const Largeheader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height / 1.75,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              height: MediaQuery.sizeOf(context).height / 3,
              width: MediaQuery.sizeOf(context).width,
              color: const Color(0xFF14303B),
            ),
          ),
          Positioned(
            top: MediaQuery.sizeOf(context).height / 4,
            left: -40,
            child: Container(
              height: 200,
              width: MediaQuery.sizeOf(context).width + 80,
              decoration: BoxDecoration(
                  color: Color(0xFF14303B),
                  borderRadius:
                      const BorderRadius.all(Radius.elliptical(500, 200))),
            ),
          ),
        ],
      ),
    );
  }
}
