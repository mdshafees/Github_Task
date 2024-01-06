// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:github/Controller/sigin.dart';
import 'package:github/Helper/userDefault.dart';
import 'package:github/state/provider.dart';
import 'package:provider/provider.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<ProfileData>(builder: (context, state, _) {
      return Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 80, 16, 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                    height: 80,
                    child: Hero(
                        tag: "logo",
                        child: Image(image: AssetImage("assets/logo.png")))),
                Column(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.fromLTRB(65, 15, 65, 0),
                        child: const Image(
                            image: AssetImage("assets/system.png"))),
                    const SizedBox(height: 40),
                    const Text(
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.w500
                                ),
                        "Lets built from here ..."),
                    const SizedBox(height: 5),
                    const Text(
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff5F607E)),
                        "Our platform drives innovation with tools that boost developer velocity"),
                    const SizedBox(height: 60)
                  ],
                ),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 30,
                  child: ElevatedButton(
                    onPressed: () =>
                        SigninController().signInWithGitHub(context),
                    child: const Text("Sign in with Github"),
                  ),
                )
              ],
            ),
          ),
          state.isLoading
              ? Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.grey.withOpacity(0.3),
                  child: HelperWidgets().progressIndicator(),
                )
              : Container()
        ],
      );
    }));
  }
}
