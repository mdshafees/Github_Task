// ignore_for_file: use_build_context_synchronously, curly_braces_in_flow_control_structures

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:github/Helper/userDefault.dart';
import 'package:github/Model/ModelClass.dart';
import 'package:github/View/HomeScreen.dart';
import 'package:github/state/provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SigninController {
  signInWithGitHub(BuildContext context) async {
    var profileState = context.read<ProfileData>();
    profileState.setLoading(true);
    try {
      UserCredential userCred = await signinWithGithub();
      if (context.mounted) {
        await UserDefault.setLoginStatus(true);
        await UserDefault.setProfile(Profile(
            email: userCred.user!.email,
            phone: userCred.user!.phoneNumber,
            name: toBeginningOfSentenceCase(
                userCred.additionalUserInfo!.username),
            image: userCred.user!.photoURL));

        profileState.getProfile();
        profileState.setLoading(false);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const HomeScreen()),
            (Route<dynamic> route) => false);

        HelperWidgets().showSncakBar(context, "Logged In Successful");
      } else
        profileState.setLoading(false);
    } catch (e) {
      profileState.setLoading(false);
      HelperWidgets().showSncakBar(context, e.toString());
    }
  }

  Future<UserCredential> signinWithGithub() async {
    GithubAuthProvider githubAuth = GithubAuthProvider();
    return await FirebaseAuth.instance.signInWithProvider(githubAuth);
  }
}
