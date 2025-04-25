import 'package:crm_client/core/service_locator.dart';
import 'package:flutter/material.dart';

import 'core/application.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(Application());
}