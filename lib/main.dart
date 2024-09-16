import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movies/app_layout.dart';
import 'package:movies/view_model/DetailPageViewModel.dart';
import 'package:movies/view_model/movieCastViewModel.dart';
import 'package:movies/view_model/searchViewModel.dart';
import 'package:movies/view_model/watchListViewModel.dart';
import 'package:provider/provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  try {
    await dotenv.load(fileName: ".env"); // Load environment variables
  } catch (e) {
    throw Exception('Error loading .env file: $e'); // Print error if any
  }
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => SearchViewModel()),
            ChangeNotifierProvider(create: (_) => WatchlistViewModel()),
            ChangeNotifierProvider(create: (_) => DetailPageViewModel()),
            ChangeNotifierProvider(create: (_) => MovieCastViewModel()),

          ],
     child: const MyApp()
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AppLayout(),
    );
  }
}


