import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong2/latlong.dart';

import '../constants/app_constants.dart';

class LocationAdd extends StatefulWidget {
  final LatLng? locationData;

  const LocationAdd({
    Key? key,
    this.locationData,
  }) : super(key: key);

  @override
  State<LocationAdd> createState() => _LocationAddState();
}

class _LocationAddState extends State<LocationAdd> {
  LatLng? location;

  late final MapController mapController;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    if (widget.locationData != null) {
      location = widget.locationData;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              onTap: (tapPosition, point) => {
                setState(() {
                  location = point;
                }),
                mapController.move(location ?? AppConstants.myLocation, 11.0),
              },
              minZoom: 5,
              maxZoom: 18,
              zoom: 11,
              center: AppConstants.myLocation,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate:
                    "https://api.mapbox.com/styles/v1/reynaldi18/{mapStyleId}/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}",
                additionalOptions: {
                  'mapStyleId': AppConstants.mapBoxStyleId,
                  'accessToken': AppConstants.mapBoxAccessToken,
                },
              ),
              MarkerLayerOptions(
                markers: [
                  Marker(
                    width: 44.0,
                    height: 44.0,
                    point: location ?? AppConstants.myLocation,
                    builder: (context) => SvgPicture.asset(
                      'assets/icons/map_marker.svg'
                    )
                  ),
                ],
              ),
            ],
          ),
          location != null
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 36,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(
                          context,
                          location ?? widget.locationData,
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                8.0,
                              ),
                              side: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Pilih',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
