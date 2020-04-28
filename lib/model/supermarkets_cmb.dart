import 'package:google_maps_flutter/google_maps_flutter.dart';

class SuperMarkets {
  String shopName;
  String address;
  String description;
  String thumbNail;
  LatLng locationCoords;

  SuperMarkets(
      {this.shopName,
      this.address,
      this.description,
      this.thumbNail,
      this.locationCoords});
}

List<SuperMarkets> superMarketShopList() {
  final List<SuperMarkets> superMarketsShops = [
    SuperMarkets(
        shopName: 'Laugfs Supermarket Kaduwela',
        address: 'AB10, Kaduwela',
        description: 'Open From 7am to 11pm',
        locationCoords: LatLng(6.939484, 79.981927),
        thumbNail:
            'https://drive.google.com/uc?id=1t3ohT5DZP_kwRrsFwZoxsbO38dOc_vF5'),
    SuperMarkets(
        shopName: 'Laugfs Supermarket Kotte',
        address: 'Sri Jayawardenepura Kotte',
        description: 'All Day Open',
        locationCoords: LatLng(6.896029, 79.928025),
        thumbNail:
            'https://drive.google.com/uc?id=1t3ohT5DZP_kwRrsFwZoxsbO38dOc_vF5'),
    SuperMarkets(
        shopName: 'Laugfs Supermarket Hokandara',
        address: 'Hokandara Rd, Hokandara',
        description: 'Open From 7am to 11pm',
        locationCoords: LatLng(6.884270, 79.959611),
        thumbNail:
            'https://drive.google.com/uc?id=1t3ohT5DZP_kwRrsFwZoxsbO38dOc_vF5'),
    SuperMarkets(
        shopName: 'Laugfs Colombo 06',
        address: '351 Galle Rd, Colombo',
        description: 'All Day Open',
        locationCoords: LatLng(6.871983, 79.862257),
        thumbNail:
            'https://drive.google.com/uc?id=1t3ohT5DZP_kwRrsFwZoxsbO38dOc_vF5'),
    SuperMarkets(
        shopName: 'Laugfs Havelock PL',
        address: 'No.252 Havelock Pl',
        description: 'description',
        locationCoords: LatLng(6.886201, 79.865874),
        thumbNail:
            'https://drive.google.com/uc?id=1t3ohT5DZP_kwRrsFwZoxsbO38dOc_vF5'),
    SuperMarkets(
        shopName: 'Laugfs Colombo 06',
        address: '351 Galle Rd, Colombo',
        description: 'Open From 8am to 11pm',
        locationCoords: LatLng(6.871983, 79.862257),
        thumbNail:
            'https://drive.google.com/uc?id=1t3ohT5DZP_kwRrsFwZoxsbO38dOc_vF5'),
    SuperMarkets(
        shopName: 'Laugfs Supermarket Rajagiriya',
        address: '1070, Rajagiriya, Kotte',
        description: 'All Day Open',
        locationCoords: LatLng(6.911966, 79.901938),
        thumbNail:
            'https://drive.google.com/uc?id=1t3ohT5DZP_kwRrsFwZoxsbO38dOc_vF5'),
    SuperMarkets(
        shopName: 'Laugfs Super Maharagama',
        address: '129 High Level Rd',
        description: 'All Day Open',
        locationCoords: LatLng(6.847892, 79.929955),
        thumbNail:
            'https://drive.google.com/uc?id=1t3ohT5DZP_kwRrsFwZoxsbO38dOc_vF5'),
    SuperMarkets(
        shopName: 'Laugfs Supermarket',
        address: 'Horana Rd, Boralesgamuwa',
        description: 'Open From 7am to 11pm',
        locationCoords: LatLng(6.846675, 79.902867),
        thumbNail:
            'https://drive.google.com/uc?id=1t3ohT5DZP_kwRrsFwZoxsbO38dOc_vF5'),
    SuperMarkets(
        shopName: 'Laugfs Supermarket Kottawa',
        address: '364, Avissawella Rd, Pannipitiya',
        description: 'Open From 7am to 11pm',
        locationCoords: LatLng(6.847477, 79.963236),
        thumbNail:
            'https://drive.google.com/uc?id=1t3ohT5DZP_kwRrsFwZoxsbO38dOc_vF5'),
    SuperMarkets(
        shopName: 'Laugfs Super Mirihana',
        address: 'Mirihana - Udahamulla',
        description: 'Open From 7am to 11pm',
        locationCoords: LatLng(6.878202, 79.900479),
        thumbNail:
            'https://drive.google.com/uc?id=1t3ohT5DZP_kwRrsFwZoxsbO38dOc_vF5'),
  ];

  return superMarketsShops;
}
