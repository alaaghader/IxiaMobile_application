import 'package:ixiamobile_application/utils/settings.dart';

String enumToString(Object enumValue) {
  if (enumValue == null) {
    return null;
  }
  return enumValue.toString().split('.').last;
}

bool isExternal(String path) {
  return RegExp("^https?://").hasMatch(path);
}

String url(String path) {
  if (path == null) {
    return null;
  } else if (isExternal(path)) {
    return path;
  } else {
    return kAppUrl + (path.startsWith('/') ? path : '/$path');
  }
}
