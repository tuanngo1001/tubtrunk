import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:tubtrunk/Controllers/rewardMissionController.dart';
import 'package:tubtrunk/Models/rewardMissionModel.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tubtrunk/Views/Icons/challengeIcon.dart';


class MissionView extends StatefulWidget {
  final RewardMissionController _rewardMissionController = RewardMissionController();

  Function(int) updateProgressCallback;

  MissionView() {
    updateProgressCallback = _rewardMissionController.updateRequirementProgress;
  }

  @override
  _MissionViewState createState() => _MissionViewState();
}

class _MissionViewState extends State<MissionView> {
  List<RewardMissionModel> availableMissionsList;
  List<RewardMissionModel> inProgressMissionsList;
  List<RewardMissionModel> achievedMissionsList;
  RewardMissionController rewardMissionController;
  final _screenshotController = ScreenshotController();


  @override
  void initState() {
    super.initState();

    rewardMissionController = widget._rewardMissionController;
    rewardMissionController.setStateCallback = setState;
    rewardMissionController.loadMissions();
  }

  @override
  void dispose() {
    super.dispose();

    rewardMissionController.setStateCallback = null;
  }

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
        backgroundColor: Colors.indigo.shade100,
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
      child: Text(tabName,
          style: TextStyle(fontSize: 16.0, color: Colors.blueGrey.shade900)),
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
        _buildAcceptedMissions(inProgressMissionsList, "In-Progress"),
        _buildAcceptedMissions(achievedMissionsList, "Achieved"),
      ],
    );
  }

  Widget _buildAvailableMissions() {
    List<Widget> missionWidgets =
        List.generate(availableMissionsList.length, (index) {
      List<Widget> missionComponents =
          _buildAvailableMissionComponents(availableMissionsList[index]);
      return _buildMission(missionComponents);
    });

    return _buildMissions(missionWidgets);
  }

  Widget _buildAcceptedMissions(List<RewardMissionModel> missionList, String status) {
    List<Widget> missionWidgets = List.generate(missionList.length, (index) {
      List<Widget> missionComponents = _buildAcceptedMissionComponents(missionList[index], status);
      return Screenshot(controller: _screenshotController,child: _buildMission(missionComponents));
    });

    //missionWidgets.add(_buildShareButton());

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

  List<Widget> _buildAvailableMissionComponents(RewardMissionModel mission) {
    return <Widget>[
      _buildMissionDescription(mission.title, mission.toString()),
      Expanded(
        flex: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            _buildMissionPrize(mission.prize),
            const SizedBox(width: 2),
            Expanded(
              child: _buildChallengeButton(mission),
            ),
            const SizedBox(width: 3)
          ],
        ),
      ),
    ];
  }

  List<Widget> _buildAcceptedMissionComponents(
      RewardMissionModel mission, String status) {
    return <Widget>[_buildMissionDescription(mission.title, mission.toString()),
      _buildMissionStatus(mission.prize, status),
      _buildProgressIndicator(
          totalRequirements: mission.requirements.length,
          finishedRequirements: mission.completedRequirements)
    ];
  }

  Widget _buildMissionDescription(String title, String requirements) {
    return Expanded(
      flex: 10,
      child: ListTile(
        title: Text(title),
        subtitle: Text(
          requirements,
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black87),
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
              fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),
        ),
      ],
    );
  }

  Widget _buildChallengeButton(RewardMissionModel mission) {
    return ElevatedButton.icon(
      onPressed: () => rewardMissionController.moveMissionToInProgress(mission),
      style: ElevatedButton.styleFrom(
          primary: Color(0xfff97c7c),
          padding: EdgeInsets.symmetric(horizontal: 2),
          textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
      icon: Icon(Challenge.challenge_icon, size: 30.0, color: Colors.black),
      label: Text(
        'Challenge!',
        style: TextStyle(
          fontSize: 15,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildMissionStatus(int prize, String status) {
    return Expanded(
      flex: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _buildShareButton(),
          _buildMissionPrize(prize),
          const SizedBox(width: 5),
          Text(
            status,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 3)
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(
      {int totalRequirements, int finishedRequirements}) {
    return Expanded(
      flex: 1,
      child: StepProgressIndicator(
        totalSteps: totalRequirements,
        currentStep: finishedRequirements,
        size: 24,
        selectedColor: Colors.green,
        unselectedColor: Colors.grey[400],
        customStep: (index, color, _) => color == Colors.green
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

  Widget _buildShareButton(){
    return FloatingActionButton(
        mini: true,
        onPressed: _takeScreenshot,
        child: const Icon(Icons.share_outlined,),
    );
  }

  void _takeScreenshot() async{
    final imageFile = await _screenshotController.capture();
    Share.shareFiles([imageFile.path]);
  }
}
