import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class LocationsListItem extends StatefulWidget {
  String _name;
  String _card;
  String _logo;
  String _location;
  String _price;

  LocationsListItem({
    required String name,
    required String card,
    required String logo,
    required String location,
    required String price,
  })  : this._name = name,
        this._card = card,
        this._logo = logo,
        this._price = price,
        this._location = location {}

  @override
  _LocationsListItemState createState() => _LocationsListItemState();
}

class _LocationsListItemState extends State<LocationsListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width / 2,
      decoration: BoxDecoration(
          /*borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              topLeft: Radius.circular(25),
              topRight: Radius.circular(5),
              bottomLeft: Radius.circular(5)),*/
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              offset: Offset(0, 3),
              spreadRadius: 5,
              blurRadius: 7,
            )
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        child: Stack(fit: StackFit.expand, children: <Widget>[
          /* CachedNetworkImage(
            imageUrl: widget._card,
            placeholder: (context, url) => Center(
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: LinearProgressIndicator(
                  backgroundColor: Colors.transparent,
                  valueColor: new AlwaysStoppedAnimation<Color>(
                      Colors.black.withOpacity(0.2)),
                ),
              ),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),*/
          Container(
            child: Image.asset("assets/images/tennisCourt.jpeg"),
          ),
          Column(
            children: [
              Flexible(
                flex: 9,
                child: Container(),
              ),
              Flexible(
                flex: 5,
                child: Stack(children: [
                  SizedBox(
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          color: Colors.black38,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Text(widget._name,
                              maxLines: 3,
                              textDirection: TextDirection.ltr,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15)),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                                width: 10,
                                child: Icon(
                                  Icons.location_history,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(widget._location,
                                  maxLines: 3,
                                  textDirection: TextDirection.ltr,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12)),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(widget._price,
                              maxLines: 3,
                              textDirection: TextDirection.ltr,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12)),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
