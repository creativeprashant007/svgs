class DeliveryAddress {
  final String id;
  final String shipCustId;
  final String shipName;
  final String email;
  final String shipMobile;
  final String shipAddress;
  final String shipLandmark;
  final String shipPinCode;
  final String shipAreaId;
  final String shipArea;
  final String shipCity;
  final String shipState;
  final String shipCountry;
  final String shipDefaultAdd;
  final String shipLastEdit;
  final String shipEditIp;
  final String shipAddStatus;
  bool isSelected;

  DeliveryAddress({
    this.id,
    this.shipCustId,
    this.shipName,
    this.email,
    this.shipMobile,
    this.shipAddress,
    this.shipLandmark,
    this.shipPinCode,
    this.shipAreaId,
    this.shipArea,
    this.shipCity,
    this.shipState,
    this.shipCountry,
    this.shipDefaultAdd,
    this.shipLastEdit,
    this.shipEditIp,
    this.shipAddStatus,
    this.isSelected = false,
  });
}
