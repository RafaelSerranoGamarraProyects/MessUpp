import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../models/objetive.dart';
import 'widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class ObjetiveView2 extends StatelessWidget {
	final Objetive objetive;
	const ObjetiveView2({super.key, required this.objetive});
	

	@override
	Widget build(BuildContext context) {
		if(objetive.id == ""){
			return Stack(
			children:  const [
			 Background(),
			 Center(child: Text("No objetive set for the moment", 
			 				style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),)
			)
			]);
		}
		else {
			return Stack(
			children:  [
			 const Background(),
			 ObjetiveScreenBody2(objetive: objetive,)
			]);
		}

	}
}

class ObjetiveScreenBody2 extends StatelessWidget {
  final Objetive objetive;
	const ObjetiveScreenBody2({
    Key? key, required this.objetive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
			children: [
				Padding(
				  padding: const EdgeInsets.all(8.0),
				  child: Text(objetive.description,
				   style: const TextStyle(color: Colors.white, fontSize: 24,fontWeight: FontWeight.bold),),
				),

				CategoriesProgress(),
				const Divider(color: Colors.white, thickness: 2,),
				const TopDaysChart2(),
			],
    );
  }
}

class TopDaysChart2 extends StatelessWidget {
	 static List<_ChartData> data = [
    _ChartData('VIER', 40),
    _ChartData('JUEV', 32),
    _ChartData('MIER', 34),
    _ChartData('MAR', 28),
    _ChartData('LUN', 35),
  ];
  const TopDaysChart2({
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

class CategoriesProgress extends StatelessWidget {
	final List<String> categories = ["Viaje", "Ocio", "Alimentacion",];
	final Map<String, IconData> categoryMap ={
		"Alimentacion" : Icons.fastfood_rounded,
		"Ocio" : Icons.sports_esports_rounded,
		"Viaje" : Icons.travel_explore_outlined
	};


  CategoriesProgress({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
		
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: SizedBox(
				height: 600,
				child: ListView.builder(
							itemCount: categories.length,
							itemBuilder:(context, index) => CircularProgress(category: categories[index], iconCategory: categoryMap[categories[index]]!),
						),
			),
    );
  }
}

class CircularProgress extends StatelessWidget {
	final String category;
	final IconData iconCategory;

  const CircularProgress({
    Key? key, required this.category, required this.iconCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
		final double percentaje;
    return CircularPercentIndicator(
			
    	radius: 60.0,
    	lineWidth: 10.0,
    	percent: 0.6,
    	backgroundColor: Colors.white,
    	
    	center: Icon(iconCategory, color: Colors.white),
    	progressColor: Colors.greenAccent,
    );
  }
}


   class _ChartData {
    	final String day;
    	final double amount;
			_ChartData(this.day, this.amount);
		}
