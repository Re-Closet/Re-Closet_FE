import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class RadialGauge extends StatelessWidget {
  final double value;
  final double needleLength;

  const RadialGauge({
    super.key,
    required this.value,
    this.needleLength = 130,
  });

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: 100,
          pointers: <GaugePointer>[
            NeedlePointer(
              value: value,
              lengthUnit: GaugeSizeUnit.logicalPixel,
              needleLength: needleLength,
              enableAnimation: true, // 애니메이션 활성화
              animationDuration: 1500, // 밀리초 (1.5초)
              animationType: AnimationType.ease, // 부드러운 효과
            ),
          ],
          axisLineStyle: const AxisLineStyle(
            thickness: 0.1,
            thicknessUnit: GaugeSizeUnit.factor,
            cornerStyle: CornerStyle.bothCurve,
            gradient: SweepGradient(
              colors: <Color>[Color(0xFF9791FF), Color(0xFFF3D1FB)],
              stops: <double>[0.25, 0.75],
            ),
          ),
        ),
      ],
    );
  }
}
