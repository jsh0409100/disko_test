import 'package:disko_001/common/enums/notification_enum.dart';
import 'package:disko_001/common/widgets/loading_screen.dart';
import 'package:disko_001/features/notification/widgets/custom_comment_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/utils/utils.dart';
import '../../../models/notification_model.dart';
import '../controller/notification_controller.dart';
import '../widgets/custom_liked_notification.dart';

class NotificationTap extends ConsumerStatefulWidget {
  const NotificationTap({Key? key}) : super(key: key);

  @override
  _NotificationTapState createState() => _NotificationTapState();
}

class _NotificationTapState extends ConsumerState<NotificationTap> {
  var notificationList;

  Future<void> refreshList(BuildContext context) async {
    var tempList = await ref.read(notificationControllerProvider).notifications();
    setState(() {
      notificationList = tempList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 1,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "알림",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            centerTitle: true,
            // bottom: const TabBar(
            //   labelColor: Colors.black,
            //   indicatorColor: Color(0xFF5E38EB),
            //   tabs: <Widget>[
            //     Tab(
            //       icon: Text(
            //         "활동 알림",
            //         style: TextStyle(fontWeight: FontWeight.bold),
            //       ),
            //     ),
            // Tab(
            //   icon: Text(
            //     "방명록 알림",
            //     style: TextStyle(fontWeight: FontWeight.bold),
            //   ),
            // ),
            //   ],
            // ),
          ),
          // body: TabBarView(
          //   children: <Widget>[
          body: RefreshIndicator(
            onRefresh: () => refreshList(context),
            child: FutureBuilder<List<NotificationModel>>(
                future: ref.read(notificationControllerProvider).notifications(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const LoadingScreen();
                  }
                  notificationList = snapshot.data!;
                  return ListView.builder(
                      itemCount: notificationList.length,
                      itemBuilder: (context, index) {
                        return FutureBuilder(
                            future: getPostByPostId(snapshot.data![index].postId),
                            builder: (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData == false) {
                                //TODO 더이상 존재하지 않는 포스트일때 표시 생각하기
                                return Card(
                                  color: Colors.grey.shade300,
                                  child: Column(children: [
                                    SizedBox(
                                      height: 70,
                                      width: MediaQuery.of(context).size.width * 0.9,
                                    ),
                                    const SizedBox(
                                      height: 11,
                                    )
                                  ]),
                                );
                              }
                              return Container(
                                  color: notificationList[index].seen
                                      ? Colors.white
                                      : const Color(0x0fff4eff),
                                  child: notificationList[index].notificationType ==
                                          NotificationEnum.comment
                                      ? CustomCommentNotification(
                                          notification: notificationList[index],
                                          post: snapshot.data,
                                        )
                                      : CustomLikedNotification(
                                          notification: notificationList[index],
                                          post: snapshot.data,
                                        ));
                            });
                      });
                }),
          ),
          //   ],
          // ),
        ),
      ),
    );
  }
}
