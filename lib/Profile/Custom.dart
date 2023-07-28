import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project_management/Adapter/DesignAdapter.dart';
import 'package:project_management/Constant/colors.dart';
import 'package:project_management/Route.dart';
import 'package:project_management/Serverside/API.dart';

import '../Serverside/Server.dart';
import 'package:http/http.dart' as http;

class Custom extends StatefulWidget {
  const Custom({Key? key}) : super(key: key);

  @override
  State<Custom> createState() => _CustomState();
}

class _CustomState extends State<Custom> {

  Future<List> getDesignData()async{
    final response=await http.get(
        Uri.parse(
            APIBaseURL()+
                DataDesign()
        ),
    ).timeout(Duration(seconds: 10));
    print("Zyarga Debugger : "+json.decode(response.body)['data'].toString());
    return json.decode(response.body)['data'];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Design Custom"),
        backgroundColor: PrimaryColors(),
      ),
      body: Stack(
        children: [
          Container(
            width: double.maxFinite,
            height: double.maxFinite,
            color: SecondaryColors(),
          ),
          ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            children: [
              FutureBuilder(
                  future: getDesignData(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      // return ListView.builder(
                      //   itemCount: snapshot.requireData.length,
                      //   physics: NeverScrollableScrollPhysics(),
                      //   shrinkWrap: true,
                      //   itemBuilder: (context, index) {
                      //     return DesignAdapter();
                      //   },
                      // );
                      return GridView.builder(
                          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            mainAxisExtent: 300,
                          ),
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: snapshot.requireData.length,
                          itemBuilder: (context,i){
                            return InkWell(
                              onTap: () {
                                toPreset(context,snapshot.requireData[i]['id_design']);
                              },
                              child: DesignAdapter(
                                  id_design: snapshot.requireData[i]['id_design'],
                                  name: snapshot.requireData[i]['name'],
                                  description: snapshot.requireData[i]['description'],
                                  preview: snapshot.requireData[i]['preview'],
                                  status: snapshot.requireData[i]['status'],
                                  point: snapshot.requireData[i]['point']
                              ),
                            );
                        }
                      );
                    }else{
                      return new Center(child: CircularProgressIndicator());
                    }


                  },
              )
            ],
          ),
        ],
      ),
    );
  }
}
