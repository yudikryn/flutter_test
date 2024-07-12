import 'package:flutter/material.dart';
import 'package:test_flutter/common/utils.dart';
import 'package:test_flutter/injection.dart' as di;
import 'package:provider/provider.dart';
import 'package:test_flutter/presentation/pages/add_page.dart';
import 'package:test_flutter/presentation/pages/main_page.dart';
import 'package:test_flutter/presentation/provider/my_notifier.dart';
import 'package:test_flutter/presentation/provider/user_notifier.dart';

void main() {
  di.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MyNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<UserNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Test',
        home: const MainPage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/main-page':
              return MaterialPageRoute(builder: (_) => const MainPage());
            case AddPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const AddPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
