import 'package:hackathon_app/app_core/iservices/icow_calving_services.dart';
import 'package:hackathon_app/domain/interfaces/icow_calving_model.dart';
import 'package:hackathon_app/domain/models/Entities/cow_calving.dart';

class CowCalvingServices implements ICowCalvingServices {
  ICowCalvingModel iCowCalvingModel;

  CowCalvingServices({required this.iCowCalvingModel});

  @override
  Future<int> create(CowCalving t) async {
    return await iCowCalvingModel.create(t);
  }

  @override
  Future<bool> delete(CowCalving t) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<CowCalving>> read() {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<bool> update(CowCalving t) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
