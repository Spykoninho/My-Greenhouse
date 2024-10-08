import 'package:flutter/material.dart';

class LargeHeader extends StatelessWidget {
  const LargeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).colorScheme.primary,
          ),
          Positioned(
            top: MediaQuery.sizeOf(context).height / 4,
            left: -40,
            child: Container(
              height: 200,
              width: MediaQuery.sizeOf(context).width + 80,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius:
                      const BorderRadius.all(Radius.elliptical(500, 200))),
            ),
          ),
        ],
      ),
    );
  }
}
