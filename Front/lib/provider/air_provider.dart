// ignore_for_file: use_rethrow_when_possible

import 'package:flutter/material.dart';

import '../apiModels/booked_flights.dart';
import '../apiModels/flights.dart';
import '../apiModels/user.dart';

class AirProvider extends ChangeNotifier {
  final List<Flights> _allflights = [];

  List<Flights> get allflights => _allflights;

  final List<Users?> _usersList = [];

  List<Users?> get usersList => _usersList;

  final List<Flights?> _flightsList = [];

  List<Flights?> get flightsList => _flightsList;

  final List<BookedFlights> _bookedFlightsList = [];

  List<BookedFlights> get bookedFlightsList => _bookedFlightsList;

  final List<Flights?> _bookedFlights = [];

  List<Flights?> get bookedFlights => _bookedFlights;

  final List<Flights?> _bookedFlightscancelled = [];

  List<Flights?> get bookedFlightscancelled => _bookedFlightscancelled;

  int getTotalBookedFlights() {
    return _bookedFlights.length;
  }

  void addAllFlights(List<Flights> allFlight) {
    _allflights.addAll(allFlight);
    notifyListeners();
  }

  void addUser(Users user) {
    _usersList.add(user);
    notifyListeners();
  }

  void addBookedFlight(BookedFlights bookedFlight) {
    _bookedFlightsList.add(bookedFlight);
    notifyListeners();
  }

  void addFlights(List<Flights> flight) {
    _flightsList.addAll(flight);
    notifyListeners();
  }

  Future<void> addNewFlight(Flights newFlight) async {
    try {
      Flights addedFlight = await addFlight(newFlight);
      _allflights.add(addedFlight);
      _flightsList.add(addedFlight);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  void removeflight(int flight) {
    _flightsList.removeAt(flight);
    notifyListeners();
  }

  void addAllBookedFlight(List<BookedFlights> bookedFlight) {
    _bookedFlightsList.addAll(bookedFlight);
    notifyListeners();
  }

  void addBookedFlightSS(Flights bookedFlight) {
    _bookedFlights.add(bookedFlight);
    notifyListeners();
  }

  void flightsBooked(List<Flights?> bookedFlight) {
    _bookedFlights.addAll(bookedFlight);
    notifyListeners();
  }

  void removedBookedFlightSS(int bookedFlight) {
    _bookedFlights.removeAt(bookedFlight);
    notifyListeners();
  }

  void addAllBookedFlightCancelled(List<Flights?> bookedFlight) {
    _bookedFlightscancelled.addAll(bookedFlight);
    notifyListeners();
  }

  void lBookedFlightCancelled(Flights bookedFlight) {
    _bookedFlightscancelled.add(bookedFlight);
    notifyListeners();
  }

  void rebooked(Flights bookedFlight) {
    _bookedFlights.add(bookedFlight);
    notifyListeners();
  }

  void removeBookedFlightCancelled(int bookedFlight) {
    _bookedFlightscancelled.removeAt(bookedFlight);
    notifyListeners();
  }

  void logout() {
    _usersList.clear();
    _flightsList.clear();
    _bookedFlightscancelled.clear();
    _bookedFlightsList.clear();
    _bookedFlights.cast();
    notifyListeners();
  }
}
