import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:i_padeel/constants/app_colors.dart';
import 'package:i_padeel/providers/auth_provider.dart';
import 'package:i_padeel/providers/locations_provider.dart';
import 'package:i_padeel/screens/create_reservation/reservation_screen.dart';
import 'package:i_padeel/screens/home/widgets/locations_list_item.dart';
import 'package:i_padeel/utils/show_dialog.dart';
import 'package:provider/provider.dart';

class DiscoverLocationsList extends StatefulWidget {
  DiscoverLocationsList({Key? key}) : super(key: key);
  bool _isInit = false;
  @override
  _DiscoverLocationsListState createState() => _DiscoverLocationsListState();
}

class _DiscoverLocationsListState extends State<DiscoverLocationsList> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (!widget._isInit) {
      widget._isInit = true;
      _loadLocations();
    }
  }

  void _loadLocations() {
    Provider.of<LocationsProvider>(context, listen: false).fetchLocations();
  }

  @override
  Widget build(BuildContext context) {
    bool isAuth = Provider.of<AuthProvider>(context).isAccountAuthenticated;
    final size = MediaQuery.of(context).size;
    final locations = Provider.of<LocationsProvider>(context).locations;
    final isLoading = Provider.of<LocationsProvider>(context).isLoading;
    final failedToLoad = Provider.of<LocationsProvider>(context).failedToLoad;
    return failedToLoad
        ? GestureDetector(
            onTap: () {
              _loadLocations();
            },
            // ignore: sized_box_for_whitespace
            child: Container(
              child: const SizedBox(
                height: 60,
                width: 60,
                child: Center(
                    child: Icon(Icons.redo, color: AppColors.secondaryColor)),
              ),
            ),
          )
        : isLoading
            ? const SizedBox(
                height: 60,
                width: 60,
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.secondaryColor,
                  ),
                ))
            : Container(
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                        backgroundColor: AppColors.secondaryColor,
                      ))
                    : (!isLoading && locations.isEmpty)
                        ? const Center(
                            child: Text(
                              "No Locations to show",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          )
                        : Container(
                            margin: const EdgeInsets.only(left: 16, top: 16),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      child: const Text(
                                        "Locations",
                                        maxLines: 3,
                                        textDirection: TextDirection.ltr,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Avenir',
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: SizedBox(
                                    width: size.width,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: locations.length,
                                      itemBuilder: (context, innerIndex) {
                                        final item = locations[innerIndex];
                                        return GestureDetector(
                                          onTap: isAuth
                                              ? () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (ctx) =>
                                                              ReservationScreen(
                                                                location: item,
                                                              )));
                                                }
                                              : () {
                                                  ShowDialogHelper
                                                      .showDialogPopup(
                                                    'Attention',
                                                    'You must Login First',
                                                    context,
                                                    () => Navigator.of(context)
                                                        .pop(),
                                                  );
                                                },
                                          child: LocationsListItem(
                                            name: item.name,
                                            card: item.image ?? "",
                                            location: item.address,
                                            price: 'EGP ${item.slotPrice}/hr',
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
              );
  }
}
