import 'package:flutter/material.dart';
import 'package:gantt_chart/gantt_chart.dart';

import '../Adapter/ProjectAdapter.dart';
import '../Loading.dart';
import '../Serverside/APIData.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int filter = 1;
  String Status = "0";
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  setState(() {
                    setState(() {
                      Status = "0";
                    });
                  });
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  height: 50,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Status == "0" ? Colors.red : Colors.white,
                    borderRadius:BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Text("All",style: TextStyle(
                        color: Status == "0" ? Colors.white : Colors.black,
                      ),
                      textAlign: TextAlign.center),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  setState(() {
                    Status = "1";
                  });
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  height: 50,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Status == "1" ? Colors.red : Colors.white,
                      borderRadius:BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Text("Current",style: TextStyle(
                        color: Status == "1" ? Colors.white : Colors.black,
                      ),
                          textAlign: TextAlign.center),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  setState(() {
                    Status = "2";
                  });
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  height: 50,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Status == "2" ? Colors.red : Colors.white,
                      borderRadius:BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Text("Past",style: TextStyle(
                        color: Status == "2" ? Colors.white : Colors.black,
                      ),
                          textAlign: TextAlign.center),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        FutureBuilder(
          future: ReadProject(Status),
          builder: (context, snapshots) {
            if(snapshots.hasData){
              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshots.requireData.length,
                itemBuilder: (context, index) {
                  return ProjectAdapter(
                    id_project: snapshots.requireData[index]['id_project'],
                    name: snapshots.requireData[index]['name'],
                    pmId: snapshots.requireData[index]['pmId'],
                    pmName: snapshots.requireData[index]['pmName'],
                    ownerId: snapshots.requireData[index]['ownerId'],
                    ownerName: snapshots.requireData[index]['ownerNama'],
                    status: snapshots.requireData[index]['status'],
                    note: snapshots.requireData[index]['note'],
                    color: snapshots.requireData[index]['color'],
                    start_date: snapshots.requireData[index]['start_date'],
                    end_date: snapshots.requireData[index]['end_date'],
                    target_date: snapshots.requireData[index]['target_date'],
                  );
                },
              );
            }else{
              return Loading();
            }
          },
        )
      ],
    );
    // return GanttChartView(
    //   maxDuration: const Duration(days: 30 * 2), //optional, set to null for infinite horizontal scroll
    //   startDate: DateTime(2022, 6, 7), //required
    //   dayWidth: 30, //column width for each day
    //   eventHeight: 30, //row height for events
    //   stickyAreaWidth: 200, //sticky area width
    //   showStickyArea: true, //show sticky area or not
    //   showDays: true, //show days or not
    //   startOfTheWeek: WeekDay.sunday, //custom start of the week
    //   weekEnds: const {WeekDay.friday, WeekDay.saturday}, //custom weekends
    //   isExtraHoliday: (context, day) {
    //     //define custom holiday logic for each day
    //     return DateUtils.isSameDay(DateTime(2022, 7, 1), day);
    //   },
    //   events: [
    //     //event relative to startDate
    //     GanttRelativeEvent(
    //       relativeToStart: const Duration(days: 0),
    //       duration: const Duration(days: 5),
    //       displayName: 'Do a very helpful task',
    //     ),
    //     //event with absolute start and end
    //     GanttAbsoluteEvent(
    //       startDate: DateTime(2022, 6, 10),
    //       endDate: DateTime(2022, 6, 16),
    //       displayName: 'Another task',
    //     ),
    //   ],
    // );
  }
}
