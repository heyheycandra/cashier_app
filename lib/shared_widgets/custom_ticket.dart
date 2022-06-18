import 'package:flutter/material.dart';
import 'dart:math';
import 'package:cashier_app_mobile/theme/colors.dart';
import 'package:cashier_app_mobile/helper/app_scale.dart';

///Class represents mask with circles(holes) and and two cutouts (as hemispheres).
///[radiusCircle] - radius of circles(holes).
///[marginBetweenCircles] - margin between circles(holes).
///[colorBg] - background color of ticket.
///[colorShadow] - shadow color of ticket.
///[shadowSize] - size or offset of shadow ticket.
///[_radiusArc] - radius of two cutouts (as hemispheres).
class MaskTicketPainter extends CustomPainter {
  final double radiusCircle;
  final double marginBetweenCircles;
  final Color colorBg;
  final Color colorShadow;
  final double shadowSize;
  late double _radiusArc;

  MaskTicketPainter({
    required this.radiusCircle,
    required this.marginBetweenCircles,
    required this.colorBg,
    required this.colorShadow,
    required this.shadowSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _radiusArc = size.width / 2;

    final pathPolygon = Path()
      ..addRRect(RRect.fromLTRBR(0.0, 0.0, size.width, size.height, const Radius.circular(0)))
      ..close();

    final pathMask = Path()
      ..addArc(Rect.fromLTWH(0, -_radiusArc, _radiusArc * 2, _radiusArc * 2), 0, degToRad(180).toDouble())
      ..addArc(Rect.fromLTWH(0, size.height - _radiusArc, _radiusArc * 2, _radiusArc * 2), degToRad(-180).toDouble(), degToRad(180).toDouble())
      ..addPath(_getCirclesPath(radiusCircle, _radiusArc, marginBetweenCircles, 0, size.height), const Offset(0, 0))
      ..close();

    final pathCombined = Path.combine(
      PathOperation.difference,
      pathPolygon,
      pathMask,
    );

    final paint = Paint()
      ..color = colorBg
      ..isAntiAlias = true
      ..filterQuality = FilterQuality.high;

    canvas.drawShadow(pathCombined, colorShadow, shadowSize, false);
    canvas.drawPath(
      pathCombined,
      paint,
    );
  }

  ///Calculate optimized radius of circles, based on the set radius [radiusCircle].
  double _getOptimizedRadiusCircle(
    double startTopY,
    endBottomY,
    double radiusCircle,
  ) {
    var indexCircle = 0;
    final diameterCircle = radiusCircle * 2;

    while (startTopY < endBottomY) {
      startTopY += diameterCircle;
      startTopY += marginBetweenCircles;

      indexCircle++;
    }

    //correction to bottom line of circle
    startTopY -= radiusCircle;

    final remainSpace = endBottomY - startTopY;
    final correctionBalance = remainSpace / indexCircle;

    return radiusCircle + (correctionBalance / 2);
  }

  ///A baked path with all the holes that fit the current height of the item.
  Path _getCirclesPath(double radiusCircle, double radiusArc, double marginBetweenCircles, double startX, double height) {
    final marginByY = radiusCircle + radiusArc + marginBetweenCircles;
    final limitBottomY = height - marginByY;
    var currentOvalPosY = radiusCircle + marginByY;
    final optimizedRadiusCircle = _getOptimizedRadiusCircle(
      currentOvalPosY,
      limitBottomY,
      radiusCircle,
    );
    var path = Path();

    // correction start point by optimized radius
    currentOvalPosY = optimizedRadiusCircle + marginByY;

    while (currentOvalPosY <= limitBottomY) {
      currentOvalPosY += marginBetweenCircles / 2;

      path.addOval(Rect.fromCircle(center: Offset(startX + radiusArc, currentOvalPosY), radius: optimizedRadiusCircle));

      currentOvalPosY += (marginBetweenCircles / 2) + optimizedRadiusCircle * 2;
    }

    return path;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }

  /// Method to convert degree to radians
  num degToRad(num deg) => deg * (pi / 180.0);
}

class TicketMaterial extends StatefulWidget {
  final int flexLefSize;
  final int flexMaskSize;
  final int flexRightSize;
  final Color colorBackground;
  final Color colorShadow;
  final double shadowSize;
  final double radiusCircle;
  final double radiusBorder;
  final double marginBetweenCircles;
  final double height;
  final Widget leftChild;
  final Widget rightChild;
  final Function()? tapHandler, onTap;
  final bool useAnimationScaleOnTap;
  final double lowerBoundAnimation;

