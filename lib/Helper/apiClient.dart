// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:github/Helper/userDefault.dart';
import 'package:github/Model/branch.dart';
import 'package:github/Model/commit.dart';
import 'package:github/Model/organisation.dart';
import 'package:github/Model/repo.dart';
import 'package:github/state/provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ApiClient {
  getOrgData(BuildContext context) async {
    var orgState = context.read<OrganisationState>();
    var url = 'https://api.github.com/organizations?per_page=5';
    orgState.organisation = [];
    List response = await sendHttp(context, url);
    orgState
        .setList(response.map((data) => Organisation.fromJson(data)).toList());
    getRepoData(context);
  }

  getRepoData(BuildContext context) async {
    var orgState = context.read<OrganisationState>();
    var repoState = context.read<RepoState>();
    var url =
        'https://api.github.com/orgs/${orgState.organisation[orgState.selctedNode].login}/repos?per_page=9';
    List response = await sendHttp(context, url);
    repoState.setList(response.map((data) => Repo.fromJson(data)).toList());
  }

  getBranches(BuildContext context) async {
    var branchState = context.read<BranchState>();
    var repoState = context.read<RepoState>();
    branchState.branches = [];
    var url =
        'https://api.github.com/repos/${repoState.repo[repoState.selctedRepo].fullName}/branches';
    List response = await sendHttp(context, url);
    branchState.setList(response.map((data) => Branch.fromJson(data)).toList());
    if (branchState.branches.isNotEmpty) getCommits(context);
  }

  getCommits(BuildContext context) async {
    var branchState = context.read<BranchState>();
    var commitState = context.read<CommitState>();
    var repoState = context.read<RepoState>();
    commitState.commits = [];
    var url =
        'https://api.github.com/repos/${repoState.repo[repoState.selctedRepo].fullName}/commits?sha=${branchState.branches[branchState.selctedBranch].commit?.sha}';
    List response = await sendHttp(context, url);

    commitState
        .setList(response.map((data) => BranchCommit.fromJson(data)).toList());
  }

  sendHttp(BuildContext context, String url) async {
    print("API URL:::::::: ${url}");
    final response = await http.get(Uri.parse(url),
        // headers: {'Authorization': "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"}
        );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      HelperWidgets().showSncakBar(context, "Unable to retrive Data");
    }
  }
}
