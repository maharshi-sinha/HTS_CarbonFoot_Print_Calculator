import 'package:carbonsense/components/custom_app_bar.dart';
import 'package:carbonsense/main.dart';
import 'package:carbonsense/models/carbon_footprint.dart';
import 'package:carbonsense/screens/calculator.dart';
import 'package:carbonsense/service/shared_preferences_service.dart';
import 'package:carbonsense/theme/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatelessWidget {
  final CarbonFootprintResult? carbonFootprint;
  const Homepage({super.key, this.carbonFootprint});

  CarbonFootprintResult getCarbonFootprint() {
    // TODO: either gets it from the [carbonFootprint] field or from somewhere
    // in the db
    return carbonFootprint ??
        CarbonFootprintResult(
          score: SharedPreferenceService.carbonFootprintResult,
        );
  }

  @override
  Widget build(BuildContext context) {
    // double kScreenWidth = MediaQuery.of(context).size.width / 1.7;
    double kScreenWidth = 240.0;

    return Scaffold(
      appBar: const CustomAppBar(
        title: "Your Footprint",
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            Row(
              children: [Expanded(child: Container())],
            ),
            const Padding(
              padding: EdgeInsets.all(32),
              child: Expanded(
                child: Icon(
                  FontAwesomeIcons.earthEurope,
                  color: kDarkGreen,
                  size: 200,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  Text(
                    "The result of calculating your carbon footprint is:",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "${getCarbonFootprint().score.toStringAsFixed(2)} kg/day",
                    style: GoogleFonts.montserrat(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    getCarbonFootprint().isAvg()
                        ? "You are in the Indian average, try to lower your consumption!"
                        : "You are below the Indian average!",
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _createFootprintIndicator(
                    kScreenWidth,
                    SharedPreferenceService.kmAutoNormalized,
                    FontAwesomeIcons.car,
                    "Auto",
                  ),
                  _createFootprintIndicator(
                    kScreenWidth,
                    SharedPreferenceService.kmMezziNormalized,
                    FontAwesomeIcons.bus,
                    "Means",
                  ),
                  _createFootprintIndicator(
                    kScreenWidth,
                    SharedPreferenceService.kwhCasaNormalized,
                    FontAwesomeIcons.house,
                    "House",
                  ),
                  _createFootprintIndicator(
                    kScreenWidth,
                    SharedPreferenceService.oreAereoNormalized,
                    FontAwesomeIcons.plane,
                    "Airplane",
                  ),
                  _createFootprintIndicator(
                    kScreenWidth,
                    SharedPreferenceService.oreUsoTabletNormalized,
                    FontAwesomeIcons.phone,
                    "Phone",
                  ),
                  MaterialButton(
                    onPressed: () {
                      navigatorKey.currentState?.pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => const Calculator(back: true),
                        ),
                      );
                    },
                    color: kLightGreen4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "Recalculate",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        color: kDarkGreen,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createFootprintIndicator(
    double kScreenWidth,
    double value,
    IconData icon,
    String label,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(
            icon,
            color: kDarkGreen,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 8),
          ),
          SizedBox(
            width: 75,
            child: Text(
              label,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: kScreenWidth,
              height: 25,
              decoration: _containerDec(kLightGreen4),
              child: Row(
                children: [
                  Container(
                    width: (kScreenWidth / 5) * value,
                    decoration: _containerDec(kDarkGreen),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _containerDec(Color color) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(8),
    );
  }
}
