import 'package:flutter/material.dart';

class UserAdapter extends StatefulWidget {
  TextEditingController IDUser= new TextEditingController();
  String id_user;
  String nama;
  String level;
  UserAdapter({
      Key? key,
      required this.IDUser,
      required this.id_user,
      required this.nama,
      required this.level
    }
  )
  ;

  @override
  State<UserAdapter> createState() => _UserAdapterState();
}

class _UserAdapterState extends State<UserAdapter> {
  bool pilih=false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          widget.IDUser.text = widget.id_user;
          pilih=true;
        });
      },
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: widget.IDUser.text == widget.id_user ? Colors.red : Colors.white,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(widget.nama),
              Container(
                color: Colors.red,
                width: double.maxFinite,
                height: 1,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                  widget.level
              ),
            ],
          ),
        ),
      ),
    );
  }
}
