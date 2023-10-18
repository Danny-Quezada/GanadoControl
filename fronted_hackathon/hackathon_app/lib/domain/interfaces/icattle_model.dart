import 'package:hackathon_app/domain/interfaces/imodel.dart';
import 'package:hackathon_app/domain/models/Entities/cattle.dart';

abstract class ICattleModel extends IModel<Cattle> {
  Future<List<Cattle>> getAllCattleByGroup(int groupId);
  Future<Cattle> getCattle(String cattleId);
  Future<String> createCattle(Cattle t);
}
