import 'package:hackathon_app/app_core/iservices/iservices.dart';
import 'package:hackathon_app/domain/models/Entities/cattle.dart';

abstract class ICattleServices extends IServices<Cattle> {
  Future<List<Cattle>> getAllCattleByGroup(int groupId);
  Future<Cattle> getCattle(String cattleId);
  Future<String> createCattle(Cattle t);
  Future<Map<String, dynamic>> getGraphicsByCatlle(int IdUsuario);
}
