enum OperationModes {
  file, api
}

class Model {
  static OperationModes operationMode = OperationModes.api;
  static Map fileData = {};
  static String baseurl = '';
}