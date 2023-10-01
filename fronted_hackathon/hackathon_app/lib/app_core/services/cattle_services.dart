import 'package:hackathon_app/app_core/iservices/icattle_services.dart';
import 'package:hackathon_app/domain/interfaces/icattle_model.dart';
import 'package:hackathon_app/domain/models/Entities/cattle.dart';

class CattleServices implements ICattleServices {
  ICattleModel iCattleModel;

  CattleServices({required this.iCattleModel});

  @override
  Future<int> create(Cattle t) async {
    return await iCattleModel.create(t);
  }

  @override
  Future<bool> delete(Cattle t) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<Cattle>> getAllCattleByGroup(int groupId) async {
    return await iCattleModel.getAllCattleByGroup(groupId);
  }

  @override
  Future<Cattle> getCattle(int cattleId) {
    // TODO: implement getCattle
    throw UnimplementedError();
  }

  @override
  Future<List<Cattle>> read() {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<bool> update(Cattle t) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
