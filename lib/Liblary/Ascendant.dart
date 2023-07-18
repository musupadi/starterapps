import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project_management/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

import '../Constant/Size.dart';
import '../Serverside/Server.dart';
final String _adUnitId = Platform.isAndroid
    ? 'ca-app-pub-3940256099942544/1033173712'
    : 'ca-app-pub-3940256099942544/4411468910';
var headers = {
  'Content-type': 'application/json',
  "Accept": "application/json",
  "Access-Control-Allow-Origin": APIBaseURL(),
  "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
  "Access-Control-Allow-Headers": " Origin, Content-Type, Accept, Authorization, X-Request-With",
};
Map<String,String> headerBuilder(String token) {
  return headers = {
    'Content-type': 'application/json',
    "Accept": "application/json",
    "Access-Control-Allow-Origin": APIBaseURL(),
    "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
    "Access-Control-Allow-Headers": " Origin, Content-Type, Accept, Authorization, X-Request-With",
    "token": token
  };
}
Map<String,String> headerBuilderPost(String token) {
  return headers = {
    "Accept": "application/json",
    "Access-Control-Allow-Origin": APIBaseURL(),
    "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
    "Access-Control-Allow-Headers": " Origin, Content-Type, Accept, Authorization, X-Request-With",
    "token": token
  };
}
Widget NotFound(String text){
  return Container(
    height: 400,
    width: double.maxFinite,
    child: Center(
      child: Stack(
        children: [
          Lottie.asset(
            "assets/lottie/notfound.json",
            width: 300,
            height: 300,
            repeat: true,
          ),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Container(
                margin: EdgeInsets.only(bottom: 100),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: FontSizeLarge()
                  ),
                )
            ),
          )
        ],
      ),
    ),
  );
}
void Logout(BuildContext context) async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  // FailedMessage("Contoh ", name.toString(), context);

  await pref.clear();

  Navigator.push(
      context,
      PageRouteBuilder(
          transitionDuration: Duration(seconds: 1),
          transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secAnimation,
              Widget child) {
            animation = CurvedAnimation(
                parent: animation,
                curve: Curves.elasticInOut
            );
            return ScaleTransition(
              scale: animation,
              child: child,
              alignment: Alignment.center,
            );
          },
          pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secAnimation
              )
          {
            return Login();
          }
      )
  );
}
FailedMessage (String title,String desc,BuildContext context){
  AwesomeDialog(
      context: context,
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: false,
      dialogType: DialogType.error,
      animType: AnimType.scale,
      title: title,
      desc: desc,
      btnOkOnPress: () {

      },
      headerAnimationLoop: false
  )..show();
}
void Heatmap(BuildContext context){
  HeatMap(
    datasets: {
      DateTime(2021, 1, 6): 3,
      DateTime(2021, 1, 7): 7,
      DateTime(2021, 1, 8): 10,
      DateTime(2021, 1, 9): 13,
      DateTime(2021, 1, 13): 6,
    },
    colorMode: ColorMode.opacity,
    showText: false,
    scrollable: true,
    colorsets: {
      1: Colors.red,
      3: Colors.orange,
      5: Colors.yellow,
      7: Colors.green,
      9: Colors.blue,
      11: Colors.indigo,
      13: Colors.purple,
    },
    onClick: (value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.toString())));
    },
  );
}

Map<DateTime, int>? datasetData(List Data){
  // String Year=Date.substring(0,4);
  // String Month=Date.substring(5,7);
  // String Day=Date.substring(8,10);
  Map<DateTime, int> dataSet = {

  };
  for (var i = 0; i < Data.length; i++) {
    Map<DateTime, int> SetData = {
      DateTime(
          int.parse(Data[i].toString().substring(0,4)),
          int.parse(Data[i].toString().substring(5,7)),
          int.parse(Data[i].toString().substring(8,10))
      ): 1,
      // DateTime(2023, 7, 7): 1,
    };
    dataSet.addAll(SetData);
  }
  return dataSet;
}
HeatMapCalendar Calendar(BuildContext context,List Tanggal,TextEditingController PilihanTanggal,TextEditingController DateController){
  return HeatMapCalendar(
    defaultColor: Colors.white,
    flexible: true,
    colorMode: ColorMode.color,
    showColorTip: false,
    datasets: datasetData(Tanggal),
    colorsets: const {
      1: Colors.red,
    },
    onClick: (value) {
      PilihanTanggal.text=value.toString();
      DateController.text = DateBuilder(PilihanTanggal.text);
    },
  );
}
void localHTML(WebViewController controller,String html) async {
  String dataString = html;
  // final url = Uri.dataFromString(widget.content_news,mimeType: 'text/html',encoding: Encoding.getByName('utf-8')).toString();
  // var contentBase64 = base64Encode(const Utf8Encoder()
  //     .convert(
  //     """<!DOCTYPE html>
  //     <html>
  //       <head><meta name="viewport" content="width=device-width, initial-scale=1.0"></head>
  //       <body style='"margin: 0; padding: 0;'>
  //         <div>
  //           $dataString
  //         </div>
  //       </body>
  //     </html>"""));
  String HTMLBuilder = "<!DOCTYPE html><html><head><meta name=viewport content=width=device-width, initial-scale=1.0></head><body>"
      +dataString+
      "</body></html>";
  controller.loadHtmlString(HTMLBuilder);
}
LogoutMessage (String title,String desc,BuildContext context){
  AwesomeDialog(
      context: context,
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: false,
      dialogType: DialogType.warning,
      animType: AnimType.scale,
      title: title,
      desc: desc,
      btnOkOnPress: () {
        Logout(context);
      },
      btnCancelOnPress: (){

      },
      headerAnimationLoop: false
  )..show();
}
AwesomeDialog DataNIK(
    String id_user,
    String name_user,
    String level_user,
    String image_user,
    String ktp_user,
    String nik_user,
    String jk_user,
    String phone_number,
    String birth_date,
    String address_user,
    String nama_kecamatan,
    String nama_desa,
    String status_user,
    String tps,
    String rt,
    String rw,
    BuildContext context
    ){
  return AwesomeDialog(
      context: context,
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: false,
      dialogType: DialogType.noHeader,
      animType: AnimType.scale,
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Colors.black,width: 1),
                  image: DecorationImage(
                      image: NetworkImage(image_user),
                      fit: BoxFit.cover
                  )
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              name_user,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: FontSizeXXLarge()
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              nik_user,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: FontSizeMedium()
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: FractionalOffset.center,
              child: Text(
                "Data User",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: FontSizeMedium(),
                    fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              color: Colors.black,
              height: 1,
              width: double.maxFinite,
            ),
            SizedBox(
              height: 10,
            ),
            //JK
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: Pembatas(),
                  child: Text(
                      "Jenis Kelamin"
                  ),
                ),
                Text(": "),
                Expanded(
                  child: Text(
                      jk_user == "L" ? "Laki-laki" : "Perempuan"
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            //Tgl Lahir
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: Pembatas(),
                  child: Text(
                      "Tgl Lahir"
                  ),
                ),
                Text(": "),
                Expanded(
                  child: Text(
                      DateBuilder(birth_date)
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            //Kecamatan
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: Pembatas(),
                  child: Text(
                      "Kecamatan"
                  ),
                ),
                Text(": "),
                Expanded(
                  child: Text(
                      nama_kecamatan
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            //Desa
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: Pembatas(),
                  child: Text(
                      "Desa"
                  ),
                ),
                Text(": "),
                Expanded(
                  child: Text(
                      nama_desa
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            //RT
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: Pembatas(),
                  child: Text(
                      "RT"
                  ),
                ),
                Text(": "),
                Expanded(
                  child: Text(
                      rt
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            //RW
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: Pembatas(),
                  child: Text(
                      "RW"
                  ),
                ),
                Text(": "),
                Expanded(
                  child: Text(
                      rw
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            //TPS
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: Pembatas(),
                  child: Text(
                      "TPS"
                  ),
                ),
                Text(": "),
                Expanded(
                  child: Text(
                      tps=="" ? "-" : tps
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: Pembatas(),
                  child: Text(
                      "Nomor Telpon"
                  ),
                ),
                Text(": "),
                Expanded(
                  child: Text(
                      phone_number
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Tutup",
                  style: TextStyle(
                      color: Colors.white
                  ),
                )
            )
          ],
        ),
      ),
      headerAnimationLoop: false
  );
}
AwesomeDialog Message(String Message,BuildContext context){
  return AwesomeDialog(
      context: context,
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: true,
      dialogType: DialogType.warning,
      animType: AnimType.topSlide,
      desc: Message,
      btnCancelText: "Tutup",
      btnCancelOnPress: () {

      },
      headerAnimationLoop:false
  )..show();
}
AwesomeDialog InfoData(String Message,BuildContext context,String InfoTitle){
  WebViewController controller=new WebViewController();
  localHTML(controller,Message);
  return AwesomeDialog(
      context: context,
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: true,
      dialogType: DialogType.noHeader,
      animType: AnimType.topSlide,
      body: Column(
        children: [
          Text(InfoTitle,textAlign: TextAlign.center,style: TextStyle(fontSize: FontSizeLarge(),fontWeight: FontWeight.bold)),
          Container(
            height: 500,
            child: WebViewWidget(
              controller: controller,
            ),
          ),
        ],
      ),
      btnCancelText: "Tutup",
      btnCancelOnPress: () {

      },
      headerAnimationLoop:false
  )..show();
}
String HTMLEraser(String HTML){
  String Stage1=HTML.replaceAll('<p>','');
  String Stage2=Stage1.replaceAll('</p>','');
  String Stage3=Stage2.replaceAll('Google&#39;s ','');
  String Stage4=Stage3.replaceAll('<em>','');
  String Stage5=Stage4.replaceAll('</em>','');
  String Stage6=Stage5.replaceAll('</em>','');
  String Stage7=Stage6.replaceAll('<strong>','');
  String Stage8=Stage7.replaceAll('</strong>','');
  return Stage8;
}



String StringDivider(String dataString,int MaxLength){
  if(dataString.length<MaxLength){
    return dataString;
  }else{
    return dataString.substring(0, MaxLength)+"...";
  }
}
double CalculatePercentage(double value,double total){
  double percentage=(value) / (total) * 100;
  return percentage;
}

String DateBuilder(String Date){
  String Year=Date.substring(0,4);
  String Month=Date.substring(5,7);
  String Day=Date.substring(8,10);
  
  return Day+" "+MonthChanger(Month)+" "+Year;
  
}
String OneSignalAppId(){
  String OneSignal = "f7221318-7c72-4c22-809c-c1a9b3636ca9";
  return OneSignal;
}
String MonthChanger(String Month){
  String month="Januari";
  if(Month=="01" || Month=="1"){
    month="Januari";
  }else if(Month=="02" || Month=="2"){
    month="Februari";
  }else if(Month=="03" || Month=="3"){
    month="Maret";
  }else if(Month=="04" || Month=="4"){
    month="April";
  }else if(Month=="05" || Month=="5"){
    month="Mei";
  }else if(Month=="06" || Month=="6"){
    month="Juni";
  }else if(Month=="07" || Month=="7"){
    month="Juli";
  }else if(Month=="08" || Month=="8"){
    month="Agustus";
  }else if(Month=="09" || Month=="9"){
    month="September";
  }else if(Month=="10" || Month=="10"){
    month="Oktober";
  }else if(Month=="11" || Month=="11"){
    month="November";
  }else if(Month=="12" || Month=="12"){
    month="Desember";
  }
  return month;
}