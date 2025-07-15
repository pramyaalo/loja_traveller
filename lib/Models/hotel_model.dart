
class HotelModel{

  String HotelName, Address, Phone, Currency, TotalPrice, ImageUrl, RoomOffer, Amenities, ItemID, FirstImage, SecondImage;
  String ThirdImage, FourthImage, TotalGuestCount;
  String StarCategory, TravelPolicy, PricePerPerson;

//<editor-fold desc="Data Methods">

  HotelModel({
    required this.HotelName,
    required this.Address,
    required this.Phone,
    required this.Currency,
    required this.TotalPrice,
    required this.ImageUrl,
    required this.RoomOffer,
    required this.Amenities,
    required this.ItemID,
    required this.FirstImage,
    required this.SecondImage,
    required this.ThirdImage,
    required this.FourthImage,
    required this.TotalGuestCount,
    required this.TravelPolicy,
    required this.PricePerPerson,
    required this.StarCategory,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HotelModel &&
          runtimeType == other.runtimeType &&
          HotelName == other.HotelName &&
          Address == other.Address &&
          Phone == other.Phone &&
          Currency == other.Currency &&
          TotalPrice == other.TotalPrice &&
          ImageUrl == other.ImageUrl &&
          RoomOffer == other.RoomOffer &&
          Amenities == other.Amenities &&
          ItemID == other.ItemID &&
          FirstImage == other.FirstImage &&
          SecondImage == other.SecondImage &&
          ThirdImage == other.ThirdImage &&
          FourthImage == other.FourthImage &&
          TotalGuestCount == other.TotalGuestCount &&
          TravelPolicy == other.TravelPolicy &&
          PricePerPerson == other.PricePerPerson &&
          StarCategory == other.StarCategory);

  @override
  int get hashCode =>
      HotelName.hashCode ^
      Address.hashCode ^
      Phone.hashCode ^
      Currency.hashCode ^
      TotalPrice.hashCode ^
      ImageUrl.hashCode ^
      RoomOffer.hashCode ^
      Amenities.hashCode ^
      ItemID.hashCode ^
      FirstImage.hashCode ^
      SecondImage.hashCode ^
      ThirdImage.hashCode ^
      FourthImage.hashCode ^
      TotalGuestCount.hashCode ^
      TravelPolicy.hashCode ^
      PricePerPerson.hashCode ^
      StarCategory.hashCode;

  @override
  String toString() {
    return 'HotelModel{' +
        ' HotelName: $HotelName,' +
        ' Address: $Address,' +
        ' Phone: $Phone,' +
        ' Currency: $Currency,' +
        ' TotalPrice: $TotalPrice,' +
        ' ImageUrl: $ImageUrl,' +
        ' RoomOffer: $RoomOffer,' +
        ' Amenities: $Amenities,' +
        ' ItemID: $ItemID,' +
        ' FirstImage: $FirstImage,' +
        ' SecondImage: $SecondImage,' +
        ' ThirdImage: $ThirdImage,' +
        ' FourthImage: $FourthImage,' +
        ' TotalGuestCount: $TotalGuestCount,' +
        ' TravelPolicy: $TravelPolicy,' +
        ' PricePerPerson: $PricePerPerson,' +
        ' StarCategory: $StarCategory,' +
        '}';
  }

  HotelModel copyWith({
    String? HotelName,
    String? Address,
    String? Phone,
    String? Currency,
    String? TotalPrice,
    String? ImageUrl,
    String? RoomOffer,
    String? Amenities,
    String? ItemID,
    String? FirstImage,
    String? SecondImage,
    String? ThirdImage,
    String? FourthImage,
    String? TotalGuestCount,
    String? TravelPolicy,
    String? PricePerPerson,
    String? StarCategory,
  }) {
    return HotelModel(
      HotelName: HotelName ?? this.HotelName,
      Address: Address ?? this.Address,
      Phone: Phone ?? this.Phone,
      Currency: Currency ?? this.Currency,
      TotalPrice: TotalPrice ?? this.TotalPrice,
      ImageUrl: ImageUrl ?? this.ImageUrl,
      RoomOffer: RoomOffer ?? this.RoomOffer,
      Amenities: Amenities ?? this.Amenities,
      ItemID: ItemID ?? this.ItemID,
      FirstImage: FirstImage ?? this.FirstImage,
      SecondImage: SecondImage ?? this.SecondImage,
      ThirdImage: ThirdImage ?? this.ThirdImage,
      FourthImage: FourthImage ?? this.FourthImage,
      TotalGuestCount: TotalGuestCount ?? this.TotalGuestCount,
      TravelPolicy: TotalGuestCount ?? this.TravelPolicy,
      PricePerPerson: TotalGuestCount ?? this.PricePerPerson,
      StarCategory: StarCategory ?? this.StarCategory,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'HotelName': this.HotelName,
      'Address': this.Address,
      'Phone': this.Phone,
      'Currency': this.Currency,
      'TotalPrice': this.TotalPrice,
      'ImageUrl': this.ImageUrl,
      'RoomOffer': this.RoomOffer,
      'Amenities': this.Amenities,
      'ItemID': this.ItemID,
      'FirstImage': this.FirstImage,
      'SecondImage': this.SecondImage,
      'ThirdImage': this.ThirdImage,
      'FourthImage': this.FourthImage,
      'TotalGuestCount': this.TotalGuestCount,
      'TravelPolicy': this.TravelPolicy,
      'PricePerPerson': this.PricePerPerson,
      'StarCategory': this.StarCategory,
    };
  }

  factory HotelModel.fromMap(Map<String, dynamic> map) {
    return HotelModel(
      HotelName: map['HotelName'].toString().toString() as String,
      Address: map['Address'].toString() as String,
      Phone: map['Phone'].toString() as String,
      Currency: map['Currency'].toString() as String,
      TotalPrice: map['TotalPrice'].toString() as String,
      ImageUrl: map['ImageUrl'].toString() as String,
      RoomOffer: map['RoomOffer'].toString() as String,
      Amenities: map['Amenities'].toString() as String,
      ItemID: map['ItemID'].toString() as String,
      FirstImage: map['FirstImage'].toString() as String,
      SecondImage: map['SecondImage'].toString() as String,
      ThirdImage: map['ThirdImage'].toString() as String,
      FourthImage: map['FourthImage'].toString() as String,
      TotalGuestCount: map['TotalGuestCount'].toString() as String,
      TravelPolicy: map['TravelPolicy'].toString() as String,
      PricePerPerson: map['PricePerPerson'].toString() as String,
      StarCategory: map['StarCategory'].toString() as String,
    );
  }

//</editor-fold>
}