import 'package:falletter_mobile_v2/core/components/header/main_header.dart';
import 'package:falletter_mobile_v2/presentation/main/view/announcement_view.dart';
import 'package:falletter_mobile_v2/presentation/main/view/notification_tab_view.dart';
import 'package:falletter_mobile_v2/presentation/main/components/custom_tab_bar.dart';
import 'package:flutter/material.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MainHeader(leadingIcon: true),
          CustomTabBar(
            tabs: [
              Tab(text: '알림'),
              Tab(text: '안내'),
            ],
            controller: _tabController,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
                children: [
                  NotificationTabView(),
                  AnnouncementView()
                ]
            ),
          )
        ],
      ),
    );
  }
}
