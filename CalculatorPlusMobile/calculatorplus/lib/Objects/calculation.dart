class Calculation {
  final String? id, name;

  final double input1;
  final double input2;
  final String operation;
  final double? result;
  Calculation(
      {this.id,
      this.name,
      required this.input1,
      required this.input2,
      required this.operation,
      required this.result});

  factory Calculation.fromJson({String? id,String? uname,required Map<String, dynamic> json}) {
    print(json);
    return Calculation(
      name: uname,
      id: id,
      input1: double.parse(json['input1'].toString()),
      input2: double.parse(json['input2'].toString()),
      operation: json['signOperation'] as String,
      result: double.parse(json['result'].toString()),
    );
  }
/*
  factory Calculation.fromString(){
    return null;
  }
*/
}

