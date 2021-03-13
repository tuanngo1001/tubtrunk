import 'package:flutter/material.dart';
import 'package:tubtrunk/Controllers/rewardMissionController.dart';
import 'package:tubtrunk/Models/rewardMissionModel.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tubtrunk/Views/challengeIcon.dart';

class MissionView extends StatefulWidget {
  @override
  _MissionViewState createState() => _MissionViewState();
  final RewardMissionController _rewardMissionController = RewardMissionController();
}

class _MissionViewState extends State<MissionView> {
  List<RewardMissionModel> availableMissionsList;
  List<RewardMissionModel> inProgressMissionsList;
  List<RewardMissionModel> achievedMissionsList;
  RewardMissionController rewardMissionController;

  @override
  void initState() {
    super.initState();

    rewardMissionController = widget._rewardMissionController;
  }

  // int requirementsProgress(RewardMissionModel mission) {
  //   setState(() {
  //     if (mission.completedRequirements == mission.requirementsList.length) {
  //       rewardMissionController.moveInProgressToAchieved(mission.title);
  //     }
  //   });
  //   return mission.completedRequirements;
  // }

  @override
  Widget build(BuildContext context) {
    availableMissionsList = rewardMissionController.availableMissions;
    inProgressMissionsList = rewardMissionController.inProgressMissions;
    achievedMissionsList = rewardMissionController.achievedMissions;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(50.0),
      child: AppBar(
        backgroundColor: Colors.orangeAccent,
        bottom: _buildTabBar(),
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      tabs: [
        _buildTab("All"),
        _buildTab("In-Progress"),
        _buildTab("Achieved"),
      ],
    );
  }

  Widget _buildTab(String tabName) {
    return Tab(
      child: Text(
          tabName,
          style: TextStyle(
              fontSize: 16.0, color: Colors.blueGrey.shade900
          )
      ),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: _buildTabBarView(),
    );
  }

  Widget _buildTabBarView() {
    return TabBarView(
      children: [
        _buildAvailableMissions(),
        _buildInProgressMissions(),
        _buildAchievedMissions(),
      ],
    );
  }

  Widget _buildAvailableMissions() {
    List<Widget> missionWidgets = List.generate(availableMissionsList.length, (index) {
      List<Widget> missionComponents = _buildAvailableMissionComponents(
        availableMissionsList[index].title,
        availableMissionsList[index].prize,
        availableMissionsList[index].toString()
      );
      return _buildMission(missionComponents);
    });

    return _buildMissions(missionWidgets);
  }

  Widget _buildInProgressMissions() {
    List<Widget> missionWidgets = List.generate(inProgressMissionsList.length, (index) {
      List<Widget> missionComponents = _buildInProgressMissionComponents(
        inProgressMissionsList[index].title,
        inProgressMissionsList[index].prize,
        inProgressMissionsList[index].toString(),
        inProgressMissionsList[index].requirements.length,
        inProgressMissionsList[index].completedRequirements,
      );
      return _buildMission(missionComponents);
    });

    return _buildMissions(missionWidgets);
  }

  Widget _buildAchievedMissions() {
    List<Widget> missionWidgets = List.generate(achievedMissionsList.length, (index) {
      List<Widget> missionComponents = _buildAchievedMissionComponents(
        achievedMissionsList[index].title,
        achievedMissionsList[index].prize,
        achievedMissionsList[index].toString(),
        achievedMissionsList[index].requirements.length,
      );
      return _buildMission(missionComponents);
    });

    return _buildMissions(missionWidgets);
  }

  Widget _buildMissions(List<Widget> missionComponents) {
    return GridView.count(
      childAspectRatio: 1 / 1.9,
      crossAxisCount: 2,
      children: missionComponents,
    );
  }

  Widget _buildMission(List<Widget> missionComponents) {
    return Card(
      color: Colors.grey.shade100,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: missionComponents,
      ),
    );
  }

  List<Widget> _buildAvailableMissionComponents(String title, int prize, String requirements) {
    return <Widget>[
      _buildMissionDescription(title, requirements),
      Expanded(
        flex: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            _buildMissionPrize(prize),
            const SizedBox(width: 2),
            Expanded(
              child: _buildChallengeButton(title),
            ),
            const SizedBox(width: 3)
          ],
        ),
      ),
    ];
  }

  List<Widget> _buildInProgressMissionComponents(String title, int prize, String requirements, int _totalRequirements, int _finishedRequirements) {
    return <Widget>[
      _buildMissionDescription(title, requirements),
      _buildMissionStatus(prize, "In-Progress"),
      _buildProgressIndicator(totalRequirements: _totalRequirements, finishedRequirements: _finishedRequirements)
    ];
  }

  List<Widget> _buildAchievedMissionComponents(String title, int prize, String requirements, int _totalRequirements) {
    return <Widget>[
      _buildMissionDescription(title, requirements),
      _buildMissionStatus(prize, "Achieved"),
      _buildProgressIndicator(totalRequirements: _totalRequirements, finishedRequirements: _totalRequirements)
    ];
  }
  
  Widget _buildMissionDescription(String title, String requirements) {
    return Expanded(
      flex: 3,
      child: ListTile(
        title: Text(title),
        subtitle: Text(
          requirements,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black87),
        ),
      ),
    );
  }

  Widget _buildMissionPrize(int prize) {
    return Row(
      children: <Widget>[
        Image.asset(
          'assets/TrunkCoinIcon.png',
          width: 14.0,
          height: 14.0,
        ),
        const SizedBox(width: 1),
        Text(
          prize.toString(),
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87),
        ),
      ],
    );
  }

  Widget _buildChallengeButton(String title) {
    return ElevatedButton.icon(
      onPressed: () => _challengeMissionPressed(title),
      style: ElevatedButton.styleFrom(
          primary: Colors.green.shade400,
          padding: EdgeInsets.symmetric(horizontal: 2),
          textStyle: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold
          )
      ),
      icon: Icon(
          Challenge.challenge_icon,
          size: 30.0, color: Colors.black
      ),
      label: Text(
        'Challenge!',
        style: TextStyle(
          fontSize: 15,
          color: Colors.black87,
        ),
      ),
    );
  }

  void _challengeMissionPressed(String title) {
    setState(() {
      rewardMissionController.moveChallengeToInProgress(title);
    });
  }

  Widget _buildMissionStatus(int prize, String status) {
    return Expanded(
      flex: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _buildMissionPrize(prize),
          const SizedBox(width: 5),
          Text(
            status,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 3)
        ],
      ),
    );
  }

  Widget _buildProgressIndicator({int totalRequirements, int finishedRequirements}) {
    return Expanded(
      flex: 1,
      child: StepProgressIndicator(
        totalSteps: totalRequirements,
        currentStep: finishedRequirements,
        size: 24,
        selectedColor: Colors.green,
        unselectedColor: Colors.grey[400],
        customStep: (index, color, _) =>
        color == Colors.green
            ? Container(
          color: color,
          child: Icon(
            Icons.check,
            color: Colors.white,
          ),
        )
            : Container(
          color: color,
          child: Icon(
            Icons.remove,
          ),
        ),
      ),
    );
  }
}
