import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CircleButton extends StatefulWidget {
  const CircleButton({
    Key key,
  }) : super(key: key);

  @override
  _CircleButtonState createState() => _CircleButtonState();
}

class _CircleButtonState extends State<CircleButton>
    with TickerProviderStateMixin {
  AnimationController _animationController;

  AnimationController _fadeInController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    _fadeInController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.60,
      width: MediaQuery.of(context).size.width * 0.95,
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                ProgressCircle(
                  animationController: _animationController,
                ),
                DrinkGlassWithAmount(
                  fadeInController: _fadeInController,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    _fadeInController.dispose();
  }
}

class DrinkGlassWithAmount extends StatelessWidget {
  const DrinkGlassWithAmount({
    Key key,
    @required this.fadeInController,
  }) : super(key: key);

  final AnimationController fadeInController;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final waterAmount = snapshot.data;
          fadeInController.forward();
          return AnimatedBuilder(
            animation: fadeInController,
            builder: (context, child) {
              return Opacity(
                opacity: fadeInController.value,
                child: Column(
                  children: <Widget>[
                    Text('Done',
                        style: TextStyle(
                            color: Color.fromRGBO(54, 87, 119, 1),
                            fontSize: 14)),
                    SizedBox(height: 6),
                    Text(
                      '$waterAmount',
                      style: TextStyle(
                          color: Color.fromRGBO(54, 87, 119, 1), fontSize: 32),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      'of 2500 ml today',
                      style: TextStyle(
                          color: Color.fromRGBO(54, 87, 119, 1), fontSize: 14),
                    ),
                  ],
                ),
              );
            },
          );
        }
        return SizedBox();
      },
    );
  }
}

class ProgressCircle extends StatelessWidget {
  const ProgressCircle({
    Key key,
    @required AnimationController animationController,
  })  : _animationController = animationController,
        super(key: key);

  final AnimationController _animationController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      width: 250,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        shape: BoxShape.circle,
      ),
      child: StreamBuilder<double>(
        initialData: 0,
        builder: (context, snapshot) {
          _animationController.animateTo(snapshot.data);
          return AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return CustomPaint(
                foregroundPainter: CircleProgressPainter(
                  completeColor: Colors.blue,
                  lineColor: Colors.grey[200],
                  completePercent: _animationController.value,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class CircleProgressPainter extends CustomPainter {
  CircleProgressPainter(
      {this.lineColor, this.completeColor, this.completePercent});
  final Color lineColor;
  final Color completeColor;
  final double completePercent;
  final double lineWidth = 30;

  @override
  void paint(Canvas canvas, Size size) {
    Paint line = Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.square
      ..style = PaintingStyle.stroke
      ..strokeWidth = lineWidth;

    Paint completeLine = Paint()
      ..color = completeColor
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..strokeWidth = lineWidth;

    Offset center = Offset(size.width / 2, size.height / 2);

    double radius = min(
        size.width / 2 - (lineWidth / 2), size.height / 2 - (lineWidth / 2));

    canvas.drawCircle(center, radius, line);

    double arcAngle = 2 * pi * (completePercent);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      arcAngle,
      false,
      completeLine,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
