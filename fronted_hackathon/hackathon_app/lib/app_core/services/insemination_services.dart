import 'package:hackathon_app/app_core/iservices/iinsemination_services.dart';
import 'package:hackathon_app/domain/interfaces/iinsermination_model.dart';
import 'package:hackathon_app/domain/models/Entities/insemination.dart';

class InseminationServices implements IInseminationServices {
  IInseminationModel iInseminationModel;

  InseminationServices({required this.iInseminationModel});

  @override
  Future<int> create(Insemination t) async {
    return await iInseminationModel.create(t);
  }

  @override
  Future<bool> delete(Insemination t) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<Insemination>> read() {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<bool> update(Insemination t) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
