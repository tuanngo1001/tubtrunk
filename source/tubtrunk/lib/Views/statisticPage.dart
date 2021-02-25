import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tubtrunk/Models/statisticController.dart';
import 'indicator.dart';
import 'package:flutter/rendering.dart';

class StatisticPage extends StatefulWidget {
  @override
  _StatisticPageState createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  final StatisticController _statisticController = StatisticController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            backgroundColor: Colors.orangeAccent,
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text(
                      "Summary",
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.blueGrey.shade900
                      )
                  ),

                ),
                Tab(
                  child: Text(
                      "Details",
                      style: TextStyle(
                          fontSize:18.0,
                          color: Colors.blueGrey.shade900
                      )
                  ),
                )
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              ListView(
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  const SizedBox(
                    height: 18,
                  ),
                  Center(
                    child:
                      Text(
                        'Total focus times: 10',
                        style: TextStyle(fontSize: 20)
                      )
                  ),
                  AspectRatio(
                    aspectRatio: 1,
                    child: PieChart(
                      PieChartData(
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sectionsSpace: 0,
                          centerSpaceRadius: 40,
                          sections: showingSections()),
                    ),
                  ),
                  Indicator(
                    color: Color(0xff0293ee),
                    text: 'Succeed Focus Times',
                    isSquare: false,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Indicator(
                    color: Color(0xfff8b250),
                    text: 'Failed Focus Times',
                    isSquare: false,
                  ),
                ],
              ),

              Center(child: Text('Timer Record Details'))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState()
  {
    super.initState();

  }

  List<PieChartSectionData> showingSections() {
    return List.generate(2, (i) {
      final double fontSize = 25;
      final double radius = 100;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }
}
