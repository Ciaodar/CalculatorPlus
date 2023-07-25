class Calculation {
  final String? id, name;
  final double input1;
  final double input2;
  final String operation;
  final double result;
  Calculation(
      {this.id,
      this.name,
      required this.input1,
      required this.input2,
      required this.operation,
      required this.result});

  factory Calculation.fromJson(Map<String, dynamic> json) {
    return Calculation(
      input1: json['input1'] as double,
      input2: json['input2'] as double,
      operation: json['operation'] as String,
      result: json['result'] as double,
    );
  }
/*
  factory Calculation.fromString(){
    return null;
  }
*/
}

