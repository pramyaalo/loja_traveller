class PassengerDDL{

  String Id, Name, Age;

//<editor-fold desc="Data Methods">

  PassengerDDL({
    required this.Id,
    required this.Name,
    required this.Age,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PassengerDDL &&
          runtimeType == other.runtimeType &&
          Id == other.Id &&
          Name == other.Name &&
          Age == other.Age);

  @override
  int get hashCode => Id.hashCode ^ Name.hashCode ^ Age.hashCode;

  @override
  String toString() {
    return 'PassengerDDL{' +
        ' Id: $Id,' +
        ' Name: $Name,' +
        ' Age: $Age,' +
        '}';
  }

  PassengerDDL copyWith({
    String? Id,
    String? Name,
    String? Age,
  }) {
    return PassengerDDL(
      Id: Id ?? this.Id,
      Name: Name ?? this.Name,
      Age: Age ?? this.Age,
    );
  }

  Map toJson() {
    return {
      'Id': this.Id,
      'Name': this.Name,
      'Age': this.Age,
    };
  }

 Map<String, dynamic> toMap() {
    return {
      'Id': this.Id,
      'Name': this.Name,
      'Age': this.Age,
    };
  }

  factory PassengerDDL.fromMap(Map<String, dynamic> map) {
    return PassengerDDL(
      Id: map['Id'].toString() as String,
      Name: map['Name'].toString() as String,
      Age: map['Age'].toString() as String,
    );
  }



//</editor-fold>
}