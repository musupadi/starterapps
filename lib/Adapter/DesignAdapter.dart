import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:project_management/Constant/colors.dart';
import 'package:project_management/Serverside/Server.dart';

class DesignAdapter extends StatefulWidget {
  String id_design;
  String name;
  String description;
  String preview;
  String status;
  String point;
  DesignAdapter({Key? key,
    required this.id_design,
    required this.name,
    required this.description,
    required this.preview,
    required this.status,
    required this.point
  });

  @override
  State<DesignAdapter> createState() => _DesignAdapterState();
}

class _DesignAdapterState extends State<DesignAdapter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: PrimaryColors(),
          width: 0.5
        ),
        image: DecorationImage(
          image: NetworkImage(BaseURL()+widget.preview),
          fit: BoxFit.fill,
        )
      ),
    );
  }
}
