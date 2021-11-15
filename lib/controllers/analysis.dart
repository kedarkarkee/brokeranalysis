import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

import '../model/floorsheet.dart';
import '../model/analyzedsheet.dart';
import '../model/broker.dart';

class AnalysisController extends GetxController {
  static const _baseUrl = 'www.nepalstock.com';
  static const _headers = {
    'User-Agent':
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.131 Safari/537.36'
  };
  final _analyzedbuysheets = <AnalyzedSheet>[];
  final _analyzedsellsheets = <AnalyzedSheet>[];
  num totalBuyQty = 0;
  num totalSellQty = 0;
  bool isBuyLoading = true;
  bool isSellLoading = true;
  final Broker broker;

  AnalysisController(this.broker);

  List<AnalyzedSheet> get analyzedbuysheets => _analyzedbuysheets;
  List<AnalyzedSheet> get analyzedsellsheets => _analyzedsellsheets;
  @override
  void onReady() {
    super.onReady();
    loadBuyFloorsheets().then((value) => loadSellFloorsheets());
  }

  Future<void> loadBuyFloorsheets() async {
    final uri = Uri.http(_baseUrl, 'floorsheet');
    final bodyData = {'buyer': broker.code.toString(), '_limit': '50000'};
    final res = await http.post(uri, body: bodyData, headers: _headers);
    final document = parser.parse(res.body);
    final table = document.querySelectorAll('table.table.my-table>tbody>tr');
    final fTable = table.sublist(2, table.length - 3);
    fTable.forEach((m) {
      final td = m.querySelectorAll('td');
      final f = Floorsheet(td[1].text, td[2].text, td[3].text, td[4].text,
          num.parse(td[5].text), num.parse(td[6].text), num.parse(td[7].text));
      final index = _analyzedbuysheets.indexWhere((e) => e.symbol == f.symbol);
      totalBuyQty += f.qty;
      final sheet = AnalyzedSheet(f.symbol, f.qty, f.rate, f.rate, f.amount);
      if (index == -1) {
        _analyzedbuysheets.add(sheet);
      } else {
        _analyzedbuysheets[index] += sheet;
      }
    });
    _analyzedbuysheets.sort((a, b) => b.qty.compareTo(a.qty));
    isBuyLoading = false;
    update();
  }

  Future<void> loadSellFloorsheets() async {
    final uri = Uri.http(_baseUrl, 'floorsheet');
    final bodyData = {'seller': broker.code.toString(), '_limit': '50000'};
    final res = await http.post(uri, body: bodyData, headers: _headers);
    final document = parser.parse(res.body);
    final table = document.querySelectorAll('table.table.my-table>tbody>tr');
    final fTable = table.sublist(2, table.length - 3);
    fTable.forEach((m) {
      final td = m.querySelectorAll('td');
      final f = Floorsheet(td[1].text, td[2].text, td[3].text, td[4].text,
          num.parse(td[5].text), num.parse(td[6].text), num.parse(td[7].text));
      final index = _analyzedsellsheets.indexWhere((e) => e.symbol == f.symbol);
      totalSellQty += f.qty;
      final sheet = AnalyzedSheet(f.symbol, f.qty, f.rate, f.rate, f.amount);
      if (index == -1) {
        _analyzedsellsheets.add(sheet);
      } else {
        _analyzedsellsheets[index] += sheet;
      }
    });
    _analyzedsellsheets.sort((a, b) => b.qty.compareTo(a.qty));
    isSellLoading = false;
    update();
  }
}
