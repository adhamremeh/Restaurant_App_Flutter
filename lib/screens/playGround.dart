import 'package:flutter/material.dart';

import 'package:mat3ami/screens/common_components/common_components.dart';

class PlayGround extends StatelessWidget {
  const PlayGround({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: customContainer(
            child: Center(
                child: customButton(
                    context: context,
                    onPressed: () {},
                    childText: 'childText'))));
  }
}
