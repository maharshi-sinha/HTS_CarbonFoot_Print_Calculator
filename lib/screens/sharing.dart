import 'package:carbonsense/components/custom_app_bar.dart';
import 'package:carbonsense/constants/city_random.dart';
import 'package:carbonsense/constants/escooters.dart';
import 'package:carbonsense/extensions/random_item_list.dart';
import 'package:carbonsense/models/escooter.dart';
import 'package:carbonsense/theme/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';

class Sharing extends StatelessWidget {
  const Sharing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: FlutterMap(
        options: MapOptions(
          // center: LatLng(40.768901, 14.778345),
          center: const LatLng(21.213780, 81.344760),
          zoom: 7.5,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          PopupMarkerLayer(
            options: PopupMarkerLayerOptions(
              popupDisplayOptions: PopupDisplayOptions(
                builder: (BuildContext context, Marker marker) =>
                    _Popup(marker),
              ),
              markers: [
                ...scooters
                    .map(
                      (e) => Marker(
                        point: LatLng(e.latitude, e.longitude),
                        builder: (context) => const Icon(
                          Icons.location_pin,
                          size: 45,
                          color: kDarkGreen,
                        ),
                      ),
                    )
                    .toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Popup extends StatefulWidget {
  final Marker marker;

  const _Popup(this.marker, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PopupState();
}

class _PopupState extends State<_Popup> {
  @override
  Widget build(BuildContext context) {
    final EScooter scooter = scooters.firstWhere(
      (element) =>
          element.latitude == widget.marker.point.latitude &&
          element.longitude == widget.marker.point.longitude,
    );

    return Card(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 10),
            child: Icon(
              FontAwesomeIcons.cloud,
              color: scooter.available ? kDarkGreen : kRed,
            ),
          ),
          _content(context, scooter),
        ],
      ),
    );
  }

  Widget _content(BuildContext context, EScooter scooter) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              kFunFacts1.random(),
              overflow: TextOverflow.fade,
              softWrap: false,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: scooter.available ? kDarkGreen : kRed,
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
            Text(
              scooter.available ? "AQI: 25" : "Not Available",
              style: GoogleFonts.montserrat(
                fontSize: 12,
                color: scooter.available ? kDarkGreen : kRed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
