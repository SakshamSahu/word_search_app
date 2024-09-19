import 'package:word_search_app/presentation/views/home_screen.dart';
import 'package:word_search_app/presentation/views/splash_screen.dart';

class AppRoutes {
  static final appRoutes = {
    "/": (context) => const SplashScreenPage(),
    HomeScreen.routeName: (context) => const HomeScreen(),
  };
}
