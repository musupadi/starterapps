import 'dart:math';

import 'package:flutter/material.dart';

import '../Constant/colors.dart';
import '../Liblary/Ascendant.dart';

class RealizationAdapter extends StatefulWidget {
  String id_realization;
  String id_task;
  String id_project;
  String progress;
  String note;
  String status;
  String updated_at;
  RealizationAdapter({
    Key? key,
    required this.id_realization,
    required this.id_task,
    required this.id_project,
    required this.progress,
    required this.note,
    required this.status,
    required this.updated_at
  });

  @override
  State<RealizationAdapter> createState() => _RealizationAdapterState();
}

class _RealizationAdapterState extends State<RealizationAdapter> {
  final _random = new Random();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // toMyRealization(
        //     context,
        //     widget.id_project,
        //     widget.status,
        //     widget.start_date,
        //     widget.end_date,
        //     widget.target_date,
        //     widget.id_task,
        //     widget.name,
        //     widget.note,
        //     widget.pm,
        //     widget.pmNama,
        //     widget.staff,
        //     widget.staffNama
        // );
        // Message(widget.id_project, context);
        // toMyTask(context, widget.id_project);
      },
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                // Text(
                //   "Relization",
                //   style: TextStyle(
                //       fontSize: 20,
                //       fontWeight: FontWeight.bold
                //   ),
                // ),
                // Container(
                //   margin: EdgeInsets.only(left: 10,right: 10,bottom: 5),
                //   height: 1,
                //   width: double.maxFinite,
                //   color: Colors.red,
                // ),
                // SizedBox(height: 5,),
                // Row(
                //   children: [
                //     Container(
                //       width: 100,
                //       child: Text("Project Manager"),
                //     ),
                //     Expanded(
                //       child: Text(
                //           ": "+widget.pmNama
                //       ),
                //     )
                //   ],
                // ),
                // SizedBox(height: 5,),
                // Row(
                //   children: [
                //     Container(
                //       width: 100,
                //       child: Text("Staff"),
                //     ),
                //     Expanded(
                //       child: Text(
                //           ": "+widget.staffNama
                //       ),
                //     )
                //   ],
                // ),
                // SizedBox(height: 5,),
                // Row(
                //   children: [
                //     Container(
                //       width: 100,
                //       child: Text("Start Date"),
                //     ),
                //     Expanded(
                //       child: Text(
                //           ": "+widget.start_date
                //       ),
                //     )
                //   ],
                // ),
                // SizedBox(height: 5,),
                // Row(
                //   children: [
                //     Container(
                //       width: 100,
                //       child: Text("End Date"),
                //     ),
                //     Expanded(
                //       child: Text(
                //           ": "+widget.end_date
                //       ),
                //     )
                //   ],
                // ),
                // SizedBox(height: 5,),

                Row(
                  children: [
                    Container(
                      width: 100,
                      child: Text("Tanggal"),
                    ),
                    Expanded(
                      child: Text(
                          ": "+DateBuilder(widget.updated_at)
                      ),
                    )
                  ],
                ),
                widget.note == "" ? Container() : Row(
                  children: [
                    Container(
                      width: 100,
                      child: Text("note"),
                    ),
                    Expanded(
                      child: Text(
                          ": "+widget.note
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10,),
                Text(
                  "Progress Realization",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                  ),
                ),
                ProgressBar(context, double.parse(widget.progress) !>100.00 ? 100 : double.parse(widget.progress), _random.nextInt(StyleCount())),
              ],
            )
        ),
      ),
    );
  }
}
