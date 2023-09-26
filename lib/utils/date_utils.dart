import 'package:intl/intl.dart';

class DateRefactoring{
	static Map<String, String> months =	{
		"Jan" : "Enero",
		"Feb" : "Febrero",
		"Mar" : "Marzo",
		"Apr" : "Abril",
		"May" : "Mayo",
		"Jun" : "Junio",
		"Jul" : "Julio",
		"Aug" : "Agosto",
		"Sep" : "Septiembre",
		"Oct" : "Octubre",
		"Nov" : "Noviembre",
		"Dec" : "Diciembre",
	};

  static String formatearFecha(DateTime date) {
		Intl.defaultLocale = 'es';
    var monthFormat = DateFormat.MMMM('es');
    String mesEnEspanol = monthFormat.format(date);
    return DateFormat('dd MMMM, y', 'es').format(date).replaceFirst(mesEnEspanol, mesEnEspanol.toLowerCase());
  } 

  static String formatDateSpanish(DateTime date) {
		Intl.defaultLocale = 'es';
    String formatedDate = formatearFecha(date);
    return formatedDate;
  }
}