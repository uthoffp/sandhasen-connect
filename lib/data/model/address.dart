class Address {
  String city;
  String street;
  String postcode;
  String place;
  String? lat;
  String? long;

  Address(this.city, this.street, this.postcode, this.place);

  factory Address.fromSnapshot(Map<String, dynamic> snapshot) {
    return Address(
      snapshot['city'],
      snapshot['street'],
      snapshot['postcode'],
      snapshot['place'],
    );
  }

  String toMapsLocation() {
    return "$street, $postcode $city";
  }
}