class Calculation {
  int? id;
  String username;
  String operation;
  double freq63;
  double freq125;
  double freq250;
  double freq500;
  double freq1000;
  double freq2000;
  double freq4000;
  double freq8000;
  double result;
  String createdAt;

  Calculation({
    this.id,
    required this.username,
    required this.operation,
    required this.freq63,
    required this.freq125,
    required this.freq250,
    required this.freq500,
    required this.freq1000,
    required this.freq2000,
    required this.freq4000,
    required this.freq8000,
    required this.result,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'operation': operation,
      'freq63': freq63,
      'freq125': freq125,
      'freq250': freq250,
      'freq500': freq500,
      'freq1000': freq1000,
      'freq2000': freq2000,
      'freq4000': freq4000,
      'freq8000': freq8000,
      'result': result,
      'createdAt': createdAt,
    };
  }

  factory Calculation.fromMap(Map<String, dynamic> map) {
    return Calculation(
      id: map['id'],
      username: map['username'],
      operation: map['operation'],
      freq63: map['freq63'],
      freq125: map['freq125'],
      freq250: map['freq250'],
      freq500: map['freq500'],
      freq1000: map['freq1000'],
      freq2000: map['freq2000'],
      freq4000: map['freq4000'],
      freq8000: map['freq8000'],
      result: map['result'],
      createdAt: map['createdAt'],
    );
  }
}
