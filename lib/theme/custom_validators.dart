
import 'dart:ffi';

class CustomValidators{
	static String? emailValidator({
			required dynamic value
		}) {
			String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp  = RegExp(pattern);
    return regExp.hasMatch(value ?? '')
					? null 
					: 'El valor introducido no parece un correo valido';
		}

	static String? passwordValidator({
		required dynamic value,
	}){
		final containsUpperCase = RegExp(r'[A-Z]').hasMatch(value);
    final containsLowerCase = RegExp(r'[a-z]').hasMatch(value);
    final containsNumber = RegExp(r'\d').hasMatch(value);
    final containsSymbols = RegExp(r'[`~!@#$%\^&*\(\)_+\\\-={}\[\]\/.,<>;]').hasMatch(value);
    final hasManyCharacters = RegExp(r'^.{8,128}$', dotAll: true).hasMatch(value); // This is variable

    return containsUpperCase && containsLowerCase && containsNumber && containsSymbols && hasManyCharacters 
		? null 
		: 'Error. La contraseña debe tener al menos 8 caracteres y contener un Digito, Caracter Especial, Mayuscula.';

	}

	static String? groupNameNotEmpty({
		required dynamic value,
	}) {
		return (value != "" || value != null) ? null : 'Debe introducir un nombre de grupo';
	}
}  


