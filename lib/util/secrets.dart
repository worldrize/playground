import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

class Secrets {
  YamlMap secrets = YamlMap();

  static Secrets instance = Secrets();

  String get publicSdkKey => instance.secrets['revenuecat']['public_sdk_key'];

  Future loadSecrets() async {
    final data = await rootBundle.loadString('secrets/env.yml');
    instance.secrets = loadYaml(data);
  }
}
