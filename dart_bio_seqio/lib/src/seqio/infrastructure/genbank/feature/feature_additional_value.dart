class FeatureAdditionalValue {
  String? _name;
  List<String> _product;
  List<String> _translation;
  List<String> _note;
  List<Map<String, dynamic>> _anotherFeatures;

  FeatureAdditionalValue(
    this._name,
    this._product,
    this._translation,
    this._note,
    this._anotherFeatures,
  );

  factory FeatureAdditionalValue.init() => FeatureAdditionalValue(
        null,
        [],
        [],
        [],
        [],
      );

  set name(String? newName) => _name = newName;
  String? get name => _name;

  set product(String? newProduct) => _product.add(newProduct!);
  String? get product => _product.isNotEmpty ? _product.join(' ') : null;

  set translation(String? newTranslation) => _translation.add(newTranslation!);
  String? get translation => _translation.isNotEmpty ? _translation.join() : null;

  set note(String? newNote) => _note.add(newNote!);
  String? get note => _note.isNotEmpty ? _note.join(' ') : null;

  void addAnotherFeatures(Map<String, dynamic> newAnotherFeatures) =>
      _anotherFeatures.add(newAnotherFeatures);
  List<Map<String, dynamic>>? get anotherFeatures =>
      _anotherFeatures.isNotEmpty ? _anotherFeatures : null;
}
