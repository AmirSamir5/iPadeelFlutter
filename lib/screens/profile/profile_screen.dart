import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:i_padeel/constants/app_colors.dart';
import 'package:i_padeel/models/user.dart';
import 'package:i_padeel/network/refresh_token.dart';
import 'package:i_padeel/providers/auth_provider.dart';
import 'package:i_padeel/providers/user_provider.dart';
import 'package:i_padeel/screens/login&signup/signup_screen.dart';
import 'package:i_padeel/utils/date_converter.dart';
import 'package:i_padeel/utils/page_builder.dart';
import 'package:i_padeel/utils/page_helper.dart';
import 'package:i_padeel/utils/show_dialog.dart';
import 'package:i_padeel/utils/urls.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/Profile_Screen';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with PageHelper {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  bool _isInit = true;
  bool _isLoading = true;
  User? user;

  @override
  void initState() {
    if (_isInit) {
      Future.delayed(Duration.zero, () async {
        bool isLoggedIn =
            await Provider.of<AuthProvider>(context, listen: false)
                .isLoggedIn();
        if (isLoggedIn) {
          user = await Provider.of<UserProvider>(context, listen: false)
              .getUserData();
          setState(() {
            _isLoading = false;
          });
        }
      });
      _isInit = false;
    }
    super.initState();
  }

  Widget _profileItem(String title, IconData icon) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                icon,
                color: Colors.white,
              ),
              const SizedBox(width: 20),
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
        ),
        const Divider(color: Colors.white),
      ],
    );
  }

  Widget _phoneItem(String title, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  Icon(
                    icon,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 20),
                  Text(
                    title,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
              !user!.isVerified!
                  ? const SizedBox()
                  : const Text(
                      'Verify Now!!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    )
            ],
          ),
        ),
        const Divider(color: Colors.white),
      ],
    );
  }

  Future<void> _getUserProfile() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<UserProvider>(context, listen: false).getUserProfile();
      user =
          await Provider.of<UserProvider>(context, listen: false).getUserData();
    } on HttpException catch (error) {
      if (error.message == '401') {
        RefreshTokenHelper.refreshToken(
          context: context,
          successFunc: () {
            _getUserProfile();
          },
        );
      } else {
        ShowDialogHelper.showDialogPopup('Error!', error.message, context, () {
          Navigator.of(context).pop();
        });
      }
    } on SocketException catch (_) {
      ShowDialogHelper.showDialogPopup("Error",
          "Please check your internet connection and try again", context, () {
        Navigator.of(context).pop();
      });
    } catch (error) {
      ShowDialogHelper.showDialogPopup(
          "Error", "Sorry, an unexpected error has occurred.", context, () {
        Navigator.of(context).pop();
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildPage(
      PageBuilder(
          scaffoldKey: _scaffoldkey,
          appBarTitle: 'Profile',
          context: context,
          appBarActions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegistrationScreen(
                        user: user,
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ))
          ],
          body: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: AppColors.secondaryColor,
                  ),
                )
              : (user == null)
                  ? Container(
                      margin: const EdgeInsets.all(32),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            _getUserProfile();
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Image.asset(
                                'assets/images/retry.png',
                                color: Colors.white,
                                width: 80,
                                fit: BoxFit.fill,
                              ),
                              const Text(
                                'Something went wrong, Please click here to retry!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.all(32),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            (user!.photo == null)
                                ? CircleAvatar(
                                    radius:
                                        MediaQuery.of(context).size.width / 6,
                                    backgroundColor: Colors.transparent,
                                    child: Image.asset(
                                        'assets/images/user-profile.png'),
                                  )
                                : Container(
                                    height: 180,
                                    width: 180,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: OptimizedCacheImage(
                                      imageUrl: Urls.domain +
                                          (user!.photo ??
                                              "https://images.unsplash.com/photo-1499510318569-1a3d67dc3976?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=928&q=80"),
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        width: 80.0,
                                        height: 80.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          LinearProgressIndicator(
                                        backgroundColor: Colors.transparent,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.black.withOpacity(0.2)),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                            const SizedBox(height: 24),
                            _profileItem(
                              (user!.firstName ?? "") +
                                  " " +
                                  (user!.lastName ?? ""),
                              Icons.person,
                            ),
                            _profileItem(
                              user!.email ?? "",
                              Icons.email,
                            ),
                            _phoneItem(
                              user!.phone ?? "",
                              Icons.phone,
                            ),
                            _profileItem(
                              DateConverter.convertDateFormat(
                                      user!.dateOfBirth) ??
                                  "",
                              Icons.calendar_today,
                            ),
                            _profileItem(
                              user!.rating!.name!,
                              Icons.star_rate,
                            ),
                            _profileItem(
                              user!.gender ?? "Male",
                              ((user!.gender ?? "Male").toLowerCase() ==
                                      "female")
                                  ? Icons.female
                                  : Icons.male,
                            ),
                            _profileItem(
                              user!.noOfRes.toString() + " Bookings",
                              Icons.sports,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: TextButton.icon(
                                onPressed: () {
                                  // Navigator.of(context).pushNamed(
                                  //     ResetPassword.routeName,
                                  //     arguments: false);
                                },
                                icon: const Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                ),
                                label: const Text(
                                  'Change password?',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
    );
  }
}
