import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../custom_drawer/home_drawer.dart';

class DrawerUserController extends StatefulWidget {
  const DrawerUserController({
    required this.onDrawerCall,
    required this.screenView,
    this.menuView,
    this.drawerIsOpen,
    this.animatedIconData = AnimatedIcons.arrow_menu,
    this.drawerWidth = 250,
    this.screenIndex = DrawerIndex.home,
    Key? key,
  }) : super(key: key);

  final double drawerWidth;
  final Function(DrawerIndex) onDrawerCall;
  final Widget screenView;
  final Function(bool)? drawerIsOpen;
  final AnimatedIconData animatedIconData;
  final Widget? menuView;
  final DrawerIndex screenIndex;

  @override
  State<DrawerUserController> createState() => _DrawerUserControllerState();
}

class _DrawerUserControllerState extends State<DrawerUserController>
    with TickerProviderStateMixin {
  double _scrollOffset = 0.0;

  late final ScrollController _scrollController;
  late final AnimationController _animationController;
  late final AnimationController _iconAnimationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    _iconAnimationController =
        AnimationController(vsync: this, duration: const Duration());
    _iconAnimationController.animateTo(1.0,
        duration: const Duration(), curve: Curves.fastOutSlowIn);
    _scrollController =
        ScrollController(initialScrollOffset: widget.drawerWidth);
    _scrollController.addListener(() {
      if (_scrollController.offset <= 0) {
        if (_scrollOffset != 1.0) {
          if (mounted) {
            setState(() {
              _scrollOffset = 1.0;
              final Function(bool)? function = widget.drawerIsOpen;
              if (function != null) function(true);
            });
          }
        }
        _iconAnimationController.animateTo(0.0,
            duration: const Duration(), curve: Curves.fastOutSlowIn);
      } else if (_scrollController.offset < widget.drawerWidth.floor()) {
        _iconAnimationController.animateTo(
            (_scrollController.offset * 100 / (widget.drawerWidth)) / 100,
            duration: const Duration(),
            curve: Curves.fastOutSlowIn);
      } else {
        if (_scrollOffset != 0.0) {
          if (mounted) {
            setState(() {
              _scrollOffset = 0.0;
              final Function(bool)? function = widget.drawerIsOpen;
              if (function != null) function(false);
            });
          }
        }
        _iconAnimationController.animateTo(1.0,
            duration: const Duration(), curve: Curves.fastOutSlowIn);
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((Duration duration) {
      getInitState();
    });
  }

  Future<bool> getInitState() async {
    await Future.delayed(Duration.zero);
    _scrollController.animateTo(
      widget.drawerWidth,
      duration: const Duration(milliseconds: 400),
      curve: Curves.fastOutSlowIn,
    );
    return true;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    _iconAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.white,
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: const PageScrollPhysics(parent: ClampingScrollPhysics()),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width + widget.drawerWidth,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: widget.drawerWidth,
                height: MediaQuery.of(context).size.height,
                child: AnimatedBuilder(
                  animation: _iconAnimationController,
                  builder: (BuildContext context, _) {
                    return Transform(
                      transform: Matrix4.translationValues(
                          _scrollController.offset, 0.0, 0.0),
                      child: HomeDrawer(
                        screenIndex: widget.screenIndex,
                        iconAnimationController: _iconAnimationController,
                        callBackIndex: (DrawerIndex indexType) {
                          onDrawerClick();
                          widget.onDrawerCall(indexType);
                        },
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: AppTheme.grey.withOpacity(0.6),
                          blurRadius: 24),
                    ],
                  ),
                  child: Stack(
                    children: <Widget>[
                      IgnorePointer(
                        ignoring: _scrollOffset == 1 || false,
                        child: widget.screenView,
                      ),
                      if (_scrollOffset == 1.0)
                        GestureDetector(
                          onTap: () => onDrawerClick(),
                        ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).padding.top + 8,
                            left: 8),
                        child: SizedBox(
                          width: AppBar().preferredSize.height - 8,
                          height: AppBar().preferredSize.height - 8,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(
                                  AppBar().preferredSize.height),
                              onTap: () {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                onDrawerClick();
                              },
                              child: Center(
                                child: widget.menuView ??
                                    AnimatedIcon(
                                        icon: widget.animatedIconData,
                                        progress: _iconAnimationController),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onDrawerClick() {
    if (_scrollController.offset != 0.0) {
      _scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn,
      );
    } else {
      _scrollController.animateTo(
        widget.drawerWidth,
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn,
      );
    }
  }
}
