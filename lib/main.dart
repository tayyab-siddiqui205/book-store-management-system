import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'screens/splash/splash_screen.dart';
import 'providers/auth_provider.dart';
import 'providers/book_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/order_provider.dart';
import 'providers/review_provider.dart';
import 'providers/user_provider.dart';
import 'providers/wishlist_provider.dart';
import 'providers/category_provider.dart';
import 'screens/auth/login_email_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyA8fc4u8udWrWtYJekQckaZ-InBtdJchnI",
        authDomain: "book-store-app-6b56c.firebaseapp.com",
        projectId: "book-store-app-6b56c",
        storageBucket: "book-store-app-6b56c.firebasestorage.app",
        messagingSenderId: "902749055630",
        appId: "1:902749055630:web:7c29f3f38a84e6282c37df",
      ),
    );
  } else {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAjjnGy9Z2LbEpRT86Tudk0f75TtoVtiZc",
        appId: "1:902749055630:android:d8d6777f5596ce1f2c37df",
        messagingSenderId: "902749055630",
        projectId: "book-store-app-6b56c",
        storageBucket: "book-store-app-6b56c.firebasestorage.app",
      ),
    );
  }

  runApp(
    MultiProvider(
     providers: [
  ChangeNotifierProvider(create: (_) => AuthProvider()),
  ChangeNotifierProvider(create: (_) => UserProvider()),
  ChangeNotifierProvider(create: (_) => BookProvider()),
  ChangeNotifierProvider(create: (_) => CategoryProvider()), // 👈 ADD THIS
  ChangeNotifierProvider(create: (_) => CartProvider()),
  ChangeNotifierProvider(create: (_) => WishlistProvider()),
  ChangeNotifierProvider(create: (_) => OrderProvider()),
  ChangeNotifierProvider(create: (_) => ReviewProvider()),
],
      child: const BookStoreApp(),
    ),
  );
}

class BookStoreApp extends StatelessWidget {
  const BookStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Book Store',
      theme: AppTheme.lightTheme,
      // home: const LoginEmailScreen(),
      home: const SplashScreen(),
    );
  }
}