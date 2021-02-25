import 'package:flutter/material.dart';
import 'package:tubtrunk/Controllers/rewardMissionController.dart';
import 'package:tubtrunk/Models/rewardMissionModel.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tubtrunk/Views/challengeIcon.dart';

class MissionView extends StatefulWidget {
  @override
  _MissionViewState createState() => _MissionViewState();
}

class _MissionViewState extends State<MissionView> {
  List<RewardMission> availableMissionsList;
  List<RewardMission> inProgressMissionsList;
  List<RewardMission> achievedMissionsList;
  RewardMissionController missionController = RewardMissionController();

  void changeMissionState(String missionName, String missionState) {
    setState(() {
      if (missionState == "lock") {
        missionController.moveChallengeToInProgress(missionName);
      }
    });
  }

  int requirementsProgress(RewardMission mission) {
    setState(() {
      if (mission.completedRequirements == mission.requirementsList.length) {
        missionController.moveInProgressToAchieved(mission.missionName);
      }
    });
    return mission.completedRequirements;
  }

  @override
  Widget build(BuildContext context) {
    availableMissionsList = missionController.getAvailableRewardMissions();
    inProgressMissionsList = missionController.getInProgressRewardMissions();
    achievedMissionsList = missionController.getAchievedRewardMissions();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            backgroundColor: Colors.orangeAccent,
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text("All",
                      style: TextStyle(
                          fontSize: 16.0, color: Colors.blueGrey.shade900)),
                ),
                Tab(
                  child: Text("In-Progress",
                      style: TextStyle(
                          fontSize: 16.0, color: Colors.blueGrey.shade900)),
                ),
                Tab(
                  child: Text("Achieved",
                      style: TextStyle(
                          fontSize: 16.0, color: Colors.blueGrey.shade900)),
                )
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              GridView.count(
                childAspectRatio: 1 / 1.9,
                crossAxisCount: 2,
                // Generate 100 widgets that display their index in the List.
                children: List.generate(availableMissionsList.length, (index) {
                  return Card(
                    color: Colors.grey.shade100,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: ListTile(
//                            leading: Icon(Icons.album),
                            title: Text(
                                "${availableMissionsList[index].missionName}"),
                            subtitle: Text(
                              "${missionController.getRewardMissionRequirements(availableMissionsList[index].missionName).toString().replaceAll('[', '').replaceAll(']', '').replaceAll(',', '')}",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black87),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 0,
                          child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Image.asset(
                                'assets/TrunkCoinIcon.png',
                                width: 14.0,
                                height: 14.0,
                              ),
                              const SizedBox(width: 1),
                              Text(
                                "${availableMissionsList[index].prizeMoney}",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87),
                              ),
                              const SizedBox(width: 2),
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      changeMissionState(
                                          availableMissionsList[index]
                                              .missionName,
                                          availableMissionsList[index]
                                              .missionStatus);
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.green.shade400,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 2),
                                      textStyle: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold)),
                                  icon: Icon(Challenge.challenge_icon,
                                      size: 30.0, color: Colors.black),
                                  label: Text(
                                    'Challenge!  ', ///////////////////////////////////////////////////////////////////////////////
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black87),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 3)
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
              GridView.count(
                childAspectRatio: 1 / 2,
                crossAxisCount: 2,
                // Generate 100 widgets that display their index in the List.
                children: List.generate(inProgressMissionsList.length, (index) {
                  return Container(
                    child: Card(
                      color: Colors.grey.shade100,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(
                            flex: 6,
                            child: ListTile(
//                            leading: Icon(Icons.album),
                              title: Text(
                                  "${inProgressMissionsList[index].missionName}"),
                              subtitle: Text(
                                "${missionController.getRewardMissionRequirements(inProgressMissionsList[index].missionName).toString().replaceAll('[', '').replaceAll(']', '').replaceAll(',', '')}",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Image.asset(
                                  'assets/TrunkCoinIcon.png',
                                  width: 15.0,
                                  height: 15.0,
                                ),
                                const SizedBox(width: 1),
                                Text(
                                  "${inProgressMissionsList[index].prizeMoney}",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "In-Progress", ///////////////////////////////////////////////////////
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 3)
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: StepProgressIndicator(
                              totalSteps: inProgressMissionsList[index]
                                  .requirementsList
                                  .length,
                              currentStep: requirementsProgress(
                                  inProgressMissionsList[index]),
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
                          )
                        ],
                      ),
                    ),
                  );
                }),
              ),
              GridView.count(
                childAspectRatio: 1 / 2,
                crossAxisCount: 2,
                // Generate 100 widgets that display their index in the List.
                children: List.generate(achievedMissionsList.length, (index) {
                  return Container(
                    child: Card(
                      color: Colors.grey.shade100,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(
                            flex: 6,
                            child: ListTile(
//                            leading: Icon(Icons.album),
                              title: Text(
                                  "${achievedMissionsList[index].missionName}"),
                              subtitle: Text(
                                "${missionController.getRewardMissionRequirements(achievedMissionsList[index].missionName).toString().replaceAll('[', '').replaceAll(']', '').replaceAll(',', '')}",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
//
                                Image.asset(
                                  'assets/TrunkCoinIcon.png',
                                  width: 15.0,
                                  height: 15.0,
                                ),
                                const SizedBox(width: 1),
                                Text(
                                  "${achievedMissionsList[index].prizeMoney}",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "Achieved",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 3)
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: StepProgressIndicator(
                              totalSteps: achievedMissionsList[index]
                                  .requirementsList
                                  .length,
                              currentStep: achievedMissionsList[index]
                                  .completedRequirements,
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
                          )
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
//    );
  }
}
