import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:i_padeel/constants/app_colors.dart';
import 'package:i_padeel/models/location.dart';
import 'package:i_padeel/screens/discover/widgets/locations_list_item.dart';
import 'package:i_padeel/utils/shadow_text.dart';

class DiscoverLocationsList extends StatefulWidget {
  DiscoverLocationsList({Key? key}) : super(key: key);
  List<Location> _locations = [Location(), Location(), Location(), Location()];
  bool _loading = false;
  bool _isInit = false;
  bool _reachedEndOfPage = false;
  @override
  _DiscoverLocationsListState createState() => _DiscoverLocationsListState();
}

class _DiscoverLocationsListState extends State<DiscoverLocationsList> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      child: widget._loading
          ? const Center(
              child: CircularProgressIndicator(
              backgroundColor: AppColors.secondaryColor,
            ))
          : (!widget._loading && widget._locations.isEmpty)
              ? const Center(
                  child: Text(
                    "No Locations to show",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
              : Container(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text("Locations",
                              maxLines: 3,
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15)),
                          Expanded(child: Container()),
                          const Text("View all",
                              maxLines: 3,
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12)),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 16),
                        width: size.width,
                        height: size.height * 0.4,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: widget._locations.length,
                          itemBuilder: (context, innerIndex) {
                            return GestureDetector(
                              onTap: () {
                                print("selected item # x");
                              },
                              child: Container(
                                  margin: EdgeInsets.only(
                                      right: 10, bottom: 10, left: 10),
                                  height: size.height * 0.3,
                                  child: LocationsListItem(
                                    name: "Al ahly club",
                                    card:
                                        "https://media.istockphoto.com/photos/south-port-beach-boardwalk-at-sunset-picture-id1239827155?s=612x612",
                                    logo:
                                        "https://media.istockphoto.com/photos/south-port-beach-boardwalk-at-sunset-picture-id1239827155?s=612x612",
                                    location: 'Nasr city',
                                    price: 'EG 500/hr',
                                  )),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
