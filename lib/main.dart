import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// 🔥 CORE
import 'core/theme/theme_provider.dart';

// 🔥 FEATURES
import 'features/cart/models/cart_model.dart';
import 'features/catalog/providers/favorite_model.dart';
import 'features/catalog/pages/home_page.dart';
import 'features/cart/pages/cart_page.dart';
import 'features/auth/pages/login_page.dart';

// 🔥 FIREBASE
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

// 🔥 DEEPLINK & HTTP
import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:dio/dio.dart';
import 'features/cart/pages/success_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyAppWrapper());
}

class MyAppWrapper extends StatelessWidget {
  const MyAppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartModel()),
        ChangeNotifierProvider(create: (_) => FavoriteModel()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  @override
  void initState() {
    super.initState();
    _initDeepLinks();
  }

  Future<void> _initDeepLinks() async {
    _appLinks = AppLinks();

    _linkSubscription = _appLinks.uriLinkStream.listen((uri) async {
      debugPrint('Menerima deeplink: $uri');
      if (uri.scheme == 'topizak' && uri.host == 'callback') {
        final status = uri.queryParameters['status'];
        
        if (status == 'success') {
          // TODO: Call be-topi_store API via Dio to confirm order here if needed.
          // For now, we clear the cart and navigate to success page.
          final cart = Provider.of<CartModel>(context, listen: false);
          cart.clearCart();
          
          _navigatorKey.currentState?.pushReplacement(
            MaterialPageRoute(builder: (_) => const SuccessPage()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Pembayaran gagal atau dibatalkan')),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          navigatorKey: _navigatorKey,
          debugShowCheckedModeBanner: false,

          themeMode: themeProvider.themeMode,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),

          home: const AuthWrapper(),

          routes: {
            '/home': (context) => HomePage(),
            '/cart': (context) => CartPage(),
          },
        );
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData) {
          return HomePage();
        }

        return LoginPage();
      },
    );
  }
}