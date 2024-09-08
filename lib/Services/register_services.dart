import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:profixer/Services/Alert_services.dart';
import 'package:profixer/Services/Navigation_services.dart';
import 'package:profixer/Services/auth_services.dart';
import 'package:profixer/Services/database_services.dart';
import 'package:profixer/Services/storage_services.dart';
import 'Meadia_services.dart';

Future<void> registerServices() async{
  final GetIt getIt=GetIt.instance;
  getIt.registerSingleton<NavigationService>(NavigationService());
  getIt.registerSingleton<MediaService>(MediaService());
  getIt.registerSingleton<AuthServices>(AuthServices());
  getIt.registerSingleton<DatabaseServices>(DatabaseServices());
  getIt.registerSingleton<AlertServices>(AlertServices());
  getIt.registerSingleton<StorageServices>(StorageServices());
}

