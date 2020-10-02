enum Flavor {
  DEV,
  STG,
  PRD,
}

class F {
  static Flavor appFlavor;

  static void fromEnvironment(String flavor) {
    switch (flavor) {
      case 'dev':
        appFlavor = Flavor.DEV;
        break;
      case 'stg':
        appFlavor = Flavor.STG;
        break;
      case 'prd':
        appFlavor = Flavor.PRD;
        break;
    }
  }

  static String get title {
    switch (appFlavor) {
      case Flavor.DEV:
        return 'PlayGround-dev';
      case Flavor.STG:
        return 'PlayGround-stg';
      case Flavor.PRD:
        return 'PlayGround-prd';
      default:
        return 'title';
    }
  }
}
