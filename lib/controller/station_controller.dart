import 'package:get/get.dart';
import 'package:upkeepapp/controller/base_controller.dart';
import 'package:upkeepapp/controller/location_controller.dart';

import '../helpers/firebase_helper.dart';
import '../model/Station.dart';

class StationController extends BaseController {
  final _fireHelper = FireBaseHelper();
  final _locationController = Get.find<LocationController>();

  List<Station> stationsList = <Station>[].obs;

  getStationsByType(String type) async {
    //reset list before search
    stationsList = <Station>[];
    isLoading.value = true;
    fireResponse.value = await _fireHelper.getStationByType(type);

    if (fireResponse.value.status == "OK") {
      stationsList = fireResponse.value.data;
      stationsList.sort((stationa, stationb) {
        var distncea =
            _locationController.getDistanceFromPosition(stationa.location);
        var distnceb =
            _locationController.getDistanceFromPosition(stationb.location);
        return distncea.compareTo(distnceb);
      });
    } else {
      showSnackBar();
    }

    isLoading.value = false;
  }

  getAllStations() async {
    //reset list before search
    stationsList = <Station>[];
    isLoading.value = true;
    fireResponse.value = await _fireHelper.getAllStations();

    if (fireResponse.value.status == "OK") {
      stationsList = fireResponse.value.data;
      stationsList.sort((a, b) {
        return b.count.compareTo(a.count);
      });
    } else {
      showSnackBar();
    }

    isLoading.value = false;
  }

  Future<Station> getStationInfo(String stationId) async {
    Station station = Station.empty();
    isLoading.value = true;
    fireResponse.value = await _fireHelper.getStationInfo(stationId);
    if (fireResponse.value.status == "OK") {
      station = fireResponse.value.data;
    } else {
      showSnackBar();
    }
    isLoading.value = false;
    return station;
  }

  Future<void> addNewStation(Station station) async {
    isLoading.value = true;
    fireResponse.value = await _fireHelper.addNewStation(station);
    if (fireResponse.value.status == "OK") {
      showSnackBar();
    } else {
      showSnackBar();
    }

    isLoading.value = false;
  }

  Future<void> updateStationServiceCount(Station station) async {
    fireResponse.value = await _fireHelper.updateStationServiceCount(station);
    if (fireResponse.value.status == "OK") {
      station = fireResponse.value.data;
    } else {
      showSnackBar();
    }
  }

  Future<void> deleteStation(Station stat) async {
    isLoading.value = true;
    fireResponse.value = await _fireHelper.deleteStation(stat);
    if (fireResponse.value.status == "OK") {
      showSnackBar();
    } else {
      showSnackBar();
    }
    isLoading.value = false;
  }
}
