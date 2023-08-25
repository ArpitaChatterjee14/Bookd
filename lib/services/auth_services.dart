import 'dart:convert';
import 'package:bookd/provider/login_data.dart';
import 'package:bookd/screens/email_verification.dart';
import 'package:bookd/screens/forgot_password.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bookd/models/user_details.dart';
import 'package:provider/provider.dart';

class AuthService {
  Future<http.Response> registerUser(
      {required String email,
      required String phone,
      required String password,
      required String username}) async {
    try {
      UserDetails user = UserDetails(
          id: '',
          username: username,
          email: email,
          password: password,
          phone: phone,
          token: '',
          otp: '',
          friend: '');

      http.Response res = await http.post(
          // Uri.parse('http://10.0.2.2:3000/api/register'),
          Uri.parse('http://localhost:3000/api/register'),
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

  Future<http.Response> emailVerification({required String email}) async {
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
          // Uri.parse('http://10.0.2.2:3000/api/verifyemail'),
          Uri.parse('http://localhost:3000/api/verifyemail'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      return res;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<http.Response> emailOtpValidation(
      {required String email, required String otp}) async {
    try {
      UserDetails user = UserDetails(
          id: '',
          username: '',
          email: email,
          password: '',
          phone: '',
          token: '',
          otp: otp,
          friend: '');

      http.Response res = await http.post(
          // Uri.parse('http://10.0.2.2:3000/api/verifyotpemail'),
          Uri.parse('http://localhost:3000/api/verifyotpemail'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      return res;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<http.Response> phoneVerification({required String phone}) async {
    try {
      UserDetails user = UserDetails(
          id: '',
          username: '',
          email: '',
          password: '',
          phone: phone,
          token: '',
          otp: '',
          friend: '');

      http.Response res = await http.post(
          // Uri.parse('http://10.0.2.2:3000/api/verifyotpemail'),
          Uri.parse('http://localhost:3000/api/verifyphone'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      return res;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<http.Response> phoneOtpValidation(
      {required String phone, required String otp}) async {
    try {
      UserDetails user = UserDetails(
          id: '',
          username: '',
          email: '',
          password: '',
          phone: phone,
          token: '',
          otp: otp,
          friend: '');

      http.Response res = await http.post(
          // Uri.parse('http://10.0.2.2:3000/api/verifyotpemail'),
          Uri.parse('http://localhost:3000/api/verifyotpphone'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      return res;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<http.Response> signinUser({
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
          Uri.parse('http://localhost:3000/api/signin'),
          body: jsonEncode({'email': email, 'password': password}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      return res;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<http.Response> forgotPassword({required String email}) async {
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
          // Uri.parse('http://10.0.2.2:3000/api/verifyemail'),
          Uri.parse('http://localhost:3000/api/forgotpassword'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      return res;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<http.Response> forgotPasswordValidation(
      {required String email, required String otp}) async {
    try {
      UserDetails user = UserDetails(
          id: '',
          username: '',
          email: email,
          password: '',
          phone: '',
          token: '',
          otp: otp,
          friend: '');

      http.Response res = await http.post(
          // Uri.parse('http://10.0.2.2:3000/api/verifyotpemail'),
          Uri.parse('http://localhost:3000/api/forgotpasswordvalidation'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      return res;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<http.Response> resetpassword(
      {required String email, required String password}) async {
    try {
      UserDetails user = UserDetails(
          id: '',
          username: '',
          email: email,
          password: password,
          phone: '',
          token: '',
          otp: '',
          friend: '');

      http.Response res = await http.post(
          // Uri.parse('http://10.0.2.2:3000/api/verifyotpemail'),
          Uri.parse('http://localhost:3000/api/resetpassword'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      return res;
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
