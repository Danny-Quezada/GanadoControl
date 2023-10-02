import 'package:hackathon_app/app_core/iservices/iservices.dart';
import 'package:hackathon_app/domain/models/Entities/meditation.dart';

abstract class IMeditationServices extends IServices<Meditation>{
  
  Future<List<Meditation>> getMeditationByFarm(int FarmId);
}