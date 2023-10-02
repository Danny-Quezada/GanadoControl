import 'package:hackathon_app/domain/interfaces/imodel.dart';
import 'package:hackathon_app/domain/models/Entities/meditation.dart';

abstract class  IMeditationModel extends IModel<Meditation>{


  Future<List<Meditation>> getMeditationByFarm(int FarmId);
}