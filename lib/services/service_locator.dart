import 'package:chatapp/services/auth.dart';
import 'package:chatapp/services/database.dart';
import 'package:get_it/get_it.dart';

GetIt serviceLocator = GetIt.instance;

Future setupServiceLocator() async {
  serviceLocator.registerLazySingleton<Database>(() => Database());
  serviceLocator.registerLazySingleton<Auth>(() => Auth());
}
