String RegisterGmail(){
  return "registergmail";
}
String LoginGmail(){
  return "logingmail";
}
String Login(){
  return "login";
}


//Customized
String DataDesign(){
  return "design";
}

String DataDomain(){
  return "domain";
}
String getDesign(){
  return "designdata";
}
String getCustomDesign(String id){
  return "customdesign?id_preset=$id";
}
String getPresetList(String id){
  return "listpreset?id_design=$id";
}
String getCategory(String id_preset){
  return "listcategory?id_design_detail=$id_preset";
}
String UpdateCustomDesign(){
  return "updatecustomdesign";
}


