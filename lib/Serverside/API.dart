String RegisterGmail(){
  return "projectmanagement/registergmail";
}
String LoginGmail(){
  return "projectmanagement/logingmail";
}
String Login(){
  return "projectmanagement/login";
}


//Customized
String DataDesign(){
  return "projectmanagement/design";
}

String DataDomain(){
  return "projectmanagement/domain";
}
String getDesign(){
  return "projectmanagement/designdata";
}
String getCustomDesign(String id){
  return "projectmanagement/customdesign?id_preset=$id";
}
String getPresetList(String id){
  return "projectmanagement/listpreset?id_design=$id";
}
String getCategory(String id_preset){
  return "listcategory?id_design_detail=$id_preset";
}
String UpdateCustomDesign(){
  return "projectmanagement/updatecustomdesign";
}
String StringReadProject(String id_user){
  return "project/read?id_user=$id_user";
}
String StringWhereReadProject(String id_user,String id_project){
  return "project/read?id_user=$id_user&id_project=$id_project";
}
String StringReadTask(String id_user,String id_project){
  return "task/read?id_user=$id_user&id_project=$id_project";
}
String StringWhereReadRealization(String id_user,String id_task){
  return "realization/read?id_user=$id_user&id_task=$id_task";
}
String StringProgressProject(String id_project,String id_user){
  return "project/progress?id_project=$id_project&id_user=$id_user";
}
String StringProgressTask(String id_task,String id_user){
  return "task/progress?id_task=$id_task&id_user=$id_user";
}
String StringSearchUser(String nama,String level){
  return "user/search?nama=$nama&level=$level";
}
String StringCreateProject(){
  return "project/create";
}
String StringCreateTask(){
  return "task/create";
}

String StringCreateRealization(){
  return "realization/create";
}

