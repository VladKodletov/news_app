import 'package:flutter/material.dart';

/// App constants
class AppConstants {
  // API Constants
  static const String newsApiBaseUrl = 'newsapi.org';
  static const String newsApiPath = '/v2/top-headlines';

  // Local Storage Keys
  static const String favoritesKey = 'favorite_articles';

  // Default values
  static const String defaultCountry = 'us';
  static const int defaultPageSize = 20;

  static final BoxDecoration boxDecorationElements = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: const [
      BoxShadow(
        color: Color(0x26000000),
        offset: Offset(0, 3),
        blurRadius: 6.1,
      ),
    ],
  );

  // Error Messages
  static const String networkErrorMessage =
      'Please check your internet connection';
  static const String serverErrorMessage =
      'Server error, please try again later';
  static const String unexpectedErrorMessage = 'An unexpected error occurred';
}

/// News categories
class NewsCategories {
  static const List<String> all = [
    'business',
    'general',
    'entertainment',
    'health',
    'science',
    'sports',
    'technology',
  ];
}
