import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project_management/Constant/Size.dart';

import '../Constant/colors.dart';
import 'package:http/http.dart' as http;

import '../Serverside/API.dart';
import '../Serverside/Server.dart';
class Domain extends StatefulWidget {
  const Domain({Key? key}) : super(key: key);

  @override
  State<Domain> createState() => _DomainState();
}

Future<List> getDomainData()async{
  final response=await http.get(
    Uri.parse(
        APIBaseURL()+
            DataDomain()
    ),
  ).timeout(Duration(seconds: 10));
  print("Zyarga Debugger : "+json.decode(response.body)['data'].toString());
  return json.decode(response.body)['data'];
}
class _DomainState extends State<Domain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Whitelist Domain"),
        backgroundColor: PrimaryColors(),
      ),
      body: Stack(
        children: [
          Container(
            width: double.maxFinite,
            height: double.maxFinite,
            color: SecondaryColors(),
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Tambah White List Domain",
                    style: TextStyle(
                      color: PrimaryColors(),
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                children: [
                  FutureBuilder(
                    future: getDomainData(),
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: snapshot.requireData.length,
                            itemBuilder: (context,i){
                              return Container(
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    snapshot.requireData[i]['domain'],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: FontSizeMedium(),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
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
          )
        ],
      ),
    );
  }
}
