import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:slide_drawer/slide_drawer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/page_builder.dart';
import '../../utils/page_helper.dart';

class ContactUsScreen extends StatefulWidget {
  static const routeName = '/contactUs';
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  final Function(BuildContext)? returnContext;

  ContactUsScreen({Key? key, this.returnContext}) : super(key: key);
  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> with PageHelper {
  bool _isInit = true;
  @override
  void initState() {
    if (_isInit) {
      _isInit = false;
      if (widget.returnContext == null) return;
      widget.returnContext!(context);
    }
    super.initState();
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  @override
  Widget build(BuildContext context) {
    return buildPage(
      PageBuilder(
        scaffoldKey: widget.scaffoldkey,
        context: context,
        appBarTitle: 'Contact Us',
        leading: IconButton(
          onPressed: () => SlideDrawer.of(context)?.toggle(),
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(32),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      child: const Text(
                        '01210743333',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Avenir',
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                          decorationThickness: 2,
                        ),
                      ),
                      onPressed: () async {
                        final Uri launchUri = Uri(
                          scheme: 'tel',
                          path: '01210743333',
                        );
                        await launchUrl(launchUri);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.instagram,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextButton(
                        child: const Text(
                          'https://instagram.com/ipadel_eg?igshid=YmMyMTA2M2Y=',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Avenir',
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                            decorationThickness: 2,
                          ),
                        ),
                        onPressed: () async {
                          // final Uri emailLaunchUri = Uri(
                          //   scheme: 'mailto',
                          //   path: 'smith@example.com',
                          //   query: encodeQueryParameters(<String, String>{
                          //     'subject': 'Example Subject & Symbols are allowed!'
                          //   }),
                          // );
                          var url = Uri.parse(
                              'https://instagram.com/ipadel_eg?igshid=YmMyMTA2M2Y=');

                          if (await canLaunchUrl(url)) {
                            await launchUrl(
                              url,
                            );
                          } else {
                            throw 'There was a problem to open the url: $url';
                          }
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
