import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:csv/csv.dart';
import 'package:synchronized/synchronized.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    secureStorage = const FlutterSecureStorage();
    await _safeInitAsync(() async {
      _version = await secureStorage.getString('ff_version') ?? _version;
    });
    await _safeInitAsync(() async {
      _currentTxt =
          _colorFromIntValue(await secureStorage.getInt('ff_currentTxt')) ??
              _currentTxt;
    });
    await _safeInitAsync(() async {
      _defaultBG =
          _colorFromIntValue(await secureStorage.getInt('ff_defaultBG')) ??
              _defaultBG;
    });
    await _safeInitAsync(() async {
      _currentBG =
          _colorFromIntValue(await secureStorage.getInt('ff_currentBG')) ??
              _currentBG;
    });
    await _safeInitAsync(() async {
      _defaultTxt =
          _colorFromIntValue(await secureStorage.getInt('ff_defaultTxt')) ??
              _defaultTxt;
    });
    await _safeInitAsync(() async {
      _systemIP = await secureStorage.getString('ff_systemIP') ?? _systemIP;
    });
    await _safeInitAsync(() async {
      _systemPort = await secureStorage.getInt('ff_systemPort') ?? _systemPort;
    });
    await _safeInitAsync(() async {
      _firstLoad = await secureStorage.getBool('ff_firstLoad') ?? _firstLoad;
    });
    await _safeInitAsync(() async {
      _isSecure = await secureStorage.getBool('ff_isSecure') ?? _isSecure;
    });
    await _safeInitAsync(() async {
      _wsMessage = await secureStorage.getString('ff_wsMessage') ?? _wsMessage;
    });
    await _safeInitAsync(() async {
      _setChannelList = (await secureStorage.getStringList('ff_setChannelList'))
              ?.map((x) {
                try {
                  return ChannelStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _setChannelList;
    });
    await _safeInitAsync(() async {
      _username = await secureStorage.getString('ff_username') ?? _username;
    });
    await _safeInitAsync(() async {
      _password = await secureStorage.getString('ff_password') ?? _password;
    });
    await _safeInitAsync(() async {
      if (await secureStorage.read(key: 'ff_MySysVars') != null) {
        try {
          final serializedData =
              await secureStorage.getString('ff_MySysVars') ?? '{}';
          _MySysVars =
              SysVarsStruct.fromSerializableMap(jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    await _safeInitAsync(() async {
      _usey = (await secureStorage.getStringList('ff_usey'))
              ?.map(double.parse)
              .toList() ??
          _usey;
    });
    await _safeInitAsync(() async {
      _usex = (await secureStorage.getStringList('ff_usex'))
              ?.map(double.parse)
              .toList() ??
          _usex;
    });
    await _safeInitAsync(() async {
      _SystemUsers = (await secureStorage.getStringList('ff_SystemUsers'))
              ?.map((x) {
                try {
                  return UserRecordStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _SystemUsers;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late FlutterSecureStorage secureStorage;

  String _version = '0.8.1';
  String get version => _version;
  set version(String value) {
    _version = value;
    secureStorage.setString('ff_version', value);
  }

  void deleteVersion() {
    secureStorage.delete(key: 'ff_version');
  }

  Color _currentTxt = Colors.transparent;
  Color get currentTxt => _currentTxt;
  set currentTxt(Color value) {
    _currentTxt = value;
    secureStorage.setInt('ff_currentTxt', value.value);
  }

  void deleteCurrentTxt() {
    secureStorage.delete(key: 'ff_currentTxt');
  }

  Color _defaultBG = const Color(0xff0000ab);
  Color get defaultBG => _defaultBG;
  set defaultBG(Color value) {
    _defaultBG = value;
    secureStorage.setInt('ff_defaultBG', value.value);
  }

  void deleteDefaultBG() {
    secureStorage.delete(key: 'ff_defaultBG');
  }

  Color _currentBG = Colors.transparent;
  Color get currentBG => _currentBG;
  set currentBG(Color value) {
    _currentBG = value;
    secureStorage.setInt('ff_currentBG', value.value);
  }

  void deleteCurrentBG() {
    secureStorage.delete(key: 'ff_currentBG');
  }

  Color _defaultTxt = const Color(0xffffffff);
  Color get defaultTxt => _defaultTxt;
  set defaultTxt(Color value) {
    _defaultTxt = value;
    secureStorage.setInt('ff_defaultTxt', value.value);
  }

  void deleteDefaultTxt() {
    secureStorage.delete(key: 'ff_defaultTxt');
  }

  String _systemIP = '';
  String get systemIP => _systemIP;
  set systemIP(String value) {
    _systemIP = value;
    secureStorage.setString('ff_systemIP', value);
  }

  void deleteSystemIP() {
    secureStorage.delete(key: 'ff_systemIP');
  }

  int _systemPort = 8881;
  int get systemPort => _systemPort;
  set systemPort(int value) {
    _systemPort = value;
    secureStorage.setInt('ff_systemPort', value);
  }

  void deleteSystemPort() {
    secureStorage.delete(key: 'ff_systemPort');
  }

  bool _firstLoad = true;
  bool get firstLoad => _firstLoad;
  set firstLoad(bool value) {
    _firstLoad = value;
    secureStorage.setBool('ff_firstLoad', value);
  }

  void deleteFirstLoad() {
    secureStorage.delete(key: 'ff_firstLoad');
  }

  bool _isSecure = false;
  bool get isSecure => _isSecure;
  set isSecure(bool value) {
    _isSecure = value;
    secureStorage.setBool('ff_isSecure', value);
  }

  void deleteIsSecure() {
    secureStorage.delete(key: 'ff_isSecure');
  }

  String _wsMessage = 'connecting...';
  String get wsMessage => _wsMessage;
  set wsMessage(String value) {
    _wsMessage = value;
    secureStorage.setString('ff_wsMessage', value);
  }

  void deleteWsMessage() {
    secureStorage.delete(key: 'ff_wsMessage');
  }

  List<ChannelStruct> _channelLogList = [];
  List<ChannelStruct> get channelLogList => _channelLogList;
  set channelLogList(List<ChannelStruct> value) {
    _channelLogList = value;
  }

  void addToChannelLogList(ChannelStruct value) {
    channelLogList.add(value);
  }

  void removeFromChannelLogList(ChannelStruct value) {
    channelLogList.remove(value);
  }

  void removeAtIndexFromChannelLogList(int index) {
    channelLogList.removeAt(index);
  }

  void updateChannelLogListAtIndex(
    int index,
    ChannelStruct Function(ChannelStruct) updateFn,
  ) {
    channelLogList[index] = updateFn(_channelLogList[index]);
  }

  void insertAtIndexInChannelLogList(int index, ChannelStruct value) {
    channelLogList.insert(index, value);
  }

  List<AuditStruct> _auditLogList = [];
  List<AuditStruct> get auditLogList => _auditLogList;
  set auditLogList(List<AuditStruct> value) {
    _auditLogList = value;
  }

  void addToAuditLogList(AuditStruct value) {
    auditLogList.add(value);
  }

  void removeFromAuditLogList(AuditStruct value) {
    auditLogList.remove(value);
  }

  void removeAtIndexFromAuditLogList(int index) {
    auditLogList.removeAt(index);
  }

  void updateAuditLogListAtIndex(
    int index,
    AuditStruct Function(AuditStruct) updateFn,
  ) {
    auditLogList[index] = updateFn(_auditLogList[index]);
  }

  void insertAtIndexInAuditLogList(int index, AuditStruct value) {
    auditLogList.insert(index, value);
  }

  List<ChannelStruct> _setChannelList = [
    ChannelStruct.fromSerializableMap(jsonDecode(
        '{\"channel\":\"0\",\"msg\":\"Local Session\",\"character\":\"-\",\"code\":\"0\"}')),
    ChannelStruct.fromSerializableMap(jsonDecode(
        '{\"channel\":\"1\",\"msg\":\"idle\",\"character\":\"-\",\"code\":\"0\"}')),
    ChannelStruct.fromSerializableMap(jsonDecode(
        '{\"channel\":\"2\",\"msg\":\"idle\",\"character\":\"-\",\"code\":\"0\"}')),
    ChannelStruct.fromSerializableMap(jsonDecode(
        '{\"channel\":\"3\",\"msg\":\"idle\",\"character\":\"-\",\"code\":\"0\"}')),
    ChannelStruct.fromSerializableMap(jsonDecode(
        '{\"channel\":\"4\",\"msg\":\"idle\",\"character\":\"-\",\"code\":\"0\"}')),
    ChannelStruct.fromSerializableMap(jsonDecode(
        '{\"channel\":\"5\",\"msg\":\"idle\",\"character\":\"-\",\"code\":\"0\"}')),
    ChannelStruct.fromSerializableMap(jsonDecode(
        '{\"channel\":\"6\",\"msg\":\"idle\",\"character\":\"-\",\"code\":\"0\"}')),
    ChannelStruct.fromSerializableMap(jsonDecode(
        '{\"channel\":\"7\",\"msg\":\"idle\",\"character\":\"-\",\"code\":\"0\"}')),
    ChannelStruct.fromSerializableMap(jsonDecode(
        '{\"channel\":\"8\",\"msg\":\"idle\",\"character\":\"-\",\"code\":\"0\"}')),
    ChannelStruct.fromSerializableMap(jsonDecode(
        '{\"channel\":\"9\",\"msg\":\"idle\",\"character\":\"-\",\"code\":\"0\"}')),
    ChannelStruct.fromSerializableMap(jsonDecode(
        '{\"channel\":\"10\",\"msg\":\"idle\",\"character\":\"-\",\"code\":\"0\"}')),
    ChannelStruct.fromSerializableMap(jsonDecode(
        '{\"channel\":\"11\",\"msg\":\"idle\",\"character\":\"-\",\"code\":\"0\"}')),
    ChannelStruct.fromSerializableMap(jsonDecode(
        '{\"channel\":\"12\",\"msg\":\"idle\",\"character\":\"-\",\"code\":\"0\"}')),
    ChannelStruct.fromSerializableMap(jsonDecode(
        '{\"channel\":\"13\",\"msg\":\"idle\",\"character\":\"-\",\"code\":\"0\"}')),
    ChannelStruct.fromSerializableMap(jsonDecode(
        '{\"channel\":\"14\",\"msg\":\"idle\",\"character\":\"-\",\"code\":\"0\"}')),
    ChannelStruct.fromSerializableMap(jsonDecode(
        '{\"channel\":\"15\",\"msg\":\"idle\",\"character\":\"-\",\"code\":\"0\"}'))
  ];
  List<ChannelStruct> get setChannelList => _setChannelList;
  set setChannelList(List<ChannelStruct> value) {
    _setChannelList = value;
    secureStorage.setStringList(
        'ff_setChannelList', value.map((x) => x.serialize()).toList());
  }

  void deleteSetChannelList() {
    secureStorage.delete(key: 'ff_setChannelList');
  }

  void addToSetChannelList(ChannelStruct value) {
    setChannelList.add(value);
    secureStorage.setStringList('ff_setChannelList',
        _setChannelList.map((x) => x.serialize()).toList());
  }

  void removeFromSetChannelList(ChannelStruct value) {
    setChannelList.remove(value);
    secureStorage.setStringList('ff_setChannelList',
        _setChannelList.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromSetChannelList(int index) {
    setChannelList.removeAt(index);
    secureStorage.setStringList('ff_setChannelList',
        _setChannelList.map((x) => x.serialize()).toList());
  }

  void updateSetChannelListAtIndex(
    int index,
    ChannelStruct Function(ChannelStruct) updateFn,
  ) {
    setChannelList[index] = updateFn(_setChannelList[index]);
    secureStorage.setStringList('ff_setChannelList',
        _setChannelList.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInSetChannelList(int index, ChannelStruct value) {
    setChannelList.insert(index, value);
    secureStorage.setStringList('ff_setChannelList',
        _setChannelList.map((x) => x.serialize()).toList());
  }

  bool _connected = false;
  bool get connected => _connected;
  set connected(bool value) {
    _connected = value;
  }

  String _username = '';
  String get username => _username;
  set username(String value) {
    _username = value;
    secureStorage.setString('ff_username', value);
  }

  void deleteUsername() {
    secureStorage.delete(key: 'ff_username');
  }

  String _password = '';
  String get password => _password;
  set password(String value) {
    _password = value;
    secureStorage.setString('ff_password', value);
  }

  void deletePassword() {
    secureStorage.delete(key: 'ff_password');
  }

  SysVarsStruct _MySysVars = SysVarsStruct();
  SysVarsStruct get MySysVars => _MySysVars;
  set MySysVars(SysVarsStruct value) {
    _MySysVars = value;
    secureStorage.setString('ff_MySysVars', value.serialize());
  }

  void deleteMySysVars() {
    secureStorage.delete(key: 'ff_MySysVars');
  }

  void updateMySysVarsStruct(Function(SysVarsStruct) updateFn) {
    updateFn(_MySysVars);
    secureStorage.setString('ff_MySysVars', _MySysVars.serialize());
  }

  List<double> _usey = [0.0, 0.0, 0.0, 0.0];
  List<double> get usey => _usey;
  set usey(List<double> value) {
    _usey = value;
    secureStorage.setStringList(
        'ff_usey', value.map((x) => x.toString()).toList());
  }

  void deleteUsey() {
    secureStorage.delete(key: 'ff_usey');
  }

  void addToUsey(double value) {
    usey.add(value);
    secureStorage.setStringList(
        'ff_usey', _usey.map((x) => x.toString()).toList());
  }

  void removeFromUsey(double value) {
    usey.remove(value);
    secureStorage.setStringList(
        'ff_usey', _usey.map((x) => x.toString()).toList());
  }

  void removeAtIndexFromUsey(int index) {
    usey.removeAt(index);
    secureStorage.setStringList(
        'ff_usey', _usey.map((x) => x.toString()).toList());
  }

  void updateUseyAtIndex(
    int index,
    double Function(double) updateFn,
  ) {
    usey[index] = updateFn(_usey[index]);
    secureStorage.setStringList(
        'ff_usey', _usey.map((x) => x.toString()).toList());
  }

  void insertAtIndexInUsey(int index, double value) {
    usey.insert(index, value);
    secureStorage.setStringList(
        'ff_usey', _usey.map((x) => x.toString()).toList());
  }

  List<double> _usex = [0.0, 15.0, 30.0, 45.0];
  List<double> get usex => _usex;
  set usex(List<double> value) {
    _usex = value;
    secureStorage.setStringList(
        'ff_usex', value.map((x) => x.toString()).toList());
  }

  void deleteUsex() {
    secureStorage.delete(key: 'ff_usex');
  }

  void addToUsex(double value) {
    usex.add(value);
    secureStorage.setStringList(
        'ff_usex', _usex.map((x) => x.toString()).toList());
  }

  void removeFromUsex(double value) {
    usex.remove(value);
    secureStorage.setStringList(
        'ff_usex', _usex.map((x) => x.toString()).toList());
  }

  void removeAtIndexFromUsex(int index) {
    usex.removeAt(index);
    secureStorage.setStringList(
        'ff_usex', _usex.map((x) => x.toString()).toList());
  }

  void updateUsexAtIndex(
    int index,
    double Function(double) updateFn,
  ) {
    usex[index] = updateFn(_usex[index]);
    secureStorage.setStringList(
        'ff_usex', _usex.map((x) => x.toString()).toList());
  }

  void insertAtIndexInUsex(int index, double value) {
    usex.insert(index, value);
    secureStorage.setStringList(
        'ff_usex', _usex.map((x) => x.toString()).toList());
  }

  List<String> _socketMessageLog = [];
  List<String> get socketMessageLog => _socketMessageLog;
  set socketMessageLog(List<String> value) {
    _socketMessageLog = value;
  }

  void addToSocketMessageLog(String value) {
    socketMessageLog.add(value);
  }

  void removeFromSocketMessageLog(String value) {
    socketMessageLog.remove(value);
  }

  void removeAtIndexFromSocketMessageLog(int index) {
    socketMessageLog.removeAt(index);
  }

  void updateSocketMessageLogAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    socketMessageLog[index] = updateFn(_socketMessageLog[index]);
  }

  void insertAtIndexInSocketMessageLog(int index, String value) {
    socketMessageLog.insert(index, value);
  }

  bool _showUserSearch = false;
  bool get showUserSearch => _showUserSearch;
  set showUserSearch(bool value) {
    _showUserSearch = value;
  }

  List<UserRecordStruct> _SystemUsers = [];
  List<UserRecordStruct> get SystemUsers => _SystemUsers;
  set SystemUsers(List<UserRecordStruct> value) {
    _SystemUsers = value;
    secureStorage.setStringList(
        'ff_SystemUsers', value.map((x) => x.serialize()).toList());
  }

  void deleteSystemUsers() {
    secureStorage.delete(key: 'ff_SystemUsers');
  }

  void addToSystemUsers(UserRecordStruct value) {
    SystemUsers.add(value);
    secureStorage.setStringList(
        'ff_SystemUsers', _SystemUsers.map((x) => x.serialize()).toList());
  }

  void removeFromSystemUsers(UserRecordStruct value) {
    SystemUsers.remove(value);
    secureStorage.setStringList(
        'ff_SystemUsers', _SystemUsers.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromSystemUsers(int index) {
    SystemUsers.removeAt(index);
    secureStorage.setStringList(
        'ff_SystemUsers', _SystemUsers.map((x) => x.serialize()).toList());
  }

  void updateSystemUsersAtIndex(
    int index,
    UserRecordStruct Function(UserRecordStruct) updateFn,
  ) {
    SystemUsers[index] = updateFn(_SystemUsers[index]);
    secureStorage.setStringList(
        'ff_SystemUsers', _SystemUsers.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInSystemUsers(int index, UserRecordStruct value) {
    SystemUsers.insert(index, value);
    secureStorage.setStringList(
        'ff_SystemUsers', _SystemUsers.map((x) => x.serialize()).toList());
  }

  UserRecordStruct _currentSearchUser = UserRecordStruct.fromSerializableMap(
      jsonDecode(
          '{\"Name\":\"Test User\",\"Addr2\":\"123 Test Street\",\"Addr3\":\"Test, CA, 90210\",\"Phone\":\"1234567890\",\"Born\":\"1727461560000\",\"Sex\":\"M\",\"DefaultEditor\":\"FSE\",\"System\":\"IBM-PC\",\"Screen\":\"80 x 24  (page @ 24)---(page @ 2 for continuous)\",\"UserClass\":\"USER\",\"Passwd\":\"abba123\",\"CreditAvail\":\"0\",\"CreditTotal\":\"0\",\"CreditsPaid\":\"0\",\"HasMaster\":\"NO\",\"Suspended\":\"NO\",\"TagForKill\":\"NO\",\"Protected\":\"NO\",\"Username\":\"testuser\",\"AcctCreated\":\"1727461680000\",\"LastCall\":\"1727461680000\",\"DayUsage\":\"25.0\"}'));
  UserRecordStruct get currentSearchUser => _currentSearchUser;
  set currentSearchUser(UserRecordStruct value) {
    _currentSearchUser = value;
  }

  void updateCurrentSearchUserStruct(Function(UserRecordStruct) updateFn) {
    updateFn(_currentSearchUser);
  }

  String _sideNavMC = 'summary';
  String get sideNavMC => _sideNavMC;
  set sideNavMC(String value) {
    _sideNavMC = value;
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}

Color? _colorFromIntValue(int? val) {
  if (val == null) {
    return null;
  }
  return Color(val);
}

extension FlutterSecureStorageExtensions on FlutterSecureStorage {
  static final _lock = Lock();

  Future<void> writeSync({required String key, String? value}) async =>
      await _lock.synchronized(() async {
        await write(key: key, value: value);
      });

  void remove(String key) => delete(key: key);

  Future<String?> getString(String key) async => await read(key: key);
  Future<void> setString(String key, String value) async =>
      await writeSync(key: key, value: value);

  Future<bool?> getBool(String key) async => (await read(key: key)) == 'true';
  Future<void> setBool(String key, bool value) async =>
      await writeSync(key: key, value: value.toString());

  Future<int?> getInt(String key) async =>
      int.tryParse(await read(key: key) ?? '');
  Future<void> setInt(String key, int value) async =>
      await writeSync(key: key, value: value.toString());

  Future<double?> getDouble(String key) async =>
      double.tryParse(await read(key: key) ?? '');
  Future<void> setDouble(String key, double value) async =>
      await writeSync(key: key, value: value.toString());

  Future<List<String>?> getStringList(String key) async =>
      await read(key: key).then((result) {
        if (result == null || result.isEmpty) {
          return null;
        }
        return const CsvToListConverter()
            .convert(result)
            .first
            .map((e) => e.toString())
            .toList();
      });
  Future<void> setStringList(String key, List<String> value) async =>
      await writeSync(key: key, value: const ListToCsvConverter().convert([value]));
}
