// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:github/Model/branch.dart';
import 'package:github/Model/commit.dart';
import 'package:github/Model/organisation.dart';
import 'package:github/Model/repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderManagement extends ChangeNotifier {
  int count = 0;
  List<String> cartList = [];

  int get number => count;
  List get lists => cartList;

  void increment() {
    count++;
    notifyListeners();
  }

  void decrement() {
    count--;
    notifyListeners();
  }

  void addList(String item) {
    cartList.add(item);
    notifyListeners();
  }

  void removeList(String item) {
    cartList.remove(item);
    notifyListeners();
  }
}

class ProfileData extends ChangeNotifier {
  var profile;
  var isLoading = false;
  get profData => profile;

  void getProfile() async {
    var prefs = await SharedPreferences.getInstance();
    profile = json.decode((prefs.getString("profile")!));
    notifyListeners();
  }

  setLoading(bool bool) {
    isLoading = bool;
    notifyListeners();
  }
}

class OrganisationState extends ChangeNotifier {
  List<Organisation> organisation = [];
  int selctedNode = 0;

  setList(List<Organisation> list) {
    organisation = [];
    list.map((e) => organisation.add(e)).toList();
    notifyListeners();
  }

  setNode(int node) {
    selctedNode = node;
    notifyListeners();
  }
}

class RepoState extends ChangeNotifier {
  List<Repo> repo = [];
  int selctedRepo = 0;

  setList(List<Repo> list) {
    repo = [];
    list.map((e) => repo.add(e)).toList();
    notifyListeners();
  }

  setRepo(int node) {
    selctedRepo = node;
    notifyListeners();
  }
}

class BranchState extends ChangeNotifier {
  List<Branch> branches = [];
  int selctedBranch = 0;

  setList(List<Branch> list) {
    branches = [];
    list.map((e) => branches.add(e)).toList();
    notifyListeners();
  }

  setBranch(int node) {
    selctedBranch = node;
    notifyListeners();
  }
}

class CommitState extends ChangeNotifier {
  List<BranchCommit> commits = [];

  setList(List<BranchCommit> list) {
    commits = [];
    list.map((e) => commits.add(e)).toList();
    notifyListeners();
  }
}
