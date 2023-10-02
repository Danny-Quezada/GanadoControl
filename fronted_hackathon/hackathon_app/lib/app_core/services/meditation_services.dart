import 'package:hackathon_app/app_core/iservices/imeditation_services.dart';
import 'package:hackathon_app/domain/interfaces/imeditation_model.dart';
import 'package:hackathon_app/domain/models/Entities/meditation.dart';

class MeditationServices implements IMeditationServices{


  IMeditationModel iMeditationModel;

  MeditationServices({required this.iMeditationModel});
  @override
  Future<int> create(Meditation t)async {
   return await iMeditationModel.create(t);
  }

  @override
  Future<bool> delete(Meditation t) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<Meditation>> getMeditationByFarm(int FarmId)async {
   return await iMeditationModel.getMeditationByFarm(FarmId);
  }

  @override
  Future<List<Meditation>> read() {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<bool> update(Meditation t) {
    // TODO: implement update
    throw UnimplementedError();
  }

}