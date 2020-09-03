// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserStore on _UserStore, Store {
  Computed<bool> _$isLoggedInComputed;

  @override
  bool get isLoggedIn => (_$isLoggedInComputed ??=
      Computed<bool>(() => super.isLoggedIn, name: '_UserStore.isLoggedIn'))
      .value;

  final _$tokenViewAtom = Atom(name: '_UserStore.tokenView');

  @override
  TokenView get tokenView {
    _$tokenViewAtom.reportRead();
    return super.tokenView;
  }

  @override
  set tokenView(TokenView value) {
    _$tokenViewAtom.reportWrite(value, super.tokenView, () {
      super.tokenView = value;
    });
  }

  final _$hasLoadedTokenAtom = Atom(name: '_UserStore.hasLoadedToken');

  @override
  bool get hasLoadedToken {
    _$hasLoadedTokenAtom.reportRead();
    return super.hasLoadedToken;
  }

  @override
  set hasLoadedToken(bool value) {
    _$hasLoadedTokenAtom.reportWrite(value, super.hasLoadedToken, () {
      super.hasLoadedToken = value;
    });
  }

  final _$loadingAtom = Atom(name: '_UserStore.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$profileAtom = Atom(name: '_UserStore.profile');

  @override
  User get profile {
    _$profileAtom.reportRead();
    return super.profile;
  }

  @override
  set profile(User value) {
    _$profileAtom.reportWrite(value, super.profile, () {
      super.profile = value;
    });
  }

  final _$loginAsyncAction = AsyncAction('_UserStore.login');

  @override
  Future<TokenView> login(String email, String password) {
    return _$loginAsyncAction.run(() => super.login(email, password));
  }

  final _$signUpAsyncAction = AsyncAction('_UserStore.signUp');

  @override
  Future<TokenView> signUp(String firstName, String lastName, String userName,
      String email, String password) {
    return _$signUpAsyncAction.run(
            () => super.signUp(firstName, lastName, userName, email, password));
  }

  final _$loadProfileAsyncAction = AsyncAction('_UserStore.loadProfile');

  @override
  Future<User> loadProfile() {
    return _$loadProfileAsyncAction.run(() => super.loadProfile());
  }

  final _$loadTokenAsyncAction = AsyncAction('_UserStore.loadToken');

  @override
  Future<TokenView> loadToken() {
    return _$loadTokenAsyncAction.run(() => super.loadToken());
  }

  final _$logoutAsyncAction = AsyncAction('_UserStore.logout');

  @override
  Future<dynamic> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  final _$updateProfileAsyncAction = AsyncAction('_UserStore.updateProfile');

  @override
  Future<User> updateProfile(String firstName, String middleName,
      String lastName, String address) {
    return _$updateProfileAsyncAction.run(() => super.updateProfile(
         firstName, middleName, lastName, address));
  }

  @override
  String toString() {
    return '''
tokenView: ${tokenView},
hasLoadedToken: ${hasLoadedToken},
loading: ${loading},
profile: ${profile},
isLoggedIn: ${isLoggedIn}
    ''';
  }
}