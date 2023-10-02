class Constant {
  static const String route = "http://192.168.1.14:5000/api";
  static const String createUser = "${route}/Usuario/";
  static const String getUser = "${route}/Usuario/verificar";
  static const String userChangeState = "${route}/Usuario/estado";

  static const String createFarm = "${route}/Finca";
  static const String getFarms = "${route}/Finca/Usuario";

  static const String createGroup = "${route}/Grupo";
  static const String getGroups = "${route}/Grupo/Finca";

  static const String createTreatment = "${route}/Tratamiento";
  static const String getTreatmentByFarm = "${route}/Tratamiento/Finca";

  static const String creatCattle = "${route}/Ganado";
  static const String getCattle = "${route}/Ganado/Grupo";

  static const String createMeditation="${route}/Farmaco";
  static const String getMeditationbyFarm="${route}/Farmaco/finca";
}
