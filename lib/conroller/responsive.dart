import 'package:flutter/cupertino.dart';
import 'package:insta_clone/constants/global.dart';
import 'package:insta_clone/provider/user_provider.dart';
import 'package:provider/provider.dart';

class Responsive extends StatefulWidget {
  final Widget mobilescreen;
  final Widget webscreen;
  const Responsive(
      {Key? key, required this.mobilescreen, required this.webscreen})
      : super(key: key);

  @override
  State<Responsive> createState() => _ResponsiveState();
}

class _ResponsiveState extends State<Responsive> {
  @override
  void initState() {
    super.initState();
    adddata();
  }

  void adddata() async {
    Userprovider _userprovider = Provider.of(context, listen: false);
    await _userprovider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > webScreenSize) {
        return widget.webscreen;
      } else {
        return widget.mobilescreen;
      }
    });
  }
}
