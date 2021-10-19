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
    return buildPage(PageBuilder(
        scaffoldKey: widget.scaffoldkey,
        context: context,
        leading: IconButton(
          onPressed: () => SlideDrawer.of(context)?.toggle(),
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'The following terms and conditions constitute an agreement between you and iPadeel, the operator of iPadeel.com (the “App”). These terms and conditions (the “Terms &amp; Conditions”) govern your use of the App, both as a casual visitor, and as a registered user.\n\n By using the App, and/or by registering with Us, You signify that you agree to these Terms &amp; Conditions and the associated practices disclosed in our Privacy Policy',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Definitions',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'You, Your, User: Any user of the App\nWe or Us: iReserve S.A.E\niReserve S.A.E: the operator of iPadeel\nApp: Mobile Application, Desktop Application, and/or Web Application (website)\nProvider: Any activity provider of entertainment services be it an entity or a single person',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    '1. About the App',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'iPadeel is an online reservation platform that manages and automates the reservation and back-office processes of activity providers allowing them the capacity to better engage their customers. It is a convenient tool for Users to access the various activities available in their communities such as Restaurants, Night life, Gyms, Summer Camps, Car Wash, Training Centers, Car Maintenance, Hair Salons. Spas and much more',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'iPadeel is a turnkey service that aims to integrate the various stakeholders in the entertainment/services community under one cohesive environment. Accordingly everything provided/offered under this environment is collectively referred to as “Services” from here on.',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'iPadeel amongst other things facilitates scheduling, booking, down payment and ticket purchase services with activity providers. These providers are contractually engaged and pay a fee in order to appear on the App. Provider profiles are listed subject to the selection criteria set forth by you.',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'The App does not recommend, endorse specific providers, products, other sites and/or opinions nor does it make any representations or warranties with respect to these Providers nor the quality of the services they may provide. It is explicitly noted that the choice of the provider is your sole responsibility. Accordingly, under no baseEntity shall we be liable to You or anyone else for actions resulting from the use of such services.',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      'The App does not guarantee the accuracy of information nor its timely update to reflect any changes that may have occurred since its publication whether this information is provided by the App’s personnel or the providers.'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'To gain complete access of the App You must register and authorize the use and disclosure of your personal information to iPadeel, its affiliates and the activity providers for the purpose of delivering the Services to You subject to our Privacy Policy. The use of the App constitutes your electronic signature and agreement to this policy and Terms &amp; Conditions',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'We have no control over, and cannot guarantee the availability of any Provider at any particular time. We will not be liable for cancelled or otherwise unfulfilled appointments or any injury resulting therefrom, or for any other injury resulting from the use of the App or Services whatsoever.',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'From time to time new services may be added and old services discontinued. You agree that iPadeel will not be liable to you or any third party for any suspension or discontinuation of any of the Services.',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'We may terminate you registration at any time should we feel there is a violation of the Terms &amp; Conditions without the need to give a prior notice.',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'The Terms and conditions may change from time to time. Such changes will be posted in the App. Your continued use of the App will signify your acceptance and agreement to the new Terms &amp; Conditions.',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    '2. Your Responsibilities',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'You are responsible for the use of the App in a manner that does not violate the applicable laws pertaining to spamming, copying, modifying, adapting, translating, retrieving, indexing, reverse engineering or gaining unauthorized access to any portion of the App or the Services provided. Furthermore you hereby agree to refrain from engaging in activities that misuse the Service and may accordingly impair the overall experience of other users.',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      'You acknowledge that the information contained in the App, technology, systems or software contains iReserve proprietary information.'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'You are responsible for the information you provide and agree to exercise reasonable efforts to ensure the validity of this information. Moreover you grant iPadeel the right to remove or delete any information that it deems as inappropriate or violates the Terms &amp; Conditions without the need to give any prior notice.',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    '3. Content You Post or Submit',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'You hereby agree to and grant iReserve, its contractors, and the users of the App an irrevocable, perpetual, royalty-free, fully paid up right to use, copy, publicly perform, digitally perform, publicly display, and distribute such Content and to adapt, edit, translate, prepare derivative works of, or to incorporate it into other such works.',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'You hereby grant iReserve the right of utilizing the content that you post or submit along with the content posted and submitted by other users for the purpose of constructing or populating a searchable database of reviews and information related to the offered services.',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    '4. Relationship between Parties',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Nothing in this Agreement shall be construed as establishing a partnership, joint venture, or employer-employee, provider-User relationship between the parties. Neither party is authorized to act towards any third party in a manner that would indicate any such relationship with the other.',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    '5. Privacy Policy',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'iPadeel (“us,” “we,” or “iReserve”) is committed to respecting the privacy rights of the visitors and registered users of iPadeel (the “App”) and the services provided by iReserve through the App (collectively, the “Services”).  By using the App, and/or by registering with Us, You signify that you agree to the practices and policies outlined in this privacy policy and that you hereby consent that we will collect, use and share your information in the manner stipulated by this policy.',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'a) Collected Information',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'We collect General Information pertaining to the IP addresses, domain servers, types of devices accessing the App, types of browsers and their associated interaction with the app and referring sources to the app.',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'We collect Personal Information in order to identify you such as your contact information (email address, password, &amp; mobile number), demographics (date of birth, gender and address), service related information (previous activities, bookings, reservations, purchases, past history, and other related information).',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'We collect Voluntary Information in order to provide you with the relevant services (searching for activities, completing booking/purchase forms, booking spots, paying down payments, purchasing tickets, reviews, surveys, questionnaires and similar services).',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'b) Use of Cookies, Web Beacons &amp; Analytics',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'We may use Cookies (small computer files stored on your device) that contain information such as user ID, user preferences, lists of pages visited and activities conducted while using the App to help us improve our App by tracking your navigation habits and to store some of your preferences in order to customize your experience.',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'We may use web beacons (small image files in webpages/emails) and third party website analytics services to collect anonymous, non-personal information about your use of our Services. These tools never identify You, they only allow Us to statistically monitor utilization and usability patterns of the Services and the App.',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'c) Use of Your Information',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'We may use Collected Information to recommend activities, products, services, send reminders, contact you, allow activity providers to refer you and book spots, pay down payments, buy tickets, allow third party associates/partners deliver the required services to your address, construct statistical research on individual or aggregate entertainment/service trends in an anonymous manner that does not tie this information directly back to you.',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'd) Managing Your Submitted Content',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Submitted content may be stored indefinitely, even after receiving a close account request. Certain fields may be modified and updated such as those pertaining to your Personal Information and relating to activity forms. You can modify some of the Personal Information you have included in your profile and/or related forms.',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'e) Sharing of Information',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'We may share your General and Personal Information with activity providers when booking an appointment. We may share your General and Personal Information with business partners who help us deliver the various services including supporting functions offered under iPadeel such as hosting, billing, fulfillment, storage, support, etc',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'We may share your anonymous general and personal information with marketing affiliates when running marketing metrics, pushing targeted advertising or delivering promotional material. However, well not share, rent or sell your Personal Information to any third party for their promotional purposes.',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'We may share your anonymous General and Personal Information with third parties to enable them to construct statistical research on individual and aggregate consumer trends and demands.',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'We may transfer your information to another company in connection to a merger, sale or acquisition of iPadeel or iReserve.',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'f) Event Providers, Venues &amp; Services',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Activity Providers and their employees should always maintain their obligations towards User confidentiality as stipulated by law both in communicating with iReserve and in responding to a review of their services posted on our App. iReserve does not have, and will not accept, any obligations of confidentiality regarding any communications other than those specifically stated in this Privacy Policy and Terms &amp; Conditions.',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'g) Public Information, Recordings &amp;  Transmissions',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Information you submit in a review or forum is considered public information. You are strongly advised to assess the content you are disclosing as it may be collected and used by third parties in a manner beyond our control.',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'You agree that the baseEntity for which you booked is a public baseEntity, that your appearance and actions inside and outside the venue where the baseEntity occurs are public in nature, and that you have no expectation of privacy with regard to your actions or conduct at the baseEntity.',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'You grant permission to us to utilize your name, image, likeness, acts, poses, plays, appearance, movements, and statements in any live or recorded audio, video, or photographic display at, the baseEntity  for any purpose, without further authorization from, or compensation to, you or anyone acting on your behalf.',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'h) Links to Third Party Websites',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'The App may contain links to third party websites with which iReserve has no affiliation. Accordingly, we do not share your Personal Information with them nor are we responsible for their private practices.',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'i) Security',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Reasonable security practices are followed to protect and safe guard your information such as encrypting sensitive information using secure socket layer technology (“SSL”). As there can be no100% guaranteed fail safe mean of safeguarding your information, we will use reasonable efforts as soon as reasonably possible to notify you in the baseEntity a breach of this nature that impacts you occurs.',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'j) Confidentiality',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Except as stipulated in this Privacy Policy and in the Terms &amp; Conditions your personal information will remain confidential unless it is necessary to comply with a court order, a legal process and/or protect the rights and interests of iPadel',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'k) Updates and Changes to Privacy Policy',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'The Privacy Policy may change from time to time. Such changes will be posted in the site and or app. Your continued use of the App will signify your acceptance and agreement to the updated Privacy Policy. Accordingly any collected information is subject to the Privacy Policy in effect at the time of collection.',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    '6. Purchase Policy',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                      'Our objective is to simplify your booking and purchasing experience, in order to allow you to get to the baseEntity in a hassle free manner. The following highlights the booking / purchase process through the App subject to these terms.'),
                  SizedBox(
                    height: 5,
                  ),
                  Text('a) Payment Methods &amp; Pricing'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      'iPadeel acts as the agent to those who provide baseEntities, such as venues, activity providers and service providers. Payments are in the currency of the country where the baseEntity is being held. We accept several methods of payment to accommodate your needs including but not limited to credit cards, debit cards, Fawry and cash on arrival as per the guidelines set forth by the activity provider.'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      'We collect down payments and sell tickets on behalf of Event Providers, which means we do not set item prices or determine seating locations. Tickets are generally sold through several distribution points, including online, phone centers, iPadeel retail locations'),
                  SizedBox(
                    height: 5,
                  ),
                  Text('b) Order Confirmation'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      'If you do not receive a confirmation number (in the form of a confirmation page or email) after submitting payment information, or if you experience an error message or service interruption after submitting payment information, it is your responsibility to confirm via your iPadeel account or customer service whether or not your order has been placed. Only you may be aware of any problems that may occur during the purchase process. We will not be responsible for losses (monetary or otherwise) if you assume that an order was not placed because you failed to receive confirmation.'),
                  SizedBox(
                    height: 5,
                  ),
                  Text('c) Service Fees and Order Processing Fees'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      'Bookings / purchases done through the App are typically subject to a per booked spot / ticket service fee and a non-refundable per order processing fee unless stated otherwise. In some cases, delivery prices may apply.'),
                  SizedBox(
                    height: 5,
                  ),
                  Text('d) Booking Limits'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      'When making bookings or purchases through the App, you are limited to a specified number of spots for each baseEntity. This limit is posted during the booking /purchase process and is verified with every transaction. This policy is in effect to discourage unfair practices. We reserve the right to cancel any or all bookings and tickets without notice to you if you exceed the posted limits. This includes orders associated with the same name, e-mail address, billing address, credit card number or other information.'),
                  SizedBox(
                    height: 5,
                  ),
                  Text('e) Cancellations, Rescheduling and Refunds'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      'Occasionally, baseEntities are canceled or postponed. Should this occur, we will attempt to contact you to inform you of refund or exchange procedures for that baseEntity. For exact instructions on any canceled or postponed baseEntity, please check the baseEntity information online or contact us.'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      'Before booking spots / purchasing tickets, carefully review your baseEntity and seat selection. Policies set forth by Event Providers generally prohibit us from issuing exchanges or refunds after a booking has been made or ticket has been purchased or lost, stolen, damaged or destroyed. There are no refunds, returns or exchanges for digital downloads.'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      'If we issue you a refund for a booking / ticket due to a canceled or postponed baseEntity, we will issue a refund of the ticket\'s face value paid and all service fees. In no baseEntity will delivery charges or any other amounts be refunded.. We will not be liable for travel or any other expenses that you or anyone else incurs in connection with a canceled or postponed baseEntity.'),
                  SizedBox(
                    height: 5,
                  ),
                  Text('f) Delivery Options'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      'Different combinations of delivery methods may be offered, depending on factors that include the venue, how much time is left before the baseEntity starts, and the nature of the demand for the baseEntity ranging from delivery via a runner to electronic delivery.'),
                  SizedBox(
                    height: 5,
                  ),
                  Text('g) Pricing and Other Errors'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      'If the amount you pay for a booking / ticket is incorrect regardless of whether because of an error in a price posted on the App or otherwise communicated to you, or you are able to book a spot or order a ticket that was not supposed to have been released for sale, then we will have the right to cancel that booking / ticket (or the order for that ticket) and refund to you the amount that you paid. This will apply regardless of whether because of human error or a transactional malfunction of App or other iPadeel systems.'),
                  SizedBox(
                    height: 5,
                  ),
                  Text('h) Ejection, Cancellation &amp; No Redemption Value'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      'Event Providers reserve the right, without refund of any amount paid, to refuse admission to, or eject, any person whose conduct management deems disorderly, who uses vulgar or abusive language or who fails to comply with Event Provider rules Which may prohibit entry of certain material into the premises, including without limitation, alcohol, drugs, controlled substances, cameras, recording devices, laser pointers, strobe lights, irritants (e.g., artificial noisemakers), bundles and containers. Breach of terms or rules will terminate your license to attend the baseEntity without refund.'),
                  SizedBox(
                    height: 5,
                  ),
                  Text('i) Unlawful Resale of Bookings / Tickets'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      'Unlawful resale (or attempted resale), counterfeit or copy of bookings / tickets is grounds for seizure and cancellation without compensation. You are responsible for complying with all applicable ticket resale laws. In addition, we reserve the right to restrict or deny booking reservation / ticket purchasing privileges to anyone that we determine to be, or has been, in violation of our policies.'),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    '7. Limitation of Liability',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                      'Under no circumstances shall iReserve, its affiliates, partners or their respective employees be liable for any direct, indirect, incidental, special, punitive or consequential damages that result in any way from Your use of or inability to use the Services, or any part thereof, or Your reliance on or use of information, services or merchandise provided on the App or through the Services, or that result from mistakes, omissions, interruptions, deletion of files, errors, defects, delays in operation or transmission, any failure of performance, computer virus, communication line failure, theft or destruction or unauthorized access to, alteration of or use of Your account, whether for breach of contract, negligence or under any other cause of action.'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      'If the User is dissatisfied with the Service or with any terms, conditions, rules, policies, guidelines or practices of iReserve in operating the Service, Your sole and exclusive remedy is to discontinue using the Service.'),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    '8. Disclaimer of Warranties',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                      'We have no special relationship with or fiduciary duty to you. You acknowledge that we have no control over, and no duty to take any action regarding: which users gain access to the App and/or the Services; what content you access via the App and/or the Services; what effects the content on the App and/or the Services may have on you; how you may interpret or use the content on the App and/or the Services; or what actions you may take as a result of having been exposed to the content on the App and/or the Services. You release us from all liability for you having acquired or not acquired content through the App and/or the Services.'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      'The App and/or the Services may contain, or direct you to pages containing, information that some people may find offensive or inappropriate. We make no representations concerning any content contained in or accessed through the App and/or the Services, and we will not be responsible or liable for the accuracy, copyright compliance, legality or decency of material contained in or accessed through the App and/or the Services.'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      'We make no representations or warranties regarding suggestions or recommendations of services or products offered or purchased through the App and/or the Services.'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      'We provide the App and the services “as is”, “with all faults” and “as available.” We make no express or implied warranties or guarantees about the services. To the maximum extent permitted by law, we hereby disclaim all such warranties, including all statutory warranties, with respect to the services and the App, including without limitation any warranties that the services are merchantable, of satisfactory quality, accurate, fit for a particular purpose or need, or non-infringing.'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      'We do not guarantee that the results that may be obtained from the use of the services will be effective, reliable or accurate or will meet your requirements. We do not guarantee that you will be able to access or use the services (either directly or through third-party networks) at times or locations of Your choosing.'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      'We are not responsible for the accuracy, reliability, timeliness or completeness of information provided by users of the App or any other data or information provided or received through the App. Except as expressly set forth herein, iReserve makes no warranties about the information systems, software and functions made accessible through the App or any other security associated with the transmission of sensitive information.'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      'iReserve does not warrant that the App or the services will operate error-free, that loss of data will not occur, or that the services, software or App are free of computer viruses, contaminants or other harmful items.'),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    '9. Indemnification',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                      'You agree to defend, indemnify, and hold harmless iPadeel, its employees, contractors, officers, directors, agents, other affiliated companies, suppliers, successors, and assigns from all liabilities, claims, demands and expenses, including attorney\'s fees, made by any third party that arise from or are related to (a) your access to the App, (b) your use of the Services, or (c) the violation of these Terms of Use, or of any intellectual property or other right of any person or entity, by you or any third party using your Credentials.'),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    '10. Entire Agreement',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                      'This Agreement, including the Privacy Policy and all supplemental terms supersedes and cancels all prior negotiations, communications, understandings and Agreements between You and Us. In the baseEntity that any provision of this Agreement is held void or unenforceable, the entire balance of this Agreement shall remain in full force and effect.'),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    '11. Assignment',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                      'We may assign this contract at any time to any parent, subsidiary, or any affiliated company, or as part of the sale to, merger with, or other transfer of our company to another entity. We will use reasonable efforts to notify you regarding any change of ownership. You may not assign, transfer or sublicense these Terms &amp; Conditions to anyone else and any attempt to do so in violation of this section shall be null and void.'),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    '12. The Governing Laws',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                      'It is agreed that any dispute arising out of or in connection with this agreement, including any question regarding its existence, validity or termination, shall be referred to and finally resolved in the competent courts of Cairo subject to the applicable laws of the Arab Republic of Egypt.'),
                  SizedBox(
                    height: 5,
                  ),
                  Text('Last Updated on April 7th, 2017.'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      'Copyright (©) 2009-2017 iPadeel.. All rights reserved.'),
                ]),
          ),
        )));
  }
}
