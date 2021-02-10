import 'package:coronampel/controller/search_controller.dart';
import 'package:coronampel/services/location_remote_service.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:io';

class GetLocationController extends GetxController {
  final SearchController searchController = Get.put(SearchController());
  var isLoading = false.obs;
  var lattitude = ''.obs;
  var longitude = ''.obs;
  var localPermissions = LocationPermission.denied.obs;

  Future<void> getLocation() async {
    isLoading(true);
    bool serviceEnabled;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar(
        'Fehler',
        'Ortungsdienste sind ausgeschalten. Bitte aktivieren!',
        snackPosition: SnackPosition.BOTTOM,
      );
      isLoading(false);
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.deniedForever) {
      Get.snackbar(
        'Ortungsdienste sind deaktiviert',
        (Platform.isIOS)
            ? 'Zum aktivieren: Einstellungen > Datenschutz > Ortungsdienste > CoronAmpel'
            : 'Zum aktivieren: Einstellungen > Anwendungen > CoronAmpel > Berechtigungen',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(milliseconds: 5000),
        isDismissible: true,
      );
      permission = await Geolocator.requestPermission(); // androidbug?
      isLoading(false);
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    } else {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        Get.snackbar(
          'Ortungsdienste sind deaktiviert',
          'Um Ihren aktuellen Standort rauszufinden, müssen Sie Ortdungsdienste zulassen.',
          snackPosition: SnackPosition.BOTTOM,
        );
        isLoading(false);
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium);
      print('${position.toString()}');
      lattitude.value = position.latitude.toString();
      longitude.value = position.longitude.toString();

      try {
        var locationResult = await RemoteServiceLocation.fetchLocationCounty(
            longitude.value, lattitude.value);

        searchController.searchString.value = locationResult;
      } catch (err) {
        Get.snackbar('Fehler',
            'Ihr Ort kann nicht gefunden werden. Versuchen Sie es später noch einmal.',
            snackPosition: SnackPosition.BOTTOM);
        print(err);
        isLoading(false);
      } finally {
        isLoading(false);
      }
    }
  }
}

// https://services7.arcgis.com/mOBPykOjAyBO2ZKk/arcgis/rest/services/RKI_Landkreisdaten/FeatureServer/0/query?where=1%3D1&outFields=GEN&geometry=10.963%2C50.259&geometryType=esriGeometryPoint&inSR=4326&spatialRel=esriSpatialRelWithin&returnGeometry=false&outSR=4326&f=json

// https://services7.arcgis.com/mOBPykOjAyBO2ZKk/arcgis/rest/services/RKI_Landkreisdaten/FeatureServer/0/query?where=1%3D1&outFields=GEN&geometry=${ location.longitude.toFixed( 3 ) }%2C${ 50.259.toFixed( 3 ) }&geometryType=esriGeometryPoint&inSR=4326&spatialRel=esriSpatialRelWithin&returnGeometry=false&outSR=4326&f=json
