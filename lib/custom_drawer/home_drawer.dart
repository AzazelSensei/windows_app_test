import 'package:flutter/material.dart';

import '../app_theme.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({
    required this.screenIndex,
    required this.iconAnimationController,
    required this.callBackIndex,
    super.key,
  });

  final AnimationController iconAnimationController;
  final DrawerIndex screenIndex;
  final Function(DrawerIndex) callBackIndex;

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  late final List<DrawerList> drawerList;
  @override
  void initState() {
    super.initState();
    setDrawerListArray();
  }

  void setDrawerListArray() {
    drawerList = <DrawerList>[
      DrawerList(
          index: DrawerIndex.barcode,
          labelName: 'Barkod Tara',
          icon: const Icon(Icons.qr_code)),
      DrawerList(
          index: DrawerIndex.feedback,
          labelName: 'Geri Bildirim',
          icon: const Icon(Icons.help)),
      DrawerList(
          index: DrawerIndex.invite,
          labelName: 'Davet Et',
          icon: const Icon(Icons.group)),
      DrawerList(
          index: DrawerIndex.about,
          labelName: 'Hakkımızda',
          icon: const Icon(Icons.info)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.notWhite.withOpacity(0.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AnimatedBuilder(
                  animation: widget.iconAnimationController,
                  builder: (BuildContext context, _) {
                    return ScaleTransition(
                      scale: AlwaysStoppedAnimation<double>(
                          1.0 - (widget.iconAnimationController.value) * 0.2),
                      child: RotationTransition(
                        turns: AlwaysStoppedAnimation<double>(
                            Tween<double>(begin: 0.0, end: 24.0)
                                    .animate(CurvedAnimation(
                                        parent: widget.iconAnimationController,
                                        curve: Curves.fastOutSlowIn))
                                    .value /
                                360),
                        child: Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: AppTheme.white.withOpacity(0.6),
                                offset: const Offset(2.0, 4.0),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: const ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(60.0)),
                            // child:
                            //     Image.asset('assets/images/unnamed_nobg.png'),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 8, left: 4),
                  child: Text(
                    'Hoşgeldiniz!',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.grey,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Divider(
            height: 1,
            color: AppTheme.grey.withOpacity(0.6),
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: drawerList.length,
              itemBuilder: (BuildContext context, int index) {
                return inkwell(drawerList[index]);
              },
            ),
          ),
          Divider(
            height: 1,
            color: AppTheme.grey.withOpacity(0.6),
          ),
          // Column(
          //   children: <Widget>[
          //     Material(
          //       color: Colors.transparent,
          //       child: InkWell(
          //         child: ListTile(
          //           title: const Text(
          //             'Sign Out',
          //             style: TextStyle(
          //               fontFamily: AppTheme.fontName,
          //               fontWeight: FontWeight.w600,
          //               fontSize: 16,
          //               color: AppTheme.darkText,
          //             ),
          //             textAlign: TextAlign.left,
          //           ),
          //           trailing: const Icon(
          //             Icons.power_settings_new,
          //             color: Colors.red,
          //           ),
          //           onTap: () {},
          //         ),
          //       ),
          //     ),
          //     SizedBox(
          //       height: MediaQuery.of(context).padding.bottom,
          //     )
          //   ],
          // ),
        ],
      ),
    );
  }

  Widget inkwell(DrawerList listData) {
    final isSelected = widget.screenIndex == listData.index;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => navigationtoScreen(listData.index),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  const SizedBox(
                    width: 6.0,
                    height: 46.0,
                  ),
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: buildIconWidget(listData, isSelected),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  buildLabelWidget(listData, isSelected),
                ],
              ),
            ),
            if (isSelected)
              AnimatedBuilder(
                animation: widget.iconAnimationController,
                builder: (BuildContext context, _) {
                  final value = widget.iconAnimationController.value;
                  return Transform.translate(
                    offset: Offset(
                      (MediaQuery.of(context).size.width * 0.75 - 64) *
                          (1.0 - value - 1.0),
                      0.0,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.75 - 64,
                        height: 46,
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.2),
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(28),
                            bottomRight: Radius.circular(28),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget buildIconWidget(DrawerList listData, bool isSelected) {
    return listData.isAssetsImage
        ? Image.asset(
            listData.imageName,
            color: isSelected ? Colors.blue : AppTheme.nearlyBlack,
          )
        : Icon(
            listData.icon?.icon,
            color: isSelected ? Colors.blue : AppTheme.nearlyBlack,
          );
  }

  Widget buildLabelWidget(DrawerList listData, bool isSelected) {
    return Expanded(
      child: Text(
        listData.labelName,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: isSelected ? Colors.blue : AppTheme.nearlyBlack,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }

  Future<void> navigationtoScreen(DrawerIndex indexScreen) async {
    widget.callBackIndex(indexScreen);
  }
}

enum DrawerIndex { barcode, home, feedback, invite, about }

class DrawerList {
  DrawerList({
    required this.index,
    this.icon,
    this.isAssetsImage = false,
    this.labelName = '',
    this.imageName = '',
  });

  String labelName;
  Icon? icon;
  bool isAssetsImage;
  String imageName;
  DrawerIndex index;
}
