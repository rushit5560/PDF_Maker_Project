
class FieldValidator {

  String? validateFileName(String value) {
    if (value.isEmpty) {
      return 'File name is Required';
    }
    return null;
  }
}