class Calculation {
  final String? id, name;
  final double input1;
  final double input2;
  final String operation;
  final double result;
  Calculation(this.id,this.name,this.input1, this.input2, this.operation, this.result);

  factory Calculation.fromJson(String id, String? name,Map<String, dynamic> json) {
    return Calculation(
      id,name,
      json['input1'] as double,
      json['input2'] as double,
      json['operation'] as String,
      json['result'] as double,
    );
  }
/*
  factory Calculation.fromString(){
    return null;
  }
*/
}

