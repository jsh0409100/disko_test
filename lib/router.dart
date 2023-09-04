import 'package:disko_001/app_layout_screen.dart';
import 'package:disko_001/features/home/screens/detail_page.dart';
import 'package:disko_001/features/profile/screens/other_user_profile_page.dart';
import 'package:disko_001/features/profile/screens/profile_edit_page.dart';
import 'package:disko_001/features/profile/screens/setting_page.dart';
import 'package:disko_001/features/starting/landing_pages/landing_page.dart';
import 'package:disko_001/features/write_post/screens/edit_post_page.dart';
import 'package:disko_001/test.dart';
import 'package:flutter/material.dart';

import 'common/widgets/error_screen.dart';
import 'features/auth/screens/login_page.dart';
import 'features/auth/screens/signup_page.dart';
import 'features/chat/screens/chat_screen.dart';
import 'features/report/report_screen.dart';
import 'features/search/screens/search.dart';
import 'features/write_post/screens/write_post_page.dart';
import 'models/post_card_model.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LandingPage.routeName:
      return MaterialPageRoute(
        builder: (context) => LandingPage(),
      );
    case SignUpScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const SignUpScreen(
          itisSignUp: true,
        ),
      );
    case LoginScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(itisSignUp: true),
      );
    case AppLayoutScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const AppLayoutScreen(),
      );
    case DetailPage.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final PostCardModel post = arguments['post'];
      return MaterialPageRoute(
        builder: (context) => DetailPage(post: post),
      );
    case TestScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final payload = arguments['postId'];
      return MaterialPageRoute(
        builder: (context) => TestScreen(payload: payload),
      );
    case ChatScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final peerUid = arguments['peerUid'];
      final peerName = arguments['peerName'];
      final isUploading = arguments['isUploading'] ?? false;
      return MaterialPageRoute(
        builder: (context) => ChatScreen(
          peerUid: peerUid,
          isUploading: isUploading,
        ),
      );
    case EditPostScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final post = arguments['post'];
      return MaterialPageRoute(
        builder: (context) => EditPostScreen(
          post: post,
        ),
      );
    case ReportScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final reportedUid = arguments['reportedUid'];
      final reportedDisplayName = arguments['reportedDisplayName'];
      return MaterialPageRoute(
        builder: (context) => ReportScreen(
          reportedUid: reportedUid,
          reportedDisplayName: reportedDisplayName,
        ),
      );
    case WritePostPage.routeName:
      return MaterialPageRoute(
        builder: (context) => const WritePostPage(),
      );
    case SearchScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const SearchScreen(),
      );
    case SettingScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const SettingScreen(),
      );
    case OtherUserProfilePage.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final uid = arguments['uid'];
      return MaterialPageRoute(
        builder: (context) => OtherUserProfilePage(
          uid: uid,
        ),
      );
    case ProfileEditPage.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final user = arguments['user'];
      return MaterialPageRoute(
        builder: (context) => ProfileEditPage(
          user: user,
        ),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: ErrorScreen(error: 'This page doesn\'t exist'),
        ),
      );
  }
}
