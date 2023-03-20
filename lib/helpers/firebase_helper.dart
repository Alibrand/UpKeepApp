import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:upkeepapp/model/FireResponse.dart';
import 'package:upkeepapp/model/FireUser.dart';

import '../model/Station.dart';

class FireBaseHelper {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  FireRespone response = FireRespone(status: "OK", message: "", data: null);

  //***********User Authentication Functions*********** */
  Future<FireRespone> createUserWithEmailPassword(
      String email, String password) async {
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      response.data = newUser.user!.uid;
      response.status = "OK";
      return response;
    } catch (e) {
      response.status = "Error";
      response.message = e.toString();
      return response;
    }
  }

  Future<FireRespone> saveUserProfile(Map<String, dynamic> info) async {
    try {
      await _firestore.collection('userprofile').add(info);
      response.message = "User Profile Created Succssefully";
      response.status = "OK";
      return response;
    } catch (e) {
      response.status = "Error";
      response.message = e.toString();
      return response;
    }
  }

  Future<FireRespone> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (email == "admin@upkeep.com") {
        response.status = "Admin";
        response.message = "Welcome Admin";
        return response;
      }

      final userId = user.user!.uid;
      final result = await getUserProfile(userId);

      if (result.status == "OK") {
        response.status = "OK";
        final profile = result.data;

        FireUser fireuser = FireUser.fromMap(profile['data']);
        response.message = "Welcome " + fireuser.fullName;

        response.data = fireuser;
      } else {
        response = result;
      }

      return response;
    } catch (e) {
      response.status = "Error";
      response.message = e.toString();
      return response;
    }
  }

  Future<FireRespone> getUserProfile(String userid) async {
    try {
      final profile = await _firestore
          .collection('userprofile')
          .where('user_id', isEqualTo: userid)
          .get();
      if (profile.docs.isEmpty) {
        response.status = "Error";
        response.message = "Profile not found";
      } else {
        response.status = "OK";
        response.message = "";
        response.data = {
          'docid': profile.docs[0].id,
          'data': profile.docs[0].data()
        };
      }
      return response;
    } catch (e) {
      response.status = "Error";
      response.message = e.toString();

      return response;
    }
  }

  Future<FireRespone> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      response.status = "OK";
      response.message = "A reset password link sent to " + email;
      return response;
    } catch (e) {
      response.status = "Error";
      response.message = e.toString();
      return response;
    }
  }

  void signOut() {
    _auth.signOut();
  }

  //***********Stations Functions****************
  Future<FireRespone> getStationByType(String type) async {
    try {
      final stations = await _firestore
          .collection('stations')
          .where('type', isEqualTo: type)
          .get();
      List<Station> stationsList = <Station>[];
      for (var stationDoc in stations.docs) {
        var stationData = stationDoc.data();
        //add doc id to data
        stationData.addAll({"id": stationDoc.id});
        Station station = Station.fromMap(stationData);
        stationsList.add(station);
      }

      response.status = "OK";
      response.message = "";
      response.data = stationsList;

      return response;
    } catch (e) {
      response.status = "Error";
      response.message = e.toString();

      return response;
    }
  }

  Future<FireRespone> getAllStations() async {
    try {
      final stations =
          await _firestore.collection('stations').orderBy('type').get();

      List<Station> stationsList = <Station>[];

      for (var stationDoc in stations.docs) {
        var stationData = stationDoc.data();
        //add doc id to data
        stationData.addAll({"id": stationDoc.id});
        Station station = Station.fromMap(stationData);
        stationsList.add(station);
      }

      response.status = "OK";
      response.message = "";
      response.data = stationsList;

      return response;
    } catch (e) {
      response.status = "Error";
      response.message = e.toString();

      return response;
    }
  }

  Future<FireRespone> getStationInfo(String stationId) async {
    try {
      final stationDoc =
          await _firestore.collection('stations').doc(stationId).get();
      Map<String, dynamic> stationData =
          stationDoc.data() ?? <String, dynamic>{};

      //add doc id to data
      stationData.addAll({"id": stationDoc.id});
      Station station = Station.fromMap(stationData);

      response.status = "OK";
      response.message = "";
      response.data = station;

      return response;
    } catch (e) {
      response.status = "Error";
      response.message = e.toString();

      return response;
    }
  }

  Future<FireRespone> addNewStation(Station newStation) async {
    try {
      await _firestore.collection('stations').add(newStation.toMap());

      response.status = "OK";
      response.message = "Station added successfully";

      return response;
    } catch (e) {
      response.status = "Error";
      response.message = e.toString();

      return response;
    }
  }

  Future<FireRespone> updateStationServiceCount(Station stat) async {
    try {
      await _firestore
          .collection('stations')
          .doc(stat.id)
          .update({"count": stat.count + 1});

      response.status = "OK";
      response.message = "";

      return response;
    } catch (e) {
      response.status = "Error";
      response.message = e.toString();

      return response;
    }
  }

  Future<FireRespone> deleteStation(Station stat) async {
    try {
      await _firestore.collection('stations').doc(stat.id).delete();

      response.status = "OK";
      response.message = "Station Deleted";

      return response;
    } catch (e) {
      response.status = "Error";
      response.message = e.toString();

      return response;
    }
  }
}
