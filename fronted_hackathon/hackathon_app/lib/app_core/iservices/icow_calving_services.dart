import 'package:hackathon_app/app_core/iservices/iservices.dart';
import 'package:hackathon_app/domain/models/Entities/cow_calving.dart';

abstract class ICowCalvingServices extends IServices<CowCalving> {
  Future<Map<String, dynamic>> getGraphicByCowCalving(int IdUsuario);
}
