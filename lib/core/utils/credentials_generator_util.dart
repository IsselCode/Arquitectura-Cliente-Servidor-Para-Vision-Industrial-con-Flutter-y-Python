import 'dart:math';

class CredentialsGeneratorUtil {
  static const _lower = 'abcdefghijklmnopqrstuvwxyz';
  static const _upper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  static const _digits = '0123456789';

  static final Random _rand = Random.secure();

  static String generateUsername({String? base, int randomDigits = 3,}) {
    String normalized;

    if (base == null || base.trim().isEmpty) {
      // Si no se envía base, generamos algo tipo: user + números
      normalized = 'user';
    }
    else {
      normalized = base.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');
      if (normalized.isEmpty) {
        normalized = 'user';
      }
    }

    final suffix = _randomString(_digits, randomDigits);
    return '$normalized$suffix';
  }

  static String generatePassword({int length = 12}) {

    if (length < 3) {
      throw ArgumentError('La longitud mínima es 3');
    }

    final allChars = _lower + _upper + _digits;

    // Garantizamos al menos uno de cada tipo
    final chars = <String>[
      _randomChar(_lower),
      _randomChar(_upper),
      _randomChar(_digits),
    ];

    // El resto se rellena con cualquier carácter permitido
    final remaining = length - chars.length;
    for (int i = 0; i < remaining; i++) {
      chars.add(_randomChar(allChars));
    }

    // Mezclamos para que no siempre empiece en el mismo orden
    chars.shuffle(_rand);

    return chars.join();
  }

  // Helpers
  static String _randomChar(String alphabet) {
    return alphabet[_rand.nextInt(alphabet.length)];
  }

  static String _randomString(String alphabet, int length) {
    return List.generate(length, (_) => _randomChar(alphabet),).join();
  }

}
