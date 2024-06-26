import 'package:flutter/material.dart';
import 'package:gantt_chart/gantt_chart.dart';
import 'package:lottie/lottie.dart';
import 'package:project_management/Constant/Size.dart';
import 'package:project_management/Liblary/Ascendant.dart';

import '../Constant/colors.dart';
import '../Serverside/APIData.dart';

class GanttChartProject extends StatefulWidget {
  String id_project;
  GanttChartProject({Key? key,required this.id_project}) : super(key: key);

  @override
  State<GanttChartProject> createState() => _GanttChartProjectState();
}

class _GanttChartProjectState extends State<GanttChartProject> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gantt Chart Project"),
        backgroundColor: PrimaryColors(),
      ),
      body: Stack(
        children: [
          Container(
            width: double.maxFinite,
            height: double.maxFinite,
            color: SecondaryColors(),
          ),
          FutureBuilder(
            future: WhereReadProject(widget.id_project),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return ListView(
                  shrinkWrap: true,
                  children: [
                    Container(
                      margin:EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Text(
                            snapshot.requireData[0]['name'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: FontSizeLarge()
                            ),
                          ),
                        ),
                      ),
                    ),
                    FutureBuilder(
                      future: ReadTask(widget.id_project),
                      builder: (context, task) {
                        if(task.hasData){
                          return GanttChartView(
                            // maxDuration: const Duration(days: 30 * 2), //optional, set to null for infinite horizontal scroll

                            startDate: DateTime(
                              DateYear(snapshot.requireData[0]['start_date']),
                              DateMonth(snapshot.requireData[0]['start_date']),
                              DateDay(snapshot.requireData[0]['start_date']),
                            ), //required
                            dayWidth: 30, //column width for each day
                            eventHeight: 50, //row height for events
                            stickyAreaWidth: 100, //sticky area width
                            showStickyArea: true, //show sticky area or not
                            showDays: true, //show days or not
                            startOfTheWeek: WeekDay.sunday, //custom start of the week
                            scrollPhysics: BouncingScrollPhysics(),
                            weekEnds: {WeekDay.friday, WeekDay.saturday}, //custom weekends
                            scrollController: TrackingScrollController(),
                            events: [

                              //event relative to startDate
                              for(int i=0;i<task.requireData.length;i++)
                                GanttAbsoluteEvent(
                                  startDate: DateTime(
                                    DateYear(task.requireData[i]['start_date']),
                                    DateMonth(task.requireData[i]['start_date']),
                                    DateDay(task.requireData[i]['start_date']),
                                  ),
                                  endDate: DateTime(
                                    DateYear(task.requireData[i]['end_date']),
                                    DateMonth(task.requireData[i]['end_date']),
                                    DateDay(task.requireData[i]['end_date']),
                                  ),
                                  displayName: task.requireData[i]['name'],
                                ),
                            ],
                          );
                        }else{
                          return Container();
                        }
                      },
                    )

                  ],
                );
              }else{
                return Container();
              }
            }
          ),
          isLoading
              ?Container(
              width: double.maxFinite,
              height: double.maxFinite,
              color: Colors.white.withOpacity(0.7),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset(
                    "assets/lottie/loadingsent.json",
                    width: 300,
                    height: 300,
                  ),
                  Text("Mohon Tunggu Sebentar Sedang Loading")
                ],
              )
          )
              :Container(),
        ],
      ),

    );
  }
}
