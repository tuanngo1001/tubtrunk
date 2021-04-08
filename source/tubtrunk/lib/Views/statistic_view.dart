import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:tubtrunk/Controllers/statistic_controller.dart';
import 'package:tubtrunk/Views/indicator.dart';
import 'package:flutter/rendering.dart';
import 'package:tubtrunk/Models/timer_record_model.dart';
import 'package:share/share.dart';

class StatisticView extends StatefulWidget {
  @override
  _StatisticViewState createState() => _StatisticViewState();
}

class _StatisticViewState extends State<StatisticView> {
  final StatisticController _statisticController = StatisticController();
  final _screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            backgroundColor: Colors.indigo.shade100,
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text("Summary",
                      style: TextStyle(
                          fontSize: 18.0, color: Colors.blueGrey.shade900)),
                ),
                Tab(
                  child: Text("History",
                      style: TextStyle(
                          fontSize: 18.0, color: Colors.blueGrey.shade900),
                  key: Key("stvHistoryTab"),
                  ),
                )
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: Screenshot(
            controller: _screenshotController,
            child: FutureBuilder<TabBarView>(
              future: _getDataAndReturnTabBarView(),
              builder:
                  (BuildContext context, AsyncSnapshot<TabBarView> snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data;
                } else {
                  return Container(width: 0.0, height: 0.0);
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<TabBarView> _getDataAndReturnTabBarView() async {
    int totalTimes = await _statisticController.fetchTimerRecord();
    double averageTimes = double.parse((_statisticController.getAverageFocusTimes()).toStringAsFixed(2));
    List<TimerRecordModel> recordsList = _statisticController.getTimerRecords();
    return TabBarView(
      children: [
        ListView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            Center(
                child: Text('Total focus times: $totalTimes \nAverage focus times: $averageTimes min(s)',
                    maxLines: 3,
                    style: TextStyle(fontSize: 25),
                key: Key("stvSummary")
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
              text: 'Succeed',
              isSquare: false,
            ),
            SizedBox(
              height: 4,
            ),
            Indicator(
              color: Color(0xfff8b250),
              text: 'Failed',
              isSquare: false,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.share_outlined,
                ),
                TextButton(
                    onPressed: _takeScreenshot,
                    child: Text("Share", style: TextStyle(fontSize: 25)))
              ],
            )
          ],
        ),
        ListView.builder(
            key: Key("stvTimeRecordsList"),
            padding: const EdgeInsets.all(8),
            itemCount: totalTimes,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.date_range_outlined),
                        title: Text(
                            'Date: ${recordsList[totalTimes - index - 1].date}      Time: ${recordsList[totalTimes - index - 1].time}',
                            key: Key("${index+1}st stvRecordTitle")
                        ),
                        subtitle: Text(
                            'Duration: ${recordsList[totalTimes - index - 1].duration} min(s)\nStatus: ${recordsList[totalTimes - index - 1].isCompleted()} ',
                            key: Key("${index+1}st stvRecordSubtitle")
                        ),
                      ),
                    ],
                  ),
                ),
              );
            })
      ],
    );
  }

  double displayPieChartValue(int times) {
    if (times == 0) {
      return 1.0;
    } else {
      return times.toDouble();
    }
  }

  List<PieChartSectionData> showingSections() {
    int succeedPercentage = _statisticController.getSucceedPercentage();
    int failedPercentage = _statisticController.getFailedPercentage();
    int succeedTimes = _statisticController.getSucceedFocusTimes();
    int failedTimes = _statisticController.getFailedFocusTimes();

    return List.generate(2, (i) {
      final double fontSize = 20;
      final double radius = 100;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: displayPieChartValue(succeedTimes),
            title: Text('$succeedPercentage% ($succeedTimes)', key: Key("stvSucceedProportion")).data,
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: displayPieChartValue(failedTimes),
            title: Text('$failedPercentage% ($failedTimes)', key: Key("stvFailedProportion")).data,
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }

  void _takeScreenshot() async {
    final imageFile = await _screenshotController.capture();
    Share.shareFiles([imageFile.path]);
  }
}
