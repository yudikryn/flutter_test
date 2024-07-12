import 'package:flutter/widgets.dart';
import 'package:test_flutter/common/state_enum.dart';
import 'package:test_flutter/domain/entities/user.dart';
import 'package:test_flutter/domain/usecases/get_list_user.dart';

class UserNotifier extends ChangeNotifier {
  final GetListUser getListUser;

  UserNotifier({
    required this.getListUser,
  });

  RequestState _userState = RequestState.Empty;
  RequestState get userState => _userState;

  var _userList = <User>[];
  List<User> get userList => _userList;

  String _message = '';
  String get message => _message;

  Future<void> fetchListUser() async {
    _userState = RequestState.Loading;
    notifyListeners();

    final result = await getListUser.execute();
    result.fold(
      (failure) {
        _userState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (data) {
        _userState = RequestState.Loaded;
        _userList = data;
        notifyListeners();
      },
    );
  }

  void refresh() async {
    fetchListUser();
  }
}
