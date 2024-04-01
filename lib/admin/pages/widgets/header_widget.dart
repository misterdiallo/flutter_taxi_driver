import 'package:flutter/material.dart';

import '../../constant.dart';
import '../../responsive.dart';

class Header extends StatelessWidget {
  const Header(
      {super.key, required this.scaffoldKey, this.title = "", this.button});

  final GlobalKey<ScaffoldState> scaffoldKey;
  final String title;
  final Widget? button;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (!Responsive.isDesktop(context))
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: InkWell(
                onTap: () => scaffoldKey.currentState!.openDrawer(),
                child: const Padding(
                  padding: EdgeInsets.all(3.0),
                  child: Icon(
                    Icons.menu,
                    color: Colors.grey,
                    size: 25,
                  ),
                ),
              ),
            ),
          // if (!Responsive.isMobile(context))
          Expanded(
            flex: 4,
            child: button != null
                ? Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          title.toString(),
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontSize: 20,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      button!,
                    ],
                  )
                : Text(
                    title.toString(),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 20,
                        ),
                    textAlign: TextAlign.center,
                  ),
          ),
          if (Responsive.isMobile(context))
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => scaffoldKey.currentState!.openEndDrawer(),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Icon(
                      Icons.info,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                )
              ],
            ),
        ],
      ),
    );
  }
}
