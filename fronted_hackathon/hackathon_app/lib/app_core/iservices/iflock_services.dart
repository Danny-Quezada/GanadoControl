import 'package:hackathon_app/app_core/iservices/iservices.dart';
import 'package:hackathon_app/domain/models/Entities/flock.dart';

abstract class IFlockServices extends IServices<Flock>{
    Future<List<Flock>> getAllFlockByFinca(int farmId);
  Future<Flock> getFlock(int flockId);
}