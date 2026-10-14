import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SalesChart extends StatelessWidget {
  const SalesChart({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        minX: 0,
        maxX: 6,

        minY: 0,
        maxY: 7,

        borderData: FlBorderData(show: false),

        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 1,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.grey.shade300,
              strokeWidth: 1,
            );
          },
        ),

        titlesData: FlTitlesData(
          topTitles: const AxisTitles(),
          rightTitles: const AxisTitles(),

          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
            ),
          ),

          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,

              getTitlesWidget: (value, meta) {
                const months = [
                  "Jan",
                  "Feb",
                  "Mar",
                  "Apr",
                  "May",
                  "Jun",
                  "Jul",
                ];

                if (value.toInt() >= months.length) {
                  return const SizedBox();
                }

                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(months[value.toInt()]),
                );
              },
            ),
          ),
        ),

        lineBarsData: [

          LineChartBarData(
            isCurved: true,

            color: const Color(0xff6C4EF6),

            barWidth: 4,

            isStrokeCapRound: true,

            dotData: const FlDotData(
              show: false,
            ),

            belowBarData: BarAreaData(
              show: true,
              color: const Color(0xff6C4EF6).withOpacity(.12),
            ),

            spots: const [

              FlSpot(0, 2),

              FlSpot(1, 3),

              FlSpot(2, 2.7),

              FlSpot(3, 5),

              FlSpot(4, 4.6),

              FlSpot(5, 6.2),

              FlSpot(6, 5.8),

            ],
          ),

        ],
      ),
    );
  }
}