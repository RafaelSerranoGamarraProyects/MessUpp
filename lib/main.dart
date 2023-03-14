import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfg_app/providers/providers.dart';
import 'package:tfg_app/router/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


Future<void> main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options:  DefaultFirebaseOptions.currentPlatform);
  PushNotifications.initialize();
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
  
    return FutureBuilder(
      future: userProvider.readToken().then((value) => userProvider.user = value),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(!snapshot.hasData) return const CircularProgressIndicator.adaptive();

        if(snapshot.data ==""){
          return const Providers(initialRoute: "login");
        }

        else{ return const Providers(initialRoute: "home"); }
      },
    );      
  }
}

class Providers extends StatelessWidget {
  const Providers({
    super.key,
    required this.initialRoute,
  });

  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UsersProvider>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ObjetivesProvider(userProvider.user)),
				ChangeNotifierProvider(create: (_) => ExpensesProvider(userProvider.user)),
				ChangeNotifierProvider(create: (_) => GroupsProvider(userProvider.user)),
        ChangeNotifierProvider(create: (_) => DebtsProvider(userProvider.user)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: initialRoute,
        routes: AppRoutes.getAppRoutes(),
        theme: ThemeData.light().copyWith(appBarTheme: const AppBarTheme(color: Colors.deepPurple)),
    
      ),
    );
  }
}