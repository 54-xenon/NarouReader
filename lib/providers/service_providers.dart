import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/api_survice.dart';
import '../services/database_helper.dart';

// webAPI(なろう小説の公式API)の処理
final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

// sqfliteの処理
final databaseHelperProvider = Provider<DatabaseHelper>((ref) => DatabaseHelper());
