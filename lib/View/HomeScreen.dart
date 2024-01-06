import 'package:flutter/material.dart';
import 'package:github/Controller/home.dart';
import 'package:github/Helper/apiClient.dart';
import 'package:github/Model/organisation.dart';
import 'package:github/state/provider.dart';
import 'package:github/Helper/userDefault.dart';
import 'package:github/View/InitialScreen.dart';
import 'package:github/Helper/colors.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    ApiClient().getOrgData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ProfileData, OrganisationState>(
        builder: (context, pState, orState, _) {
      return Scaffold(
        backgroundColor: primaryColor,
        extendBodyBehindAppBar: true,
        drawer: drawer(pState, orState, context),
        appBar: appbar(),
        body: SafeArea(
            bottom: false,
            child: Stack(children: [
              Column(
                children: [
                  header(context, pState),
                  body(context),
                ],
              ),
              card(context, pState, orState)
            ])),
      );
    });
  }
}

Widget drawer(pState, OrganisationState orState, BuildContext context) {
  var organisation = orState.organisation;
  return Drawer(
    backgroundColor: Colors.white,
    child: Container(
        margin: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              margin: const EdgeInsets.only(top: 30),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: const Color(0xffF6F5FE),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  pState.profile['image'] != null
                      ? Image(
                          width: 55,
                          image: NetworkImage(pState.profile?['image']))
                      : const Image(
                          width: 55, image: AssetImage("assets/profile.png")),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${pState.profile?['name'] ?? "Guest"}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: primaryTextClr,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 6),
                        Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: const Color(0xffFF9C37),
                            ),
                            child: Text(
                              organisation.isNotEmpty
                                  ? organisation[orState.selctedNode].login ??
                                      ""
                                  : "...",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: organisation.length,
                itemBuilder: (context, index) {
                  return drawerItem(
                      organisation[index], index == orState.selctedNode, () {
                    var orgState = context.read<OrganisationState>();
                    orgState.setNode(index);
                    ApiClient().getRepoData(context);
                  });
                }),
            logoutCard(context),
          ]),
        )),
  );
}

AppBar appbar() {
  return AppBar(
    scrolledUnderElevation: 0,
    elevation: 0,
    titleSpacing: 0,
    title: const Text("Github",
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white)),
    actions: [
      Container(
        height: 20,
        width: 20,
        margin: const EdgeInsets.only(right: 16),
        child: const Image(image: AssetImage("assets/notifiaction.png")),
      )
    ],
  );
}

Widget header(context, ProfileData pState) {
  return Container(
    height: 75,
    color: primaryColor,
    padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
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
                    Text(
                      "Hi, ${pState.profile?['name'] ?? "Guest"}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
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
}

Widget card(context, pState, orState) {
  var organisation = orState.organisation;
  return GestureDetector(
    onTap: () {},
    child: Container(
      margin: const EdgeInsets.fromLTRB(16, 35, 16, 80),
      padding: const EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0f000000),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
        color: Colors.white,
      ),
      child: Row(children: [
        Container(
            height: 50,
            width: 50,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xffEDEDFF)),
            ),
            child: organisation.isNotEmpty
                ? Image(
                    image: NetworkImage(organisation.isNotEmpty
                        ? organisation[orState.selctedNode].avatarUrl ?? ""
                        : "..."))
                : Container()),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (pState.profile?['name']) ?? "Guest",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: primaryTextClr,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: const Color(0xff22CCCC),
                  ),
                  child: Text(
                    organisation.isNotEmpty
                        ? organisation[orState.selctedNode].login ?? ""
                        : "...",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  )),
            ],
          ),
        )
      ]),
    ),
  );
}

Widget body(context) {
  return Consumer2<OrganisationState, RepoState>(
      builder: (context, state, rState, _) {
    var repo = rState.repo;
    var organisation = state.organisation;
    var isEmptyOrg = state.organisation.isEmpty;
    return Expanded(
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(16, 60, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
         isEmptyOrg ?Container():   const Hero(
              tag: "title",
              child: Material(
                type: MaterialType.transparency,
                child: Text(
                  "Projects",
                  style: TextStyle(
                      color: primaryTextClr,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
                child: isEmptyOrg
                    ? HelperWidgets().progressIndicator()
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: repo.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => HomeController()
                                .pushRepoScreen(context, rState, index),
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: const Color(0xffEDEDFF)),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                      height: 40,
                                      width: 40,
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: const Color(0xffEDEDFF)),
                                      ),
                                      child: Image(
                                          image: NetworkImage(organisation
                                                  .isNotEmpty
                                              ? organisation[state.selctedNode]
                                                      .avatarUrl ??
                                                  ""
                                              : "..."))),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          repo[index].name ?? "",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: primaryTextClr,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          repo[index].owner!.login ?? "",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Color(0xff5F607E),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Image(
                                      width: 22,
                                      image:
                                          AssetImage("assets/arrow-left.png"))
                                ],
                              ),
                            ),
                          );
                        }))
          ],
        ),
      ),
    );
  });
}

Widget drawerItem(Organisation? organisation, bool isSelected, callback) {
  return Column(
    children: [
      GestureDetector(
        onTap: () => callback(),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: isSelected ? const Color(0xffD3DEFF) : Colors.transparent,
              borderRadius: BorderRadius.circular(5)),
          child: Row(
            children: [
              Container(
                  height: 40,
                  width: 40,
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(color: const Color(0xffEDEDFF)),
                  ),
                  child: organisation?.avatarUrl == null
                      ? Icon(
                          Icons.hourglass_empty,
                          color: Colors.grey.withOpacity(0.5),
                        )
                      : Image(
                          image: NetworkImage(organisation?.avatarUrl ?? ""))),
              const SizedBox(width: 12),
              Text(
                toBeginningOfSentenceCase(organisation!.login!),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: primaryTextClr,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 10),
    ],
  );
}

Widget logoutCard(context) {
  return Column(
    children: [
      GestureDetector(
        onTap: () async {
          await UserDefault.setLoginStatus(false);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const InitialScreen()),
              (Route<dynamic> route) => false);
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(5)),
          child: Row(
            children: [
              Container(
                  height: 40,
                  width: 40,
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(color: const Color(0xffEDEDFF)),
                  ),
                  child: const Image(image: AssetImage("assets/logout.png"))),
              const SizedBox(width: 12),
              const Text(
                "Logout",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: primaryTextClr,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 10),
    ],
  );
}
