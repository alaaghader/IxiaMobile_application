import 'package:ixiamobile_application/utils/settings.dart';
import 'package:ixiamobile_application/Api/Models/token_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common.dart';

extension SharedPreferencesExtensions on SharedPreferences {
  DateTime getDateTime(String key) {
    var str = this.getString(key);
    return str != null ? DateTime.parse(str) : null;
  }

  void setDateTime(String key, DateTime value) {
    this.setString(key, value.toString());
  }

  void setToken(TokenView token) {
    this.setString('accessToken', token.accessToken);
    this.setString('refreshToken', token.refreshToken);
    this.setDateTime('expiresOn', token.expiresOn);
    this.setString('email', token.email);
    this.setString('userId', token.userId);
  }

  TokenView getToken() {
    if (this.getString('accessToken') != null) {
      return TokenView(
        userId: this.getString('userId'),
        accessToken: this.getString('accessToken'),
        refreshToken: this.getString('refreshToken'),
        expiresOn: this.getDateTime('expiresOn'),
        email: this.getString('email'),
      );
    }
    return null;
  }

  void removeToken() {
    this.remove('accessToken');
    this.remove('refreshToken');
    this.remove('expiresOn');
    this.remove('email');
    this.remove('userId');
  }
}

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T f(E e, int i)) {
    var i = 0;
    return this.map((e) => f(e, i++));
  }
}

extension ImageExtensions on Image {
  static Image urlOrDefault(String path, {BoxFit fit}) {
    if (path == null) {
      return Image.asset(
        kDefaultImage,
        fit: fit,
      );
    } else {
      return Image.network(
        url(path),
        fit: fit,
      );
    }
  }
}

extension ImageProviderExtensions on ImageProvider<dynamic> {
  static ImageProvider<dynamic> urlOrDefault(String path) {
    if (path == null) {
      return AssetImage(kDefaultImage);
    } else {
      return NetworkImage(url(path));
    }
  }
}

extension StringExtensions on String {
  bool get isEmptySpace {
    for (var i = 0; i < length; i++) {
      if (this[i] != ' ') {
        return false;
      }
    }
    return true;
  }

  bool get isNotEmptySpace {
    return !isEmptySpace;
  }
}
