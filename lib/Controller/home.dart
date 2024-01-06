import 'package:flutter/material.dart';
import 'package:github/Helper/apiClient.dart';
import 'package:github/View/RepoScreen.dart';
import 'package:github/state/provider.dart';
import 'package:provider/provider.dart';

class HomeController {
  pushRepoScreen(BuildContext context, RepoState rState, index) {
    rState.setRepo(index);
    Provider.of<BranchState>(context, listen: false).setBranch(0);
    ApiClient().getBranches(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const RepoScreen()));
  }
}
