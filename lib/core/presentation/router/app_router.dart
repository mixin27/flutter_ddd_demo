import 'package:auto_route/annotations.dart';
import 'package:demo/post/presentation/post_listing_page.dart';
import 'package:demo/splash/presentation/splash_page.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: SplashPage, initial: true),
    AutoRoute(page: PostListingPage, path: '/posts'),
  ],
  replaceInRouteName: 'Page,Route',
)
class $AppRouter {}
