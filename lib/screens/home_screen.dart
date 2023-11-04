import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'components/calendar_parts.dart';

// ignore: must_be_immutable
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with SingleTickerProviderStateMixin {
  var _currentIndex = 0;

  int tabsNum = 7;

  late final TabController tabController = TabController(length: tabsNum, vsync: this);

  ///
  @override
  void initState() {
    super.initState();

    tabController
      ..addListener(() => setState(() => _currentIndex = tabController.index))
      ..index = (tabsNum / 2).floor();
  }

  ///
  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 350,
                  child: TabBarView(
                    controller: tabController,
                    children: List.generate(
                      tabsNum,
                      (index) => CalendarParts(index: _currentIndex - ((tabsNum / 2).floor())),
                    ),
                  ),
                ),
                Divider(color: Colors.white.withOpacity(0.4), thickness: 5),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
