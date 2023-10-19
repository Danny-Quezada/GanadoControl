import 'package:hackathon_app/domain/interfaces/imodel.dart';
import 'package:hackathon_app/domain/models/Entities/cow_calving.dart';

abstract class ICowCalvingModel extends IModel<CowCalving> {
  Future<Map<String, dynamic>> getGraphicsByCowCalving(int IdUsuario);
}
