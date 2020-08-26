import 'failure.dart';

class InternetFailure extends Failure {
  InternetFailure({String message = "Failed to load data"})
      : super(message: message);
}
