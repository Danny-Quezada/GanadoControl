import 'package:hackathon_app/app_core/iservices/iphysical_problem_services.dart';
import 'package:hackathon_app/domain/interfaces/iphysical_problem_model.dart';
import 'package:hackathon_app/domain/models/Entities/physical_problem.dart';

class PhysicalProblemsServices implements IPhysicalProblemServices {
  IPhysicalProblemModel iPhysicalProblemModel;

  PhysicalProblemsServices({required this.iPhysicalProblemModel});

  @override
  Future<int> create(PhysicalProblem t) async {
    return await iPhysicalProblemModel.create(t);
  }

  @override
  Future<bool> delete(PhysicalProblem t) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<PhysicalProblem>> getPhysicalProblemByCattle(
      String IdCattle) async {
    return await iPhysicalProblemModel.getPhysicalProblemByCattle(IdCattle);
  }

  @override
  Future<List<PhysicalProblem>> read() {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<bool> update(PhysicalProblem t) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> getGraphicByPhysicalProblems(
      int IdUsuario) async {
    return await iPhysicalProblemModel.getGraphicByPhysicalProblems(IdUsuario);
  }
}
