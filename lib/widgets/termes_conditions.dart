import 'package:flutter/material.dart';
import 'package:i_padeel/utils/page_builder.dart';
import 'package:i_padeel/utils/page_helper.dart';
import 'package:slide_drawer/slide_drawer.dart';

class TermsAndConditions extends StatefulWidget {
  static const routeName = '/termsAndConditions';
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  final Function(BuildContext)? returnContext;

  TermsAndConditions({Key? key, this.returnContext}) : super(key: key);

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions>
    with PageHelper {
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

  @override
  Widget build(BuildContext context) {
    return buildPage(
      PageBuilder(
        scaffoldKey: widget.scaffoldkey,
        context: context,
        appBarTitle: 'Terms & Conditions',
        leading: IconButton(
          onPressed: () => SlideDrawer.of(context)?.toggle(),
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(16),
            child: const Text(
              """iPadel (“us,” “we,” or “iPadel”) is committed to respecting the privacy rights of the visitors and registered users of iPadel (the “App”) and the services provided by iPadel through the App (collectively, the “Services”). By using the App, and/or by registering with Us, You signify that you agree to the practices and policies outlined in this privacy policy and that you hereby consent that we will collect, use and share your information in the manner stipulated by this policy.


1. Collected Infomation


We collect General Information pertaining to the IP addresses, domain servers, types of devices accessing the App, types of browsers and their associated interaction with the app and referring sources to th


We collect Personal Information in order to identify you such as your contact information (email address, password, & mobile number), demographics (date of birth, gender and address), service related information (previous activities, bookings, reservations, purchases, past history, and other related informa


We collect Voluntary Information in order to provide you with the relevant services (searching for activities, completing booking/purchase forms, booking spots, paying down payments, purchasing tickets, reviews, surveys, questionnaires and similar ser


2. Use of Cookies, Web Beacons & Analytics


We may use Cookies (small computer files stored on your device) that contain information such as user ID, user preferences, lists of pages visited and activities conducted while using the App to help us improve our App by tracking your navigation habits and to store some of your preferences in order to customize your exper


We may use web beacons (small image files in webpages/emails) and third party website analytics services to collect anonymous, non-personal information about your use of our Services. These tools never identify You, they only allow Us to statistically monitor utilization and usability patterns of the Services and t


3. Use of Your Information


We may use Collected Information to recommend activities, products, services, send reminders, contact you, allow activity providers to refer you and book spots, pay down payments, buy tickets, allow third party associates/partners deliver the required services to your address, construct statistical research on individual or aggregate entertainment/service trends in an anonymous manner that does not tie this information directly back 


4. Managing Your Submitted Content


Submitted content may be stored indefinitely, even after receiving a close account request. Certain fields may be modified and updated such as those pertaining to your Personal Information and relating to activity forms. You can modify some of the Personal Information you have included in your profile and/or related


5. Sharing of Infomation


We may share your General and Personal Information with activity providers when booking an appointment. We may share your General and Personal Information with business partners who help us deliver the various services including supporting functions offered under iPadel such as hosting, billing, fulfillment, storage, support, 


We may share your anonymous general and personal information with marketing affiliates when running marketing metrics, pushing targeted advertising or delivering promotional material. However, well not share, rent or sell your Personal Information to any third party for their promotional pur


We may share your anonymous General and Personal Information with third parties to enable them to construct statistical research on individual and aggregate consumer trends and de


We may transfer your information to another company in connection to a merger, sale or acquisition of iPadel or 


6. Event Providers, Venues & Services


Activity Providers and their employees should always maintain their obligations towards User confidentiality as stipulated by law both in communicating with iPadel and in responding to a review of their services posted on our App. iPadel does not have, and will not accept, any obligations of confidentiality regarding any communications other than those specifically stated in this Privacy Policy and Terms Of S


7. Public Information, Recordings & Transmissions


Information you submit in a review or forum is considered public information. You are strongly advised to assess the content you are disclosing as it may be collected and used by third parties in a manner beyond our co


You agree that the event for which you booked is a public event, that your appearance and actions inside and outside the venue where the event occurs are public in nature, and that you have no expectation of privacy with regard to your actions or conduct at the 


You grant permission to us to utilize your name, image, likeness, acts, poses, plays, appearance, movements, and statements in any live or recorded audio, video, or photographic display at, the event for any purpose, without further authorization from, or compensation to, you or anyone acting on your 


8. Links to Third Party Webistes


The App may contain links to third party websites with which iPadel has no affiliation. Accordingly, we do not share your Personal Information with them nor are we responsible for their private pra


9. Security


Reasonable security practices are followed to protect and safe guard your information such as encrypting sensitive information using secure socket layer technology (“SSL”). As there can be no100% guaranteed fail safe mean of safeguarding your information, we will use reasonable efforts as soon as reasonably possible to notify you in the event a breach of this nature that impacts you 


10. Confidentiality


Except as stipulated in this Privacy Policy and in the Terms & Conditions your personal information will remain confidential unless it is necessary to comply with a court order, a legal process and/or protect the rights and interests of iPadel


11. Location


iPadel platform will only access your location while you are using the application to sort and show results nearest to your current lo


12. Updates and Changes to Privacy


The Privacy Policy may change from time to time. Such changes will be posted in the site and or app. Your continued use of the App will signify your acceptance and agreement to the updated Privacy Policy. Accordingly any collected information is subject to the Privacy Policy in effect at the time of collection.
            """,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
