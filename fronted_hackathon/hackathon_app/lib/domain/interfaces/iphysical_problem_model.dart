import 'package:hackathon_app/domain/interfaces/imodel.dart';
import 'package:hackathon_app/domain/models/Entities/physical_problem.dart';

abstract class IPhysicalProblemModel extends IModel<PhysicalProblem> {
  Future<List<PhysicalProblem>> getPhysicalProblemByCattle(String IdCattle);
  Future<Map<String, dynamic>> getGraphicByPhysicalProblems(int IdUsuario);
}
