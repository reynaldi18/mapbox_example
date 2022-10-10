import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gt_mapbox/pages/form_add.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/app_constants.dart';
import '../models/map_marker_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController searchController = TextEditingController();
  final pageController = PageController();
  var currentLocation = AppConstants.myLocation;
  List<MapMarker> listMarkerSearch = [];
  bool isSearch = false;

  late final MapController mapController;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    listMarkerSearch.addAll(mapMarkers);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: SizedBox(
          height: 44,
          width: 44,
          child: FloatingActionButton(
            onPressed: () {
              isSearch = false;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FormAdd()),
              ).then((value) {
                if (value != null) {
                  setState(() {
                    mapMarkers.add(value);
                    listMarkerSearch.addAll(mapMarkers);
                  });
                }
              });
            },
            elevation: 0,
            backgroundColor: Colors.white,
            shape: const BeveledRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            child: const Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
        ),
        body: Stack(
          children: [
            FlutterMap(
              options: MapOptions(
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
                    for (int i = 0; i < mapMarkers.length; i++)
                      Marker(
                        height: 40,
                        width: 40,
                        point:
                            mapMarkers[i].location ?? AppConstants.myLocation,
                        builder: (_) {
                          return GestureDetector(
                            onTap: () {
                              showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8),
                                      ),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const SizedBox(height: 8),
                                          Container(
                                            height: 200,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Image.asset(
                                              mapMarkers[i].image ?? '',
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            '${mapMarkers[i].location?.latitude ?? 0.0}, ${mapMarkers[i].location?.longitude ?? 0.0}',
                                            style: const TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            mapMarkers[i].title ?? '',
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            mapMarkers[i].address ?? '',
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black),
                                          ),
                                          const SizedBox(height: 4),
                                          const Text(
                                            'Braga Technologies',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black),
                                          ),
                                          const SizedBox(height: 4),
                                          InkWell(
                                            onTap: () => openMap(
                                              mapMarkers[i]
                                                      .location
                                                      ?.latitude ??
                                                  0.0,
                                              mapMarkers[i]
                                                      .location
                                                      ?.longitude ??
                                                  0.0,
                                            ),
                                            child: const Text(
                                              'Google Maps',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.blue),
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                          SizedBox(
                                            width: double.infinity,
                                            height: 36,
                                            child: ElevatedButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.white),
                                                shape:
                                                    MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      8.0,
                                                    ),
                                                    side: const BorderSide(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              child: const Text(
                                                'Kembali',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 32),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: SvgPicture.asset(
                              'assets/icons/map_marker.svg',
                            ),
                          );
                        },
                      ),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 18.0,
                          vertical: 8.0,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        suffixIcon: isSearch
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    FocusManager.instance.primaryFocus?.unfocus();
                                    searchController.clear();
                                    filterSearchResults(searchController.text);
                                  });
                                },
                                icon: const Icon(
                                  Icons.close,
                                  size: 16,
                                  color: Colors.black,
                                ))
                            : const Icon(
                                Icons.search,
                                size: 16,
                                color: Colors.black,
                              ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1.0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onChanged: (value) {
                        filterSearchResults(value);
                      },
                    ),
                    isSearch && listMarkerSearch.isNotEmpty
                        ? Container(
                            color: Colors.white,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: listMarkerSearch.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () {
                                    showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              topRight: Radius.circular(8),
                                            ),
                                            color: Colors.white,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const SizedBox(height: 8),
                                                Container(
                                                  height: 200,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Image.asset(
                                                    mapMarkers[index].image ??
                                                        '',
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  '${mapMarkers[index].location?.latitude ?? 0.0}, ${mapMarkers[index].location?.longitude ?? 0.0}',
                                                  style: const TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.grey),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  mapMarkers[index].title ?? '',
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  mapMarkers[index].address ??
                                                      '',
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black),
                                                ),
                                                const SizedBox(height: 4),
                                                const Text(
                                                  'Braga Technologies',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black),
                                                ),
                                                const SizedBox(height: 4),
                                                InkWell(
                                                  onTap: () => openMap(
                                                    mapMarkers[index]
                                                            .location
                                                            ?.latitude ??
                                                        0.0,
                                                    mapMarkers[index]
                                                            .location
                                                            ?.longitude ??
                                                        0.0,
                                                  ),
                                                  child: const Text(
                                                    'Google Maps',
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.blue),
                                                  ),
                                                ),
                                                const SizedBox(height: 16),
                                                SizedBox(
                                                  width: double.infinity,
                                                  height: 36,
                                                  child: ElevatedButton(
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(
                                                                  Colors.white),
                                                      shape: MaterialStateProperty
                                                          .all<
                                                              RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            8.0,
                                                          ),
                                                          side:
                                                              const BorderSide(
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    child: const Text(
                                                      'Kembali',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 32),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  title: Text(
                                    listMarkerSearch[index].title ?? '',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> openMap(double latitude, double longitude) async {
    final Uri url = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  void filterSearchResults(String query) {
    List<MapMarker> dummySearchList = [];
    dummySearchList.addAll(mapMarkers);
    if (query.isNotEmpty) {
      List<MapMarker> dummyListData = [];
      for (var item in dummySearchList) {
        if (item.title?.contains(query) == true) {
          dummyListData.add(item);
        }
      }
      setState(() {
        isSearch = true;
        listMarkerSearch.clear();
        listMarkerSearch.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        isSearch = false;
        listMarkerSearch.clear();
        listMarkerSearch.addAll(mapMarkers);
      });
    }
  }
}
