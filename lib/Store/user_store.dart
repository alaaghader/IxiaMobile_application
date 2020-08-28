import 'package:ixiamobile_application/Api/Models/token_view.dart';
import 'package:ixiamobile_application/Api/Models/user.dart';
import 'package:ixiamobile_application/Api/Requests/account.dart';
import 'package:ixiamobile_application/Api/Requests/profile.dart';
import 'package:ixiamobile_application/Failures/status_failure.dart';
import 'package:ixiamobile_application/utils/extensions.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_store.g.dart';

class UserStore extends _UserStore with _$UserStore {
}

abstract class _UserStore with Store {

  @observable
  TokenView tokenView;

  @observable
  bool hasLoadedToken = false;

  @observable
  bool loading = false;

  @observable
  User profile;

  @computed
  bool get isLoggedIn => tokenView != null;

  @action
  Future<TokenView> login(String email, String password) async {
    loading = true;
    try {
      tokenView = await AccountApi.login(email, password);
      var sharedPrefs = await SharedPreferences.getInstance();
      sharedPrefs.setToken(tokenView);
    } finally {
      loading = false;
    }
    return tokenView;
  }

  @action
  Future<TokenView> signUp(
      String firstName,
      String lastName,
      String userName,
      String email,
      String password
      ) async {
    loading = true;
    try {
      tokenView = await AccountApi.signUp(
        firstName,
        lastName,
        userName,
        email,
        password
      );
      var sharedPrefs = await SharedPreferences.getInstance();
      sharedPrefs.setToken(tokenView);
    } finally {
      loading = false;
    }
    return tokenView;
  }

  @action
  Future<User> loadProfile() async {
    loading = true;
    try {
      profile = await ProfileApi.getUserAsync();
    } finally {
      loading = false;
    }
    return profile;
  }

  @action
  Future<TokenView> loadToken() async {
    var sharedPrefs = await SharedPreferences.getInstance();
    tokenView = sharedPrefs.getToken();

    if (isLoggedIn) {
      try {
        profile = await ProfileApi.getUserAsync();
        hasLoadedToken = true;
      } on UnauthorizedFailure {
        await logout();
      } finally {
        loading = false;
      }
    } else {
      hasLoadedToken = true;
    }

    loading = false;

    return tokenView;
  }

  @action
  Future logout() async {
    loading = true;
    tokenView = null;
    profile = null;
    var sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.removeToken();
    // invoke resetting other stores
    loading = false;
  }

  @action
  Future<User> updateProfile(
      String id,
      String firstName,
      String middleName,
      String lastName,
      DateTime birthDate,
      String address) async {
    loading = true;
    try {
      this.profile = await ProfileApi.updateProfileAsync(id,firstName,middleName,lastName,birthDate,address);
    } finally {
      loading = false;
    }
    return profile;
  }
}
