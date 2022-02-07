import 'package:flutter/material.dart';

class mrtmap extends StatefulWidget {
  @override
  State<mrtmap> createState() => _mrtmapState();
}

class _mrtmapState extends State<mrtmap> with SingleTickerProviderStateMixin {
  TransformationController controller;
  TapDownDetails tapDownDetails;

  AnimationController animationController;
  Animation<Matrix4> animation;

  @override
  void initState() {
    super.initState();

    controller = TransformationController();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    )..addListener(() {
        controller.value = animation.value;
      });
  }

  @override
  void dispose() {
    controller.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: <Widget>[
      Padding(
        padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('MRT MAP',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                  textAlign: TextAlign.center),
              SizedBox(
                height: 10.0,
              ),
              Text('*double tap to zoom',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center),
              SizedBox(
                height: 20.0,
              ),
              buildImage(),
            ]),
      )
    ]));
  }

  Widget buildImage() => GestureDetector(
        onDoubleTapDown: (details) => tapDownDetails = details,
        onDoubleTap: () {
          final position = tapDownDetails.localPosition;

          final double scale = 3.5;
          final x = -position.dx * (scale - 1);
          final y = -position.dy * (scale - 1);
          final zoomed = Matrix4.identity()
            ..translate(x, y)
            ..scale(scale);

          final end =
              controller.value.isIdentity() ? zoomed : Matrix4.identity();

          animation = Matrix4Tween(
            begin: controller.value,
            end: end,
          ).animate(
              CurveTween(curve: Curves.easeOut).animate(animationController));
          animationController.forward(from: 0);
        },
        child: InteractiveViewer(
          clipBehavior: Clip.none,
          transformationController: controller,
          panEnabled: true,
          child: AspectRatio(
            aspectRatio: 1,
            child: Image.asset("images/mrt_map.png", fit: BoxFit.contain),
          ),
        ),
      );
}
