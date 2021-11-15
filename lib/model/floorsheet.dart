class Floorsheet {
  final String contractNo;
  final String symbol;
  final String buyer;
  final String seller;
  final num qty;
  final num rate;
  final num amount;

  Floorsheet(this.contractNo, this.symbol, this.buyer, this.seller, this.qty,
      this.rate, this.amount);

  @override
  String toString() {
    return 'Floorsheet(contractNo: $contractNo, symbol: $symbol, buyer: $buyer, seller: $seller, qty: $qty, rate: $rate, amount: $amount)';
  }
}
