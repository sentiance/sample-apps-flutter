import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sentiance_core/sentiance_core.dart';

import 'home_screen.dart';
import '../helpers/auth.dart';

class SetupScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  final sentiance = SentianceCore();

  @override
  void initState() {
    super.initState();
    _redirectToHomeIfUserExists();
  }

  // Redirect to home screen if user exists
  void _redirectToHomeIfUserExists() async {
    if (await sentiance.userExists()) {
      print("user exists... redirecting to home page");
      _loadHome();
    }
  }

  // ***********
  // Start here.
  // ***********
  //
  // This handler is invoked when "Create User" is tapped.
  // It additionally demonstrates how to create a sentiance user.
  // The workflow communicates with the provided sample backend
  // service to obtain authentication code.
  Future<void> _onCreateUserClick() async {
    print("creating user ...");
    try {
      final AuthCodeResult result = await fetchAuthCode();
      await sentiance.createUser(CreateUserOptions(authCode: result.authCode));
      await sentiance.enableDetections();
      _loadHome();
    } catch (e) {
      print(e);
    }
  }

  void _loadHome() {
    if (!context.mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text("Sample Application"),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _buildGreetingText(),
          _buildCreateUserButton(),
          _buildLogo(),
        ],
      ),
    );
  }

  Widget _buildGreetingText() {
    return const Padding(
      padding: EdgeInsets.all(40.0),
      child: Text(
        'Hello there!',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 24,
        ),
      ),
    );
  }

  Widget _buildCreateUserButton() {
    return ElevatedButton(
      onPressed: _onCreateUserClick,
      child: const Text('Create SDK User'),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        const SizedBox(height: 40),
        SvgPicture.asset(
          'assets/images/sentiance_logo.svg',
          width: 120,
        ),
        const SizedBox(height: 80),
      ],
    );
  }
}
