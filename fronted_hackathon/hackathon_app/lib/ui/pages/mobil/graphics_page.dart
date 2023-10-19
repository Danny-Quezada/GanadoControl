import 'package:flutter/material.dart';
import 'package:hackathon_app/provider/cattle_provider.dart';
import 'package:hackathon_app/provider/cow_calving_provider.dart';
import 'package:hackathon_app/provider/physical_problem_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphicsPage extends StatelessWidget {
  GraphicsPage({super.key, required this.IdUsuario});

  int IdUsuario;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Gráficos",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Graphics(
              IdUsuario: IdUsuario,
            ),
          ),
        ],
      ),
    );
  }
}

class Graphics extends StatelessWidget {
  Graphics({super.key, required this.IdUsuario});

  int IdUsuario;

  @override
  Widget build(BuildContext context) {
    final problemaProvider =
        Provider.of<PhysicalProblemProvider>(context, listen: false);
    final cattleProvider = Provider.of<CattleProvider>(context, listen: false);
    final cowCalvingProvider =
        Provider.of<CowCalvingProvider>(context, listen: false);
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
              child: Text(
            "Ganado no vacunado",
            style: TextStyle(fontSize: 16),
          )),
          FutureBuilder<List<BarDataPoint>>(
            future: cattleProvider.getGraphicsByCattle(IdUsuario),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // Mostrar un indicador de carga mientras esperas.
              } else if (snapshot.hasError) {
                return Text(
                    'Error: ${snapshot.error}'); // Mostrar un error si algo sale mal.
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Text(
                    'No data available'); // Mostrar un mensaje si no hay datos.
              } else {
                return BarChartWidget(
                    dataPoints: snapshot
                        .data!); // Renderizar el gráfico de barras con los datos.
              }
            },
          ),
          SizedBox(height: 30),
          Center(
              child: Text(
            "Partes dañadas de las vacas",
            style: TextStyle(fontSize: 16),
          )),
          FutureBuilder<List<PieDataPoint>>(
            future: problemaProvider.getGraphicsByPhysicalProblems(IdUsuario),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Ocurrió un error');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Text('No hay datos disponibles');
              } else {
                return PieChartWidget(dataPoints: snapshot.data!);
              }
            },
          ),
          SizedBox(height: 30),
          Center(
              child: Text(
            "No de partos",
            style: TextStyle(fontSize: 16),
          )),
          FutureBuilder<List<AreaDataPoint>>(
            future: cowCalvingProvider.getGraphictoCalving(IdUsuario),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                    child: Text('Ocurrió un error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data == null) {
                return Center(child: Text('No hay datos disponibles.'));
              } else {
                return AreaChartWidget(dataPoints: snapshot.data!);
              }
            },
          ),
        ],
      ),
    );
  }
}

class PieChartWidget extends StatelessWidget {
  final List<PieDataPoint> dataPoints;

  PieChartWidget({required this.dataPoints});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: SfCircularChart(
        legend: Legend(isVisible: true),
        series: <CircularSeries>[
          PieSeries<PieDataPoint, String>(
            dataSource: dataPoints,
            dataLabelMapper: (PieDataPoint data, _) =>
                '${((data.cantidad / dataPoints.fold(0, (sum, item) => sum + item.cantidad)) * 100).toStringAsFixed(2)}%',
            dataLabelSettings: DataLabelSettings(isVisible: true),
            xValueMapper: (PieDataPoint data, _) => data.nombreParte,
            yValueMapper: (PieDataPoint data, _) => data.cantidad,
          )
        ],
      ),
    );
  }
}

class BarChartWidget extends StatelessWidget {
  final List<BarDataPoint> dataPoints;

  BarChartWidget({required this.dataPoints});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        series: <BarSeries<BarDataPoint, String>>[
          BarSeries<BarDataPoint, String>(
            dataSource: dataPoints,
            xValueMapper: (BarDataPoint data, _) => data.categoria,
            yValueMapper: (BarDataPoint data, _) => data.valor,
          )
        ],
      ),
    );
  }
}

class AreaChartWidget extends StatelessWidget {
  final List<AreaDataPoint> dataPoints;

  AreaChartWidget({required this.dataPoints});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      series: <ChartSeries>[
        AreaSeries<AreaDataPoint, String>(
          dataSource: dataPoints,
          xValueMapper: (AreaDataPoint data, _) => data.category,
          yValueMapper: (AreaDataPoint data, _) => data.value,
          dataLabelSettings: DataLabelSettings(isVisible: true),
        )
      ],
    );
  }
}
