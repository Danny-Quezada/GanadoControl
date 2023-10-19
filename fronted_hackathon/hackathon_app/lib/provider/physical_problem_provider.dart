import 'package:flutter/material.dart';
import 'package:flutter_provider_utilities/flutter_provider_utilities.dart';
import 'package:hackathon_app/app_core/iservices/iphysical_problem_services.dart';
import 'package:hackathon_app/domain/models/Entities/physical_problem.dart';
import 'package:hackathon_app/provider/igeneric_provider.dart';
import 'dart:convert';

class PhysicalProblemProvider extends ChangeNotifier
    with IGenericProvider<PhysicalProblem>, MessageNotifierMixin {
  @override
  void doNull() {
    t = null;
    list = null;
  }

  IPhysicalProblemServices _iPhysicalProblemServices;

  PhysicalProblemProvider(
      {required IPhysicalProblemServices iPhysicalProblemServices})
      : _iPhysicalProblemServices = iPhysicalProblemServices;

  Future<void> create(PhysicalProblem physicalProblem) async {
    try {
      int physicalValue =
          await _iPhysicalProblemServices.create(physicalProblem);
      if (physicalValue >= 0) {
        physicalProblem.physicalProblemId = physicalValue;
        t = physicalProblem;
        list!.add(t!);
        t = null;
        notifyInfo(
            "Problema fisico creado para la vaca: ${physicalProblem.cattleId}");
      }
    } catch (e) {
      notifyError("Error en el servidor");
    }
    notifyListeners();
  }

  Future<List<PhysicalProblem>> getPhysicalProblemByCattle(
      String IdCattle) async {
    if (list != null) {
      return list!;
    }

    list = await _iPhysicalProblemServices.getPhysicalProblemByCattle(IdCattle);
    notifyListeners();
    return list!;
  }

  Future<List<PieDataPoint>> getGraphicsByPhysicalProblems(
      int IdUsuario) async {
    Map<String, dynamic> responseBody =
        await _iPhysicalProblemServices.getGraphicByPhysicalProblems(IdUsuario);
    if (responseBody.isEmpty ||
        responseBody['data'] == null ||
        responseBody['data'].isEmpty) {
      return [PieDataPoint("Ninguna parte", 1)];
    }

    return fromJson(responseBody['data']);
  }

  List<PieDataPoint> fromJson(List<dynamic> responseList) {
    return responseList.map((data) => PieDataPoint.fromJson(data)).toList();
  }
}

class PieDataPoint {
  final String nombreParte;
  final int cantidad;

  PieDataPoint(this.nombreParte, this.cantidad);

  factory PieDataPoint.fromJson(Map<String, dynamic> json) {
    return PieDataPoint(
      json["nombreParte"],
      json["cantidad"] ?? 0,
    );
  }
}
