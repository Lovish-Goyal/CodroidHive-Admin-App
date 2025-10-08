import 'package:community_app_admin/features/news/news_screen.dart';
import 'package:go_router/go_router.dart';
import '../auth/login_screen.dart';
import '../features/bottombar.dart';
import '../features/notifications/notifications_screen.dart';
import '../features/settings/setting_screen.dart';
import '../features/users/users_screen.dart';

final GoRouter _router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const BottomBar(),
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/users',
      name: 'user',
      builder: (context, state) => const UsersScreen(),
    ),
    GoRoute(
      path: '/notifications',
      name: 'notifications',
      builder: (context, state) => const NotificationScreen(),
    ),
    GoRoute(
      path: '/news',
      name: 'news',
      builder: (context, state) => const NewsScreen(),
    ),

    // Add more routes like this as needed:
    // GoRoute(
    //   path: '/user-approval',
    //   name: 'user-approval',
    //   builder: (context, state) => const UserApprovalScreen(),
    // ),
    // GoRoute(
    //   path: '/post-management',
    //   name: 'post-management',
    //   builder: (context, state) => const PostManagementScreen(),
    // ),
  ],
);

GoRouter get router => _router;
