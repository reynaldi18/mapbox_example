import 'package:latlong2/latlong.dart';

class MapMarker {
  final String? image;
  final String? title;
  final String? owner;
  final String? address;
  final LatLng? location;

  MapMarker({
    required this.image,
    required this.title,
    required this.owner,
    required this.address,
    required this.location,
  });
}

final mapMarkers = [
  MapMarker(
    image: 'assets/images/restaurant_1.jpg',
    title: 'Sumur Resapan Satu',
    owner: 'Reynaldi P',
    address:
        'Jl. Diponegoro No.57, Cihaur Geulis, Kec. Cibeunying Kaler, Kota Bandung, Jawa Barat 40122',
    location: LatLng(-6.895949771067142, 107.620669402689),
  ),
  MapMarker(
    image: 'assets/images/restaurant_2.jpg',
    title: 'Sumur Resapan Dua',
    owner: 'Reynaldi P',
    address:
        'Jl. Banten, Kebonwaru, Kec. Batununggal, Kota Bandung, Jawa Barat 40272',
    location: LatLng(-6.912309764810107, 107.64109710545708),
  ),
  MapMarker(
    image: 'assets/images/restaurant_3.jpg',
    title: 'Sumur Resapan Tiga',
    owner: 'Reynaldi P',
    address:
        'Jl. Peta No.229, Suka Asih, Kec. Bojongloa Kaler, Kota Bandung, Jawa Barat 40242',
    location: LatLng(-6.927305928298107, 107.58753875870379),
  ),
  MapMarker(
    image: 'assets/images/restaurant_4.jpg',
    title: 'Sumur Resapan Empat',
    owner: 'Reynaldi P',
    address:
        '3M9H+75G, Bandung, Kec. Arcamanik, Kota Bandung, Jawa Barat 40293',
    location: LatLng(-6.929010007631212, 107.67851928363726),
  ),
  MapMarker(
    image: 'assets/images/restaurant_5.jpg',
    title: 'Sumur Resapan Lima',
    owner: 'Reynaldi P',
    address:
        'Jl. Maribaya No.120 A, Langensari, Kec. Lembang, Kabupaten Bandung Barat, Jawa Barat 40391',
    location: LatLng(-6.822322826557873, 107.63732055536549),
  ),
];
