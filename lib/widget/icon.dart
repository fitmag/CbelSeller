import 'package:cbel/constant/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconWithBadge extends StatefulWidget {
  const IconWithBadge({
    Key? key,
    required this.stream,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final dynamic stream;
  final String icon;
  final Function press;

  @override
  _IconWithBadgeState createState() => _IconWithBadgeState();
}

class _IconWithBadgeState extends State<IconWithBadge> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(
        child: GestureDetector(
            onTap: () => widget.press, child: SvgPicture.asset(widget.icon)),
      ),
      StreamBuilder(
          stream: widget.stream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Error");
            }
    
            if (snapshot.hasData && snapshot.data!.docs.length != 0) {
              print("no read");
              return Positioned(
                  right: 0,
                  top: 16,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.red, shape: BoxShape.circle),
                    width: 8,
                    height: 8,
                  ));
            }
            return Container();
          })
    ]);
  }
}


class CircleIcon extends StatelessWidget {
  const CircleIcon({Key? key, required this.icon, required this.onTap})
      : super(key: key);

  final IconData icon;
  final dynamic onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 32,
        width: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            /// boxShadow: [
            ///   BoxShadow(blurRadius: 4, color: Colors.grey, offset: Offset.zero)
            /// ]
            ),
        child: Icon(
          icon,
          color: CustomColor.primary,
        ),
      ),
    );
  }
}


