import 'dart:convert';
import 'package:bookd/models/booking_details.dart';
import 'package:bookd/provider/login_data.dart';
import 'package:bookd/screens/email_verification.dart';
import 'package:bookd/screens/forgot_password.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bookd/models/user_details.dart';
import 'package:provider/provider.dart';

class BookingService {
  Future<http.Response> quickbooking(
      {required String startdate,
      required String enddate,
      required String starttime,
      required String endtime,
      required String title,
      required String participants}) async {
    try {
      BookingDetails booking = BookingDetails(
        id: '',
        startdate: startdate,
        enddate: enddate,
        starttime: starttime,
        endtime: endtime,
        title: title,
        description: '',
        visibility: '',
        participants: participants,
        priority: '',
        notify: '',
        color: '',
      );

      http.Response res = await http.post(
          // Uri.parse('http://10.0.2.2:3000/api/register'),
          Uri.parse('http://localhost:3000/api/quickbooking'),
          body: booking.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      return res;
    } catch (e) {
      // return http.Response().statusCode;
      throw e;
    }
  }

  Future<http.Response> showbooking(
      {required String startdate, required String participants}) async {
    try {
      BookingDetails booking = BookingDetails(
        id: '',
        startdate: startdate,
        enddate: '',
        starttime: '',
        endtime: '',
        title: '',
        description: '',
        visibility: '',
        participants: participants,
        priority: '',
        notify: '',
        color: '',
      );

      http.Response res = await http.post(
          // Uri.parse('http://10.0.2.2:3000/api/register'),
          Uri.parse('http://localhost:3000/api/showbooking'),
          body: booking.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      return res;
    } catch (e) {
      // return http.Response().statusCode;
      throw e;
    }
  }

  Future<http.Response> usualbooking({
    required String startdate,
    required String enddate,
    required String starttime,
    required String endtime,
    required String title,
    required String description,
    required String visibility,
    required String participants,
    required String priority,
    required String notify,
    required String color,
  }) async {
    try {
      BookingDetails booking = BookingDetails(
          id: '',
          startdate: startdate,
          enddate: enddate,
          starttime: starttime,
          endtime: endtime,
          title: title,
          description: description,
          visibility: visibility,
          participants: participants,
          priority: priority,
          notify: notify,
          color: color);

      http.Response res = await http.post(
          // Uri.parse('http://10.0.2.2:3000/api/register'),
          Uri.parse('http://localhost:3000/api/usualbooking'),
          body: booking.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      return res;
    } catch (e) {
      // return http.Response().statusCode;
      throw e;
    }
  }

  Future<http.Response> notifybooking({required String email}) async {
    try {
      BookingDetails booking = BookingDetails(
        id: '',
        startdate: '',
        enddate: '',
        starttime: '',
        endtime: '',
        title: '',
        description: '',
        visibility: '',
        participants: email,
        priority: '',
        notify: '',
        color: '',
      );

      http.Response res = await http.post(
          // Uri.parse('http://10.0.2.2:3000/api/register'),
          Uri.parse('http://localhost:3000/api/notifybooking'),
          body: booking.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      return res;
    } catch (e) {
      // return http.Response().statusCode;
      throw e;
    }
  }
}
