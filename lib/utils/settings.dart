import 'dart:io';

import 'package:flutter/foundation.dart';

final kAppReleaseUrl = '';
final kAppLocalUrl = 'http://10.0.2.2:5000'; 

final kAppUrl =  kAppLocalUrl;
final kDefaultImage = '';

final kIsMobile = !kIsWeb && (Platform.isAndroid || Platform.isIOS);