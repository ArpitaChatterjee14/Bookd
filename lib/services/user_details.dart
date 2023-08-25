import 'dart:convert';
import 'package:bookd/models/user_details.dart';
import 'package:bookd/provider/login_data.dart';
import 'package:bookd/screens/email_verification.dart';
import 'package:bookd/screens/forgot_password.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bookd/models/user.dart';
import 'package:provider/provider.dart';

class UserDetailsService {
  Future<http.Response> getUser({required String username}) async {
    try {
      Details dt = Details(
        id: '',
        username: username,
        email: '',
        phone: '',
      );

      http.Response res = await http.post(
          // Uri.parse('http://10.0.2.2:3000/api/register'),
          Uri.parse('http://localhost:3000/api/userdetails'),
          body: dt.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      return res;
    } catch (e) {
      // return http.Response().statusCode;
      throw e;
    }
  }

  Future<http.Response> getFriends(
      {required String email, required String friend}) async {
    try {
      UserDetails user = UserDetails(
          id: '',
          username: '',
          email: email,
          password: '',
          phone: '',
          token: '',
          otp: '',
          friend: friend);

      http.Response res = await http.post(
          // Uri.parse('http://10.0.2.2:3000/api/register'),
          Uri.parse('http://localhost:3000/api/addfriend'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      return res;
    } catch (e) {
      // return http.Response().statusCode;
      throw e;
    }
  }

  Future<http.Response> getNotify({required String email}) async {
    try {
      UserDetails user = UserDetails(
        friend: '',
        id: '',
        username: '',
        email: email,
        password: '',
        phone: '',
        token: '',
        otp: '',
      );

      http.Response res = await http.post(
          // Uri.parse('http://10.0.2.2:3000/api/register'),
          Uri.parse('http://localhost:3000/api/addfriendnotify'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      return res;
    } catch (e) {
      // return http.Response().statusCode;
      throw e;
    }
  }

  Future<http.Response> getFriend({required String email}) async {
    try {
      Details dt = Details(
        id: '',
        username: '',
        email: email,
        phone: '',
      );

      http.Response res = await http.post(
          // Uri.parse('http://10.0.2.2:3000/api/register'),
          Uri.parse('http://localhost:3000/api/frienddetails'),
          body: dt.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      return res;
    } catch (e) {
      // return http.Response().statusCode;
      throw e;
    }
  }

  Future<http.Response> confirmFriends(
      {required String email, required String friend}) async {
    try {
      UserDetails user = UserDetails(
          id: '',
          username: '',
          email: email,
          password: '',
          phone: '',
          token: '',
          otp: '',
          friend: friend);

      http.Response res = await http.post(
          // Uri.parse('http://10.0.2.2:3000/api/register'),
          Uri.parse('http://localhost:3000/api/confirmfriend'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      return res;
    } catch (e) {
      // return http.Response().statusCode;
      throw e;
    }
  }

  Future<http.Response> allFriends({required String email}) async {
    try {
      UserDetails user = UserDetails(
          id: '',
          username: '',
          email: email,
          password: '',
          phone: '',
          token: '',
          otp: '',
          friend: '');

      http.Response res = await http.post(
          // Uri.parse('http://10.0.2.2:3000/api/register'),
          Uri.parse('http://localhost:3000/api/allfriend'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      return res;
    } catch (e) {
      // return http.Response().statusCode;
      throw e;
    }
  }

  Future<http.Response> allFollows({required String email}) async {
    try {
      UserDetails user = UserDetails(
          id: '',
          username: '',
          email: email,
          password: '',
          phone: '',
          token: '',
          otp: '',
          friend: '');

      http.Response res = await http.post(
          // Uri.parse('http://10.0.2.2:3000/api/register'),
          Uri.parse('http://localhost:3000/api/allfollow'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      return res;
    } catch (e) {
      // return http.Response().statusCode;
      throw e;
    }
  }

  Future<http.Response> all() async {
    try {
      UserDetails user = UserDetails(
          id: '',
          username: '',
          email: '',
          password: '',
          phone: '',
          token: '',
          otp: '',
          friend: '');

      http.Response res = await http.get(
          // Uri.parse('http://10.0.2.2:3000/api/register'),
          Uri.parse('http://localhost:3000/api/all'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      return res;
    } catch (e) {
      // return http.Response().statusCode;
      throw e;
    }
  }

  Future<http.Response> removefriendrequest(
      {required String email, required String friend}) async {
    try {
      UserDetails user = UserDetails(
        id: '',
        username: '',
        email: email,
        password: '',
        phone: '',
        token: '',
        otp: '',
        friend: friend,
      );

      http.Response res = await http.post(
          // Uri.parse('http://10.0.2.2:3000/api/register'),
          Uri.parse('http://localhost:3000/api/removefriendrequest'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      return res;
    } catch (e) {
      // return http.Response().statusCode;
      throw e;
    }
  }

  Future<http.Response> addfollows(
      {required String email, required String friend}) async {
    try {
      UserDetails user = UserDetails(
          id: '',
          username: '',
          email: email,
          password: '',
          phone: '',
          token: '',
          otp: '',
          friend: friend);

      http.Response res = await http.post(
          // Uri.parse('http://10.0.2.2:3000/api/register'),
          Uri.parse('http://localhost:3000/api/addfollow'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      return res;
    } catch (e) {
      // return http.Response().statusCode;
      throw e;
    }
  }

  Future<http.Response> removefollows(
      {required String email, required String friend}) async {
    try {
      UserDetails user = UserDetails(
          id: '',
          username: '',
          email: email,
          password: '',
          phone: '',
          token: '',
          otp: '',
          friend: friend);

      http.Response res = await http.post(
          // Uri.parse('http://10.0.2.2:3000/api/register'),
          Uri.parse('http://localhost:3000/api/removefollow'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      return res;
    } catch (e) {
      // return http.Response().statusCode;
      throw e;
    }
  }

  Future<http.Response> removefriend(
      {required String email, required String friend}) async {
    try {
      UserDetails user = UserDetails(
          id: '',
          username: '',
          email: email,
          password: '',
          phone: '',
          token: '',
          otp: '',
          friend: friend);

      http.Response res = await http.post(
          // Uri.parse('http://10.0.2.2:3000/api/register'),
          Uri.parse('http://localhost:3000/api/removefriend'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      return res;
    } catch (e) {
      // return http.Response().statusCode;
      throw e;
    }
  }

  Future<http.Response> checkstatus(
      {required String email, required String friend}) async {
    try {
      UserDetails user = UserDetails(
          id: '',
          username: '',
          email: email,
          password: '',
          phone: '',
          token: '',
          otp: '',
          friend: friend);

      http.Response res = await http.post(
          // Uri.parse('http://10.0.2.2:3000/api/register'),
          Uri.parse('http://localhost:3000/api/checkstatus'),
          body: user.toJson(),
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
