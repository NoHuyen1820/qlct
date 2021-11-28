import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:qlct/components/chart/pie_data.dart';
import 'package:qlct/model/transaction.dart';
import '../../constants.dart';
import 'indicator.dart';

class PieFinanceChart extends StatefulWidget {

  final List<Transaction> transactions;

  const PieFinanceChart({
    Key? key,
    required this.transactions,
  }) : super(key: key);

  @override
  PieFinanceChartState createState() => PieFinanceChartState();
}

class PieFinanceChartState extends State<PieFinanceChart> {
  int touchedIndex = -1;

  List<PieSectionData> data = [];
  List<Indicator> indi = [];

  @override
  void initState() {
    data = processingData(widget.transactions);
    indi = processingDataToIndicator();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            children: <Widget>[
              const SizedBox(
                height: 18,
              ),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: PieChart(
                    PieChartData(
                        pieTouchData: PieTouchData(touchCallback:
                            (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                          });
                        }),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 40,
                        sections: showingSections()),
                  ),
                ),
              ),
              // Column(
              //   mainAxisSize: MainAxisSize.max,
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: <Widget>[
              //     Indicator(
              //       color: categoryColors[1]!,
              //       text: categorySelect[1]!,
              //       isSquare: true,
              //     ),
              //     const SizedBox(
              //       height: 4,
              //     ),
              //     Indicator(
              //       color: categoryColors[2]!,
              //       text: categorySelect[2]!,
              //       isSquare: true,
              //     ),
              //     const SizedBox(
              //       height: 4,
              //     ),
              //     Indicator(
              //       color: categoryColors[3]!,
              //       text: categorySelect[3]!,
              //       isSquare: true,
              //     ),
              //     const SizedBox(
              //       height: 4,
              //     ),
              //     Indicator(
              //       color: categoryColors[4]!,
              //       text: categorySelect[4]!,
              //       isSquare: true,
              //     ),
              //     const SizedBox(
              //       height: 4,
              //     ),
              //     Indicator(
              //       color: categoryColors[5]!,
              //       text: categorySelect[5]!,
              //       isSquare: true,
              //     ),
              //     const SizedBox(
              //       height: 4,
              //     ),
              //     Indicator(
              //       color: categoryColors[6]!,
              //       text: categorySelect[6]!,
              //       isSquare: true,
              //     ),
              //     const SizedBox(
              //       height: 4,
              //     ),
              //     Indicator(
              //       color: categoryColors[7]!,
              //       text: categorySelect[7]!,
              //       isSquare: true,
              //     ),
              //     const SizedBox(
              //       height: 4,
              //     ),
              //     Indicator(
              //       color: categoryColors[8]!,
              //       text: categorySelect[8]!,
              //       isSquare: true,
              //     ),
              //     const SizedBox(
              //       height: 4,
              //     ),
              //     Indicator(
              //       color: categoryColors[9]!,
              //       text: categorySelect[9]!,
              //       isSquare: true,
              //     ),
              //     const SizedBox(
              //       height: 4,
              //     ),
              //     Indicator(
              //       color: categoryColors[10]!,
              //       text: categorySelect[10]!,
              //       isSquare: true,
              //     ),
              //     const SizedBox(
              //       height: 4,
              //     ),
              //     Indicator(
              //       color: categoryColors[11]!,
              //       text: categorySelect[11]!,
              //       isSquare: true,
              //     ),
              //     const SizedBox(
              //       height: 4,
              //     ),
              //     Indicator(
              //       color: categoryColors[12]!,
              //       text: categorySelect[12]!,
              //       isSquare: true,
              //     ),
              //     const SizedBox(
              //       height: 4,
              //     ),
              //     Indicator(
              //       color: categoryColors[0]!,
              //       text: categorySelect[0]!,
              //       isSquare: true,
              //     ),
              //     const SizedBox(
              //       height: 4,
              //     ),
              //   ],
              // ),
              Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: indi
              ),
              const SizedBox(
                width: 28,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() => data
      .asMap()
      .map<int, PieChartSectionData>((index, data) {
        final value = PieChartSectionData(
          color: data.color,
          value: data.percent,
          title: data.name,
          titleStyle: const TextStyle(
            fontSize: 13,
            color: Color(0xffffffff),
          ),
        );
        return MapEntry(index, value);
      })
      .values
      .toList();
    // return List.generate(4, (i) {
    //   final isTouched = i == touchedIndex;
    //   final fontSize = isTouched ? 25.0 : 16.0;
    //   final radius = isTouched ? 60.0 : 50.0;
    //   switch (i) {
    //     case 0:
    //       return PieChartSectionData(
    //         color: const Color(0xff0293ee),
    //         value: 1,
    //         title: '40%',
    //         radius: radius,
    //         titleStyle: TextStyle(
    //             fontSize: fontSize,
    //             fontWeight: FontWeight.bold,
    //             color: const Color(0xffffffff)),
    //       );
    //     case 1:
    //       return PieChartSectionData(
    //         color: const Color(0xfff8b250),
    //         value: 1,
    //         title: '30%',
    //         radius: radius,
    //         titleStyle: TextStyle(
    //             fontSize: fontSize,
    //             fontWeight: FontWeight.bold,
    //             color: const Color(0xffffffff)),
    //       );
    //     case 2:
    //       return PieChartSectionData(
    //         color: const Color(0xff845bef),
    //         value: 1,
    //         title: '15%',
    //         radius: radius,
    //         titleStyle: TextStyle(
    //             fontSize: fontSize,
    //             fontWeight: FontWeight.bold,
    //             color: const Color(0xffffffff)),
    //       );
    //     case 3:
    //       return PieChartSectionData(
    //         color: const Color(0xff13d38e),
    //         value: 1,
    //         title: '15%',
    //         radius: radius,
    //         titleStyle: TextStyle(
    //             fontSize: fontSize,
    //             fontWeight: FontWeight.bold,
    //             color: const Color(0xffffffff)),
    //       );
    //     default:
    //       throw Error();
    //   }
    // });
  // }

    Map<int, PieSectionData> map = <int, PieSectionData>{};
  List<PieSectionData> processingData(List<Transaction> transactions) {
    map = <int, PieSectionData>{};
    for (Transaction trans in transactions) {

      if (map.containsKey(trans.category)) {
        PieSectionData p = map[trans.category]!;
        p.percent += double.parse(trans.amount);
        map[trans.category!] = p;
      } else {
        PieSectionData p = PieSectionData(
            name: categorySelect[trans.category]!,
            percent: double.parse(trans.amount),
            color: categoryColors[trans.category]!,
        );
        map[trans.category!] = p;
      }

    }
    map.forEach((key, value) => data.add(value));
    return data;
  }

  List<Indicator> processingDataToIndicator() {
    indi = [];
    map.forEach((key, value) => indi.add(Indicator(
        color: categoryColors[key]!,
        text: categorySelect[key]!,
        isSquare: true)));
    return indi;
  }
}
