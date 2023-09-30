import 'package:hackathon_app/domain/interfaces/iflock_model.dart';
import 'package:hackathon_app/domain/models/Entities/flock.dart';

import '../iservices/iflock_services.dart';

class FlockServices implements IFlockServices{

  IFlockModel iFlockModel;

  FlockServices({required this.iFlockModel});
  @override
  Future<int> create(Flock t)async {
    return await iFlockModel.create(t);
  }

  @override
  Future<bool> delete(Flock t) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<Flock>> getAllFlockByFinca(int farmId) async {
    return await iFlockModel.getAllFlockByFinca(farmId);
  }

  @override
  Future<Flock> getFlock(int flockId) {
    // TODO: implement getFlock
    throw UnimplementedError();
  }

  @override
  Future<List<Flock>> read() {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<bool> update(Flock t) {
    // TODO: implement update
    throw UnimplementedError();
  }



}