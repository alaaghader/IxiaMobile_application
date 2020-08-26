import 'package:dio/dio.dart';
import 'package:ixiamobile_application/Api/Models/result.dart';
import 'package:ixiamobile_application/Api/Models/error.dart';
import 'package:ixiamobile_application/Failures/failure.dart';

abstract class StatusFailure extends Failure {
  int status;
  List<Error> errors;

  StatusFailure({
    this.status,
    this.errors,
    String message,
  }) : super(message: message);

  factory StatusFailure.fromResponse(Response response) {
    Result<dynamic> result;

    if (response.data != null && response.data is Map<String, dynamic>) {
      result = Result.fromJson(response.data);
    } else {
      result = Result(status: response.statusCode, errors: []);
    }

    switch (result.status) {
      case 400:
        return ValidationFailure(errors: result.errors);
      case 401:
        return UnauthorizedFailure(errors: result.errors);
      case 403:
        return ForbiddenFailure(errors: result.errors);
      case 404:
        return NotFoundFailure(errors: result.errors);
      case 409:
        return ConflictFailure(errors: result.errors);
      case 500:
        return ServerFailure();
      default:
        throw new Exception("Not supported status code");
    }
  }
}

class ValidationFailure extends StatusFailure {
  ValidationFailure({List<Error> errors})
      : super(
    status: 400,
    errors: errors,
    message: "One or more validation errors occured",
  );
}

class UnauthorizedFailure extends StatusFailure {
  UnauthorizedFailure({List<Error> errors})
      : super(
    status: 401,
    errors: errors,
    message: "Unauthorized",
  );
}

class ForbiddenFailure extends StatusFailure {
  ForbiddenFailure({List<Error> errors})
      : super(
    status: 403,
    errors: errors,
    message: "Forbidden",
  );
}

class NotFoundFailure extends StatusFailure {
  NotFoundFailure({List<Error> errors})
      : super(
    status: 404,
    errors: errors,
    message: "A requested resource was not found",
  );
}

class ConflictFailure extends StatusFailure {
  ConflictFailure({List<Error> errors})
      : super(
    status: 409,
    errors: errors,
    message: "Conflicts detected",
  );
}

class ServerFailure extends StatusFailure {
  ServerFailure()
      : super(
    status: 500,
    message: "Oops, looks like we encoutered a server error",
  );
}
