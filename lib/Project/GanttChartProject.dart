import 'package:flutter/material.dart';
import 'package:gantt_chart/gantt_chart.dart';

class GanttChartProject extends StatefulWidget {
  String id_project;
  GanttChartProject({Key? key,required this.id_project}) : super(key: key);

  @override
  State<GanttChartProject> createState() => _GanttChartProjectState();
}

class _GanttChartProjectState extends State<GanttChartProject> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GanttChartView(
        maxDuration: const Duration(days: 30 * 2), //optional, set to null for infinite horizontal scroll
        startDate: DateTime(2022, 6, 7), //required
        dayWidth: 30, //column width for each day
        eventHeight: 50, //row height for events
        stickyAreaWidth: 100, //sticky area width
        showStickyArea: true, //show sticky area or not
        showDays: true, //show days or not
        startOfTheWeek: WeekDay.sunday, //custom start of the week
        weekEnds: {WeekDay.friday, WeekDay.saturday}, //custom weekends
        isExtraHoliday: (context, day) {
          //define custom holiday logic for each day
          return DateUtils.isSameDay(DateTime(2022, 7, 1), day);
        },
        scrollController: TrackingScrollController(),
        events: [
          //event relative to startDate
          GanttRelativeEvent(
            relativeToStart: const Duration(days: 0),
            duration: const Duration(days: 5),
            displayName: 'Do a very helpful task',
          ),
          //event with absolute start and end
          GanttAbsoluteEvent(
            suggestedColor: Colors.green,
            startDate: DateTime(2022, 6, 10),
            endDate: DateTime(2022, 6, 16),
            displayName: 'Another task',
          ),
        ],
      ),
    );
  }
}
