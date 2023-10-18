import 'package:hackathon_app/domain/interfaces/imodel.dart';
import 'package:hackathon_app/domain/models/Entities/farm.dart';

abstract class IFarmModel extends IModel<Farm>{
  Future<List<Farm>> getAllFarmByUser(int userId);
  Future<Farm> getFarm(int farmId);
  Future<String> inviteToFarm(int farmId, String role,int userId);

  Future<int> joinFarm(String token,int userId);

}