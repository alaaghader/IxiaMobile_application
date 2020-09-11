import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ixiamobile_application/Api/Models/company.dart';
import 'package:ixiamobile_application/Api/Requests/company.dart';

class MapsDemo extends StatefulWidget {
  @override
  MapsDemoState createState() => MapsDemoState();
}

class MapsDemoState extends State<MapsDemo> {
  Completer<GoogleMapController> _controller = Completer();
  MapType _currentMapType = MapType.normal;
  static LatLng _center;
  LatLng _lastMapPosition = _center;
  Position currentLocation;
  Future<void> getCurrentPosition;
  final Set<Marker> _markers = {};
  final companyApi = CompanyApi();
  Future<List<Company>> companies;
  List<Company> companiesLocation;

  @override
  void initState() {
    super.initState();
    getCurrentPosition = getUserLocation();
  }

  Future<List<Company>> locateCompanies() async {
    List<Company> companies = await companyApi.getCompaniesAsync();
    return companies;
  }

  getCompaniesLocation() async {
    companiesLocation = await locateCompanies();
    setState(() {
      for (int i = 0; i < companiesLocation.length; i++) {
        setState(() {
          _markers.add(
            Marker(
              markerId: MarkerId(companiesLocation[i].name),
              position:
                  LatLng(companiesLocation[i].lat, companiesLocation[i].lon),
              infoWindow: InfoWindow(title: companiesLocation[i].name),
            ),
          );
        });
      }
    });
  }

  Future<Position> locateUser() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  getUserLocation() async {
    await getCompaniesLocation();
    currentLocation = await locateUser();
    setState(() {
      _center = LatLng(currentLocation.latitude, currentLocation.longitude);
    });
    List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(
        _center.latitude.toString().length > 9
            ? double.parse(_center.latitude.toString().substring(0, 8))
            : _center.latitude,
        _center.longitude.toString().length > 9
            ? double.parse(_center.longitude.toString().substring(0, 8))
            : _center.longitude);
    print(placemark[0].country);
  }

  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Ixia',
          style: TextStyle(
            fontSize: 25,
            fontFamily: 'Montserrat',
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: FutureBuilder(
        future: getCurrentPosition,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: <Widget>[
                GoogleMap(
                  markers: _markers,
                  myLocationEnabled: true,
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 11.0,
                  ),
                  mapType: _currentMapType,
                  onCameraMove: _onCameraMove,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 60.0, vertical: 10.0),
                    height: 100.0,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: companiesLocation
                          .map((e) => Container(
                                child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            width: 50,
                                            height: 90,
                                            child: ClipRRect(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      24.0),
                                              child: Image(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                    "https://images.unsplash.com/photo-1504940892017-d23b9053d5d4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60"),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.all(15.0),
                                            width: 50,
                                            height: 90,
                                            child: Text(e.name),
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        _gotoLocation(e.lat, e.lon);
                                      },
                                    )),
                              ))
                          .toList(),
                    ),
                  ),
                ),
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 15,
      tilt: 50.0,
      bearing: 45.0,
    )));
  }
}
