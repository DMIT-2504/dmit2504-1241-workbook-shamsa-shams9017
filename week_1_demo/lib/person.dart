class Person {
  late String _name;
  late int _age;

  Person(String name, int age){
    this._name = name;
    this._age = age;
  }

  String get name {
    return _name;
  }

  set name(String value){
    if(value.trim().isEmpty){
      throw Exception('Name cannot be empty');
    }

    _name = value;
  }

  int get age {
    return _age;
  }

  set age(int value){
    if(value < 0){
      throw Exception('Age must be positive');
    }
    _age = value;
  }

}