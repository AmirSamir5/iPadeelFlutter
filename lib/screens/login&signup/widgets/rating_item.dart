import 'package:flutter/material.dart';
import 'package:i_padeel/constants/app_colors.dart';
import 'package:i_padeel/models/ratings.dart';

class RatingItemWidget extends StatefulWidget {
  final Ratings ratings;
  final Ratings? selectedRating;
  final int index;
  final Function(Ratings) selectedRatingFunction;
  const RatingItemWidget({
    Key? key,
    this.selectedRating,
    required this.ratings,
    required this.index,
    required this.selectedRatingFunction,
  }) : super(key: key);

  @override
  _RatingItemWidgetState createState() => _RatingItemWidgetState();
}

class _RatingItemWidgetState extends State<RatingItemWidget> {
  String checkDescription(int index) {
    switch (index) {
      case 11:
        return 'This player has no exp, and just start the game.';
      case 10:
        return 'This player is consistent at a low pace.';
      case 9:
        return 'This player is consistent at a medium pace, however shots lack direction';
      case 8:
        return 'This player is building confidence with shots and is consistent at a medium pace.';
      case 7:
        return 'This player has control and pace. Previous racquent skills generally fall into this category';
      case 6:
        return 'This player has experience constructing padel points and is generally a consistent player.';
      case 5:
        return 'This player is a resourcful - Executing winners, and the ability to force errors';
      case 4:
        return 'This player has experience competing at a tournament level.';
      case 3:
        return 'This is top nationality ranked player regularly competing at a high tournment level.';
      case 2:
        return "This is a semi-professional player with a Worls ranking outside the World's top-250";
      case 1:
        return "This is a professional player ranked inside the World's top-250";
      case 0:
        return "This is a professional player ranked inside the World's top-100";
      default:
        return "";
    }
  }

  bool markCheckedRating(Ratings rating) {
    if (widget.selectedRating == null) return false;
    if (widget.selectedRating!.id == rating.id) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    bool checked = markCheckedRating(widget.ratings);
    return InkWell(
      onTap: () {
        widget.selectedRatingFunction(widget.ratings);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        color: checked ? AppColors.secondaryColor : Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  widget.ratings.name!,
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: checked ? Colors.black : Colors.white,
                      ),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  widget.ratings.description ?? checkDescription(widget.index),
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: checked ? Colors.black : Colors.white,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  widget.ratings.division!.name!,
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: checked ? Colors.black : Colors.white,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