  const TicketMaterial({
    this.flexLefSize = 70,
    this.flexMaskSize = 5,
    this.flexRightSize = 20,
    this.radiusCircle = 4,
    this.marginBetweenCircles = 3,
    this.onTap,
    required this.height,
    required this.leftChild,
    required this.rightChild,
    required this.colorBackground,
    this.colorShadow = Colors.grey,
    this.shadowSize = 1.5,
    this.radiusBorder = 0,
    this.tapHandler,
    this.useAnimationScaleOnTap = true,
    this.lowerBoundAnimation = 0.95,
    Key? key,
  }) : super(key: key);

  @override
  _TicketMaterialState createState() => _TicketMaterialState();
}

class _TicketMaterialState extends State<TicketMaterial> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final _width = double.infinity;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      lowerBound: widget.lowerBoundAnimation,
      upperBound: 1,
      vsync: this,
    );
    _controller.forward();
    super.initState();
  }

  ///Launch revers animation of ticket(setting scale to default size).
  void _tapDown(TapDownDetails details) {
    if (widget.useAnimationScaleOnTap) {
      _controller.reverse();
    }

    if (widget.tapHandler != null) {
      widget.tapHandler!();
    }
  }

  ///This trigger immediately before onTap event.
  ///Launch animation of changing scale ticket(reducing size of ticket).
  void _tapUp(TapUpDetails details) {
    if (widget.useAnimationScaleOnTap) {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: _tapUp,
      onTapDown: _tapDown,
      onTap: widget.onTap,
      child: ScaleTransition(
        scale: _controller,
        child: SizedBox(
          width: _width,
          height: widget.height,
          child: Row(
            children: <Widget>[
              Flexible(
                  flex: widget.flexLefSize,
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: widget.colorBackground,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(widget.radiusBorder),
                          bottomLeft: Radius.circular(widget.radiusBorder),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: widget.colorShadow,
                            blurRadius: 0.5,
                            offset: Offset(-0.5, widget.shadowSize),
                          ),
                        ]),
                    child: widget.leftChild,
                  )),
              Flexible(
                flex: widget.flexMaskSize,
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.transparent,
                  child: CustomPaint(
                    painter: MaskTicketPainter(
                        radiusCircle: widget.radiusCircle,
                        marginBetweenCircles: widget.marginBetweenCircles,
                        colorBg: widget.colorBackground,
                        colorShadow: widget.colorShadow,
                        shadowSize: widget.shadowSize),
                  ),
                ),
              ),
              Flexible(
                  flex: widget.flexRightSize,
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: widget.colorBackground,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(widget.radiusBorder),
                          topRight: Radius.circular(widget.radiusBorder),
                        ),
                        boxShadow: [
                          BoxShadow(color: widget.colorShadow, blurRadius: 0.5, offset: Offset(0.5, widget.shadowSize)),
                        ]),
                    child: widget.rightChild,
                  ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class SCticketShape extends StatelessWidget {
  final Widget child;
  final bool? isCart;
  const SCticketShape({this.isCart, required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomTicketShape(),
      child: Container(
        height: context.deviceHeight() * 0.2,
        margin: const EdgeInsets.only(bottom: 20),
        padding: EdgeInsets.symmetric(horizontal: context.deviceWidth() * 0.05),
        color: cashierHistoryBgItem,
        child: child,
      ),
    );
  }
}

class CustomTicketShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.addRRect(RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, size.width, size.height), const Radius.circular(8)));
    path.addOval(Rect.fromCircle(center: Offset(0, (size.height / 3) * 1.8), radius: 15));
    path.addOval(Rect.fromCircle(center: Offset(size.width, (size.height / 3) * 1.8), radius: 15));
    path.fillType = PathFillType.evenOdd;
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
