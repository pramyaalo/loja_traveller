class AirlinesDDL{
  String Id, Name;

//<editor-fold desc="Data Methods">

  AirlinesDDL({
    required this.Id,
    required this.Name,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AirlinesDDL &&
          runtimeType == other.runtimeType &&
          Id == other.Id &&
          Name == other.Name);

  @override
  int get hashCode => Id.hashCode ^ Name.hashCode;

  @override
  String toString() {
    return 'AirlinesDDL{' + ' Id: $Id,' + ' Name: $Name,' + '}';
  }

  AirlinesDDL copyWith({
    String? Id,
    String? Name,
  }) {
    return AirlinesDDL(
      Id: Id ?? this.Id,
      Name: Name ?? this.Name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Id': this.Id,
      'Name': this.Name,
    };
  }

  factory AirlinesDDL.fromMap(Map<String, dynamic> map) {
    return AirlinesDDL(
      Id: map['Id'].toString() as String,
      Name: map['Name'].toString() as String,
    );
  }

//</editor-fold>
}