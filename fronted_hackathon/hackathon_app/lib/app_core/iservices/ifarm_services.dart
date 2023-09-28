import 'package:hackathon_app/app_core/iservices/iservices.dart';
import 'package:hackathon_app/domain/models/Entities/farm.dart';

abstract class IFarmServices extends IServices<Farm>{
    Future<List<Farm>> getAllFarmByUser(int userId);
  Future<Farm> getFarm(int farmId);
}