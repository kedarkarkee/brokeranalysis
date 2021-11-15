class AnalyzedSheet {
  final String symbol;
  final num qty;
  final num high;
  final num low;
  final num amount;

  AnalyzedSheet(this.symbol, this.qty, this.high, this.low, this.amount);

  AnalyzedSheet operator +(AnalyzedSheet other) {
    final h = high > other.high ? high : other.high;
    final l = low < other.low ? low : other.low;
    return AnalyzedSheet(symbol, qty + other.qty, h, l, amount + other.amount);
  }

  String percent(num total) {
    final p = (qty * 100) / total;
    return p.toStringAsFixed(2) + '%';
  }

  String get average => (amount / qty).toStringAsFixed(2);
}
