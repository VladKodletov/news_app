import 'package:equatable/equatable.dart';

/// Base class for news-related failures
abstract class NewsFailure extends Equatable {
  final String message;

  const NewsFailure(this.message);

  @override
  List<Object> get props => [message];
}

/// Failure for network-related errors
class NetworkFailure extends NewsFailure {
  const NetworkFailure(super.message);
}

/// Failure for server API errors
class ServerFailure extends NewsFailure {
  const ServerFailure(super.message);
}

/// Failure for cache/local storage errors
class CacheFailure extends NewsFailure {
  const CacheFailure(super.message);
}

/// Failure for invalid input/data
class InvalidInputFailure extends NewsFailure {
  const InvalidInputFailure(super.message);
}