import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:i_padeel/utils/urls.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';

class LocationsListItem extends StatefulWidget {
  final String name;
  final String card;
  final String location;
  final String price;

  const LocationsListItem({
    Key? key,
    required this.name,
    required this.card,
    required this.location,
    required this.price,
  }) : super(key: key);

  @override
  _LocationsListItemState createState() => _LocationsListItemState();
}

class _LocationsListItemState extends State<LocationsListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width / 2,
      decoration: BoxDecoration(
          /*borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              topLeft: Radius.circular(25),
              topRight: Radius.circular(5),
              bottomLeft: Radius.circular(5)),*/
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              offset: const Offset(0, 3),
              spreadRadius: 5,
              blurRadius: 7,
            )
          ]),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: Stack(fit: StackFit.expand, children: <Widget>[
          OptimizedCacheImage(
            fit: BoxFit.cover,
            imageUrl: Urls.domain + (widget.card),
            placeholder: (context, url) => LinearProgressIndicator(
              backgroundColor: Colors.transparent,
              valueColor:
                  AlwaysStoppedAnimation<Color>(Colors.black.withOpacity(0.2)),
            ),
            errorWidget: (context, url, error) => Image.asset(
              "assets/images/tennisCourt.jpeg",
              fit: BoxFit.fill,
            ),
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
                    margin: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: Text(
                            widget.name,
                            maxLines: 3,
                            textDirection: TextDirection.ltr,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_pin,
                                color: Colors.white,
                                size: 24,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Expanded(
                                child: Text(
                                  widget.location,
                                  maxLines: 3,
                                  textDirection: TextDirection.ltr,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Text(
                            widget.price,
                            maxLines: 3,
                            textDirection: TextDirection.ltr,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                            ),
                          ),
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
