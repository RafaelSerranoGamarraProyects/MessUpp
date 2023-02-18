import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfg_app/providers/providers.dart';
import 'package:tfg_app/router/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options:  DefaultFirebaseOptions.currentPlatform);
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UsersProvider(), lazy: false),
        ChangeNotifierProvider(create: (_) => AddExpenditureFormProvider(), lazy: false),
        ChangeNotifierProvider(create: (_) => ModifyExpenditureFormProvider(), lazy: false),

      ],
      child: const MyApp(),
    );
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UsersProvider>(context);
    return   MultiProvider(
      providers: [
        		ChangeNotifierProvider(create: (_) => ObjetivesProvider(userProvider.user)),
						ChangeNotifierProvider(create: (_) => ExpensesProvider(userProvider.user))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.initialRoute,
        routes: AppRoutes.getAppRoutes(),
        theme: ThemeData.light().copyWith(appBarTheme: const AppBarTheme(color: Colors.deepPurple)),
    
      ),
    );
  }
}