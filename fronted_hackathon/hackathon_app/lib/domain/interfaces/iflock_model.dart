import 'package:hackathon_app/domain/interfaces/imodel.dart';
import 'package:hackathon_app/domain/models/Entities/flock.dart';

abstract class IFlockModel extends IModel<Flock>{

  Future<List<Flock>> getAllFlockByFinca(int farmId);
  Future<Flock> getFlock(int flockId);





}