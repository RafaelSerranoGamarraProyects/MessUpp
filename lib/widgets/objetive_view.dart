import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:tfg_app/providers/objetives_provider.dart';
import 'widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class ObjetiveView extends StatelessWidget {
	const ObjetiveView({super.key});
	

	@override
	Widget build(BuildContext context) {
		return ChangeNotifierProvider(
			create: (_) => ObjetivesProvider(), lazy: false,
			child: Stack(
				children: const  [
					Background(),
					ObjetiveScreenBody()
				]),
			);
		
	}
}

class ObjetiveScreenBody extends StatelessWidget {
	const ObjetiveScreenBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
		final objetivesProvider = Provider.of<ObjetivesProvider>(context);
    return Column(
			children: [
				Padding(
				  padding: const EdgeInsets.all(8.0),
				  child: Text(objetivesProvider.monthlyObjetive.description,
				   style: const TextStyle(color: Colors.white, fontSize: 24,fontWeight: FontWeight.bold),),
				),

				const DescriptionAndProgress(),
				const Divider(color: Colors.white, thickness: 2,),
				const TopDaysChart(),
			],
    );
  }
}

class TopDaysChart extends StatelessWidget {
	 static List<_ChartData> data = [
    _ChartData('VIER', 40),
    _ChartData('JUEV', 32),
    _ChartData('MIER', 34),
    _ChartData('MAR', 28),
    _ChartData('LUN', 35),
  ];
  const TopDaysChart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
              primaryXAxis: CategoryAxis(isVisible: true,labelStyle: const TextStyle(color: Colors.white,fontSize: 16, fontWeight: FontWeight.bold)),
							primaryYAxis: CategoryAxis(isVisible: false),
							 
              series: <ChartSeries<_ChartData, String>>[
                BarSeries<_ChartData, String>(
								
									gradient: const LinearGradient(colors:
									 [Color.fromARGB(255, 158, 253, 188),Color.fromRGBO(137,220,205, 1)],),
                    dataSource: data,
                    xValueMapper: (_ChartData expenses, _) => expenses.day,
                    yValueMapper: (_ChartData expenses, _) => expenses.amount,
                    
			                    // Enable data label
								)

              ]);
  }
}

class DescriptionAndProgress extends StatelessWidget {
  const DescriptionAndProgress({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
		final double percentaje; 
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(children: [
      	const Expanded(
      	  child:  Text("Esse occaecat adipisicing cupidatat cillum Lorem. Ut dolore ipsum nisi occaecat ex magna fugiat est. Est enim velit velit velit pariatur sunt Lorem veniam veniam magna ea esse nostrud laboris.",
      	   style: TextStyle(color: Colors.white, fontSize: 16),),
      	),

      	 Expanded(
      		child: CircularPercentIndicator(
      			radius: 60.0,
      			lineWidth: 10.0,
      			percent: 0.6,
      			backgroundColor: Colors.white,
      			
      			center: const Text("60%",style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
      			progressColor: Colors.greenAccent,
      		),
      	),
      ],),
    );
  }
}


   class _ChartData {
    	final String day;
    	final double amount;
			_ChartData(this.day, this.amount);
		}
