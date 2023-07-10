import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';


class Gauge extends StatelessWidget {
  const Gauge({
    super.key,
    required this.cps,
    required this.theme,
  });

  final double cps;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final minViewSize = min(screenHeight, screenWidth);
    
    return SizedBox(
      height: 0.75 * minViewSize,
      child: SfRadialGauge(axes: [
        RadialAxis(
          minimum: 0.0,
          maximum: 20.01,
          pointers: [
            NeedlePointer(
              value: cps,
              needleColor: theme.primaryColor,
              enableAnimation: true,
            ),
            RangePointer(
              value: cps,
              width: 0.1,
              sizeUnit: GaugeSizeUnit.factor,
              gradient: SweepGradient(
                colors: [theme.primaryColorLight, theme.primaryColor],
                stops: const [0.0, 1.0]
              ),
              enableAnimation: true,
            )
          ],
          annotations: [
            GaugeAnnotation(
              angle: 90,
              positionFactor: 0.75,
              widget: RichText(
                text: TextSpan(
                  text: cps.toStringAsFixed(2).replaceFirst('.', ','),
                  style: TextStyle(
                    fontSize: 0.05 * minViewSize,
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColor,
                  ),
                  children: [
                    TextSpan(
                      text: ' CPS',
                      style: TextStyle(
                        fontSize: 0.03 * minViewSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                )
              ),
              verticalAlignment: GaugeAlignment.far,
            ),
          ],
          axisLineStyle: const AxisLineStyle(
            thickness: 0.1,
            thicknessUnit: GaugeSizeUnit.factor,
          ),
        ),
      ]),
    );
  }
}
