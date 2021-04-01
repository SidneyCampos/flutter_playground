extension StringExtension on String {
  String somenteNumeros() {
    return this?.replaceAll(RegExp('[^0-9]'), '')?.trim() ?? '';
  }

  String capitalizar() {
    if (this == null || this.isEmpty) return "";
    return this[0].toUpperCase() + this.substring(1).toLowerCase();
  }

  String removerEspacos() {
    if (this == null || this.isEmpty) return "";
    return this.replaceAll(RegExp(" +"), " ");
  }

  bool emailValido() {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    var regex = RegExp(pattern);
    return (!regex.hasMatch(this)) ? false : true;
  }
}
