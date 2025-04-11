import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class CurrentLocationScreen extends StatefulWidget {
  const CurrentLocationScreen({super.key});

  @override
  State<CurrentLocationScreen> createState() => _CurrentLocationScreenState();
}

class _CurrentLocationScreenState extends State<CurrentLocationScreen> {
  LatLng? _currentPosition;
  String _locationStatus = 'Fetching location...';
  bool _isPopupVisible = false;  

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _locationStatus = 'Location services are disabled.';
      });
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _locationStatus =
              'Location permission is permanently denied, we cannot access your location.';
        });
        return;
      }
    }

    try {
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _locationStatus = 'Location fetched successfully.';
      });
    } catch (e) {
      setState(() {
        _locationStatus = 'Failed to get location: $e';
      });
    }
  }

  void _togglePopupVisibility() {
    setState(() {
      _isPopupVisible = !_isPopupVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Current Location')),
      body: _currentPosition == null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 20),
                  Text(
                    _locationStatus,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            )
          : Stack(
              children: [
                FlutterMap(
                  options: MapOptions(
                    center: _currentPosition,
                    zoom: 15.0,
                    onTap: (tapPosition, point) {
                     
                      if (_isPopupVisible) {
                        _togglePopupVisibility();
                      }
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c'],
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: _currentPosition!,
                          width: 60,
                          height: 60,
                          child: GestureDetector(
                            onTap: () {
                             
                              if (!_isPopupVisible) {
                                _togglePopupVisibility();
                              }
                            },
                            child: const Icon(
                              Icons.location_pin,
                              color: Colors.red,
                              size: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                
                if (_isPopupVisible)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: PopupWidget(
                      location: _currentPosition!,
                      onClose: _togglePopupVisibility,
                    ),
                  ),
              ],
            ),
    );
  }
}

class PopupWidget extends StatelessWidget {
  final LatLng location;
  final VoidCallback onClose;

  const PopupWidget({
    super.key,
    required this.location,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Current Location", 
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.purple, 
                  ),
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.purple),
                  onPressed: onClose,  
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            "Lat: ${location.latitude.toStringAsFixed(4)}\nLng: ${location.longitude.toStringAsFixed(4)}",  
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: Colors.pink),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple, 
                    ),
                    onPressed: () {
                     
                      print('Get Route'); 
                    },
                    child: const Icon(Icons.directions, color: Colors.white),
                  ),
                  const Text(
                    "Route",  
                    style: TextStyle(color: Colors.purple, fontSize: 14),
                  ),
                ],
              ),
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, 
                      foregroundColor: Colors.pink, 
                    ),
                    onPressed: () {
                     
                      print('Share Location'); 
                    },
                    child: const Icon(Icons.share, color: Colors.pink),
                  ),
                  const Text(
                    "Share",  
                    style: TextStyle(color: Colors.pink, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
