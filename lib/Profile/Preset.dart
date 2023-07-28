import 'package:flutter/material.dart';
import 'package:project_management/Constant/Size.dart';
import 'package:project_management/Liblary/Ascendant.dart';
import 'package:project_management/Loading.dart';
import 'package:project_management/Preview/Simple.dart';
import 'package:project_management/Route.dart';

import '../Constant/colors.dart';


class Preset extends StatefulWidget {
  String id_design;
  Preset({Key? key,
    required this.id_design
  });

  @override
  State<Preset> createState() => _PresetState();
}

class _PresetState extends State<Preset> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCustomPreset(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return Scaffold(
            appBar: AppBar(
              title: Text("Data Preset"),
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
                  future: getListPreset(widget.id_design),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      return FutureBuilder(
                        future: getListPreset(widget.id_design),
                        builder: (context, snapshots) {
                          if(snapshot.hasData){
                            return GridView.builder(
                              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5,
                                mainAxisExtent: 300,
                              ),
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: snapshots.requireData.length,
                              itemBuilder: (context, index) {
                                if(widget.id_design=="1"){
                                  return InkWell(
                                    onTap: () {
                                      toCostumized(context, snapshots.requireData[index]['id_preset']);
                                    },
                                    child: Stack(
                                      children: [
                                        Card(
                                            elevation: 10,
                                            margin: EdgeInsets.all(10),
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                color: Colors.white,
                                              ),
                                            ),
                                            child: Simple(
                                              id_preset: snapshots.requireData[index]['id_preset'],
                                              preview: true
                                            )
                                        ),
                                        Center(
                                          child: Text(
                                            snapshots.requireData[index]['preset_name'],
                                            style: TextStyle(
                                                color: PrimaryColors(),
                                                fontSize: FontSizeLarge(),
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }else{
                                  return Loading();
                                }
                              },
                            );
                          }else{
                            return Loading();
                          }
                        },
                      );
                    }else{
                      return Loading();
                    }
                  },
                )
              ],
            ),
          );
        }else{
          return Loading();
        }
      },
    );
  }
}
