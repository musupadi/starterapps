String RegisterGmail(){
  return "management/registergmail";
}
String LoginGmail(){
  return "management/logingmail";
}
String Login(){
  return "management/login";
}


//Customized
String DataDesign(){
  return "management/design";
}

String DataDomain(){
  return "management/domain";
}
String getDesign(){
  return "management/designdata";
}
String getCustomDesign(String id){
  return "management/customdesign?id_preset=$id";
}
String getPresetList(String id){
  return "management/listpreset?id_design=$id";
}
String getCategory(String id_preset){
  return "listcategory?id_design_detail=$id_preset";
}
String UpdateCustomDesign(){
  return "management/updatecustomdesign";
}


//Project
String StringReadProject(String id_user,String status){
  return "project/read?id_user=$id_user&status=$status";
}
String StringGetNamaProject(String nama){
  return "project/getnama=$nama";
}

String StringWhereReadProject(String id_user,String id_project,String status){
  return "project/read?id_user=$id_user&id_project=$id_project&status=$status";
}
String StringReadTask(String id_user,String id_project){
  return "task/read?id_user=$id_user&id_project=$id_project";
}
String StringWhereReadRealization(String id_user,String id_task){
  return "realization/read?id_user=$id_user&id_task=$id_task";
}
String StringProgressProject(String id_project,String id_user,String status){
  return "project/progress?id_project=$id_project&id_user=$id_user&status=$status";
}
String StringProgressTask(String id_task,String id_user){
  return "task/progress?id_task=$id_task&id_user=$id_user";
}
String StringSearchUser(String nama,String level){
  return "user/search?nama=$nama&level=$level";
}
String StringUserReadAll(){
  return "user/readall";
}
String StringSearchProjectName(String name){
  return "project/getnama?name=$name";
}
String StringSearchTaskName(String name){
  return "task/getnama?name=$name";
}
String StringUpdateStatusProject(){
  return "project/changestatus";
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

