enum OptionType { libre, bloque }

extension OptionTypeExtension on OptionType {
  String get value {
    switch (this) {
      case OptionType.libre:
        return 'libre';
      case OptionType.bloque:
        return 'bloque';
      default:
        return 'bloque';
    }
  }
}
