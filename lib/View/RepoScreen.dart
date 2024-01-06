import 'package:flutter/material.dart';
import 'package:github/Helper/apiClient.dart';
import 'package:github/Helper/colors.dart';
import 'package:github/Helper/userDefault.dart';
import 'package:github/state/provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RepoScreen extends StatelessWidget {
  const RepoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        titleSpacing: 0,
        centerTitle: true,
        title: const Hero(
          tag: "title",
          child: Material(
            type: MaterialType.transparency,
            child: Text("Project",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white)),
          ),
        ),
      ),
      body: SafeArea(
          bottom: false,
          child: Stack(children: [
            Column(
              children: [
                header(context),
                body(context),
              ],
            ),
          ])),
    );
  }
}

Widget header(context) {
  return Consumer2<RepoState, OrganisationState>(
      builder: (context, rState, oState, _) {
    var repo = rState.repo[rState.selctedRepo];
    return Container(
      color: primaryColor,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.4,
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                              height: 40,
                              width: 40,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Image(
                                  image: NetworkImage(
                                      repo.owner!.avatarUrl ?? "..."))),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  repo.name ?? "",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  repo.owner!.login ?? "",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Color(0xffE1E2FF),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        ('Last update: ${getTheDateInString(repo.updatedAt?.replaceFirst("T", ' ').replaceFirst("Z", '') ?? "")}') ??
                            "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Color(0xffF6F5FE),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  });
}

String getTheDateInString(String datee) {
  final date = DateFormat("yyyy-MM-dd hh:mm").parse(datee);
  final formated = DateFormat("yyyy-MM-dd h:mm a").format(date);
  return formated;
}

Widget body(context) {
  return Consumer2<BranchState, CommitState>(
      builder: (context, bState, cState, _) {
    var branch = bState.branches;
    return Expanded(
        child: Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: branch.isEmpty
                ? const Center(
                    child: Text("No Branch Found"),
                  )
                : branchDataWidget(context, bState, cState)));
  });
}

Widget branchDataWidget(
    BuildContext context, BranchState bState, CommitState cState) {
  var branches = bState.branches;
  var commits = cState.commits;

  return Column(
    children: [
      SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(branches.length, (index) {
                return branchCard(context, bState, index);
              })
            ],
          ),
        ),
      ),
      const SizedBox(height: 15),
      commits.isEmpty
          ? Expanded(child: HelperWidgets().progressIndicator())
          : Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: commits.length,
                  itemBuilder: (context, index) {
                    var commit = commits[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xffEDEDFF)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              height: 40,
                              width: 40,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xffFFF5EB),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Image(
                                image: AssetImage("assets/folder.png"),
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  commit.commit?.message ?? "",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: primaryTextClr,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  " ${getTheDateInString(commit.commit?.committer?.date?.replaceFirst("T", ' ').replaceFirst("Z", '') ?? "")}",
                                  // "${getTheDateInString("yyyy-MM-dd", commit.commit?.committer?.date. ?? "")}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Color(0xff5F607E),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Image(
                                      width: 15,
                                      image: AssetImage("assets/user.png"),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      commit.commit?.committer!.name ?? "",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: Color(0xff5F607E),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
    ],
  );
}

Widget branchCard(BuildContext context, BranchState bState, int index) {
  var branch = bState.branches[index];
  var isSelected = bState.selctedBranch == index;
  return InkWell(
    onTap: () {
      bState.setBranch(index);
      ApiClient().getCommits(context);
    },
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isSelected ? const Color(0xff27274A) : Color(0xffF3F4FF),
      ),
      margin: const EdgeInsets.only(right: 10),
      child: Text(
        branch.name ?? "",
        style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xff5F607E)),
      ),
    ),
  );
}
