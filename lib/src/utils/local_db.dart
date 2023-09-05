// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:pokemon_list/objectbox.g.dart';

class LocalDb {
  LocalDb._(this.store);

  final Store store;

  static Future<LocalDb> createStore() async {
    final directory = await getApplicationDocumentsDirectory();
    final store =
        await openStore(directory: path.join(directory.path, 'objectbox'));
    return LocalDb._(store);
  }
}
