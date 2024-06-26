import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:messup/router/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'providers/providers.dart';
import 'theme/custom_styles.dart';


Future<void> main() async {
  
  WidgetsBinding widgetsBinding =  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options:  DefaultFirebaseOptions.currentPlatform);
  PushNotifications.initialize();
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider(create: (_) => UsersProvider(), lazy: false, child: const MyApp(),);
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
        if(snapshot.data == ""){
          return const Providers(initialRoute: "login");
        }
        else{
          userProvider.getLoggedUser();
          return const Providers(initialRoute: "home");
        }
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
    FlutterNativeSplash.remove();
    final userProvider = Provider.of<UsersProvider>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ObjetivesProvider(userProvider.user)),
				ChangeNotifierProvider(create: (_) => ExpensesProvider(userProvider.user)),
				ChangeNotifierProvider(create: (_) => GroupsProvider(userProvider.userLogged!)),
        ChangeNotifierProvider(create: (_) => DebtsProvider(userProvider.user)),
        ChangeNotifierProvider(create: (_) => AddExpenditureFormProvider(), lazy: false),
        ChangeNotifierProvider(create: (_) => AddPendingPaymentProvider(), lazy: false),
        ChangeNotifierProvider(create: (_) => AddObjetiveFormProvider(), lazy: false),
        ChangeNotifierProvider(create: (_) => AddGroupPaymentProvider(), lazy: false),
        ChangeNotifierProvider(create: (_) => ModifyExpenditureFormProvider(), lazy: false),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: initialRoute,
        routes: AppRoutes.getAppRoutes(),
        theme: ThemeData.light().copyWith(appBarTheme: const AppBarTheme(color: AppTheme.primaryColor,)),
    
      ),
    );
  }
}