
class Faal {

  int _id;
  String _poem;
  String _interpretation;

  Faal(this._id, this._poem, this._interpretation);

  String get interpretation => _interpretation;

  set interpretation(String value) {
    _interpretation = value;
  }

  String get poem => _poem;

  set poem(String value) {
    _poem = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  @override
  String toString() {
    return 'Faal{_id: $_id, _poem: $_poem, _interpretation: $_interpretation}';
  }


}