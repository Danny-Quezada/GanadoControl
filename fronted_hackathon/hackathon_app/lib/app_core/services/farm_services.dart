import 'package:hackathon_app/app_core/iservices/ifarm_services.dart';
import 'package:hackathon_app/domain/interfaces/ifarm_model.dart';
import 'package:hackathon_app/domain/models/Entities/farm.dart';

class FarmServices implements IFarmServices{

  IFarmModel ifarmModel;

  FarmServices({required this.ifarmModel});

  @override
  Future<int> create(Farm t) async{
    return await ifarmModel.create(t);
  }

  @override
  Future<bool> delete(Farm t) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<Farm>> getAllFarmByUser(int userId) async{
    return await ifarmModel.getAllFarmByUser(userId);
  }

  @override
  Future<Farm> getFarm(int farmId) {
    // TODO: implement getFarm
    throw UnimplementedError();
  }

  @override
  Future<List<Farm>> read() {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<bool> update(Farm t) {
    // TODO: implement update
    throw UnimplementedError();
  }

}