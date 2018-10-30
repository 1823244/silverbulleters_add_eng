﻿Перем КэшПостроительДереваТестов;
Перем ЗагружаемыйПуть;

Перем КонтейнерТестов;
Перем ТекущаяГруппа;

// { Plugin interface
Функция ОписаниеПлагина(ВозможныеТипыПлагинов) Экспорт
	Результат = Новый Структура;
	Результат.Вставить("Тип", ВозможныеТипыПлагинов.Загрузчик);
	Результат.Вставить("Идентификатор", Метаданные().Имя);
	Результат.Вставить("Представление", "Загрузить тесты из файлов");
	
	Возврат Новый ФиксированнаяСтруктура(Результат);
КонецФункции

Процедура Инициализация(КонтекстЯдраПараметр) Экспорт
КонецПроцедуры

// } Plugin interface

// { Loader interface
#Если ТолстыйКлиентОбычноеПриложение Тогда
Функция ВыбратьПутьИнтерактивно(КонтекстЯдра, ТекущийПуть = "") Экспорт
	ДиалогВыбораТеста = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
	ДиалогВыбораТеста.Фильтр = "Обработка-тест (*.epf)|*.epf|Отчет-тест (*.erf)|*.erf|Все файлы|*";
	ДиалогВыбораТеста.МножественныйВыбор = Истина;
	ДиалогВыбораТеста.ПроверятьСуществованиеФайла = Истина;
	ДиалогВыбораТеста.ПолноеИмяФайла = ТекущийПуть;
	
	Результат = Новый ТекстовыйДокумент;
	Если ДиалогВыбораТеста.Выбрать() Тогда
		Для каждого ПолноеИмяФайла Из ДиалогВыбораТеста.ВыбранныеФайлы Цикл
			Результат.ДобавитьСтроку(ПолноеИмяФайла);
		КонецЦикла;
	КонецЕсли;
	Текст = Результат.ПолучитьТекст();
	
	Возврат Лев(Текст, СтрДлина(Текст) - 1);
КонецФункции
#КонецЕсли

Функция Загрузить(КонтекстЯдра, Путь) Экспорт
	ИспользоватьПрямыеПутиФайлов = КонтекстЯдра.ИспользоватьПрямыеПутиФайлов;
	
	ПостроительДереваТестов = КонтекстЯдра.Плагин("ПостроительДереваТестов");
	ДеревоТестов = Неопределено;
	Для Сч = 1 По СтрЧислоСтрок(Путь) Цикл
		ФайлОбработки = Новый Файл(СтрПолучитьСтроку(Путь, Сч));
		
		Если ДеревоТестов = Неопределено Тогда
			ДеревоТестов = ПостроительДереваТестов.СоздатьКонтейнер(ФайлОбработки.Путь);
		КонецЕсли;
		
		КонтейнерСТестамиОбработки = ЗагрузитьФайл(ПостроительДереваТестов, ФайлОбработки, КонтекстЯдра);
		Если КонтейнерСТестамиОбработки.Строки.Количество() > 0 Тогда
			ДеревоТестов.Строки.Добавить(КонтейнерСТестамиОбработки);
		КонецЕсли;
	КонецЦикла;
	
	Возврат ДеревоТестов;
КонецФункции

Функция ПолучитьКонтекстПоПути(КонтекстЯдра, Путь) Экспорт
	ФайлОбработки = Новый Файл(Путь);
	
	Обработка = ПолучитьКонтекстОбработки(ФайлОбработки);
	
	Возврат Обработка;
КонецФункции
// } Loader interface

Функция ПолучитьКонтекстОбработки(Знач ФайлОбработки, ИмяОбработки = "") Экспорт
	
	ЭтоФайлОтчета = (НРег(ФайлОбработки.Расширение) = ".erf");
	
	Если ИспользоватьПрямыеПутиФайлов Тогда
		ПроверитьКорректностьФайла(ФайлОбработки);
		
		Если ЭтоФайлОтчета Тогда
			Обработка = ВнешниеОтчеты.Создать(ФайлОбработки.ПолноеИмя, Ложь);	
		Иначе
			Обработка = ВнешниеОбработки.Создать(ФайлОбработки.ПолноеИмя, Ложь);
		КонецЕсли;
	Иначе
		Попытка
			Если ЭтоФайлОтчета Тогда
				Обработка = ВнешниеОтчеты.Создать(ФайлОбработки.ИмяБезРасширения, Ложь);
			Иначе
				Обработка = ВнешниеОбработки.Создать(ФайлОбработки.ИмяБезРасширения, Ложь);
			КонецЕсли;
		Исключение
			ПроверитьКорректностьФайла(ФайлОбработки);
			
			Если ЭтоФайлОтчета Тогда
				Обработка = ВнешниеОтчеты.Создать(ФайлОбработки.ПолноеИмя, Ложь);	
			Иначе
				Обработка = ВнешниеОбработки.Создать(ФайлОбработки.ПолноеИмя, Ложь);
			КонецЕсли;
		КонецПопытки;
	КонецЕсли; 
	
	ИмяОбработки = СтрЗаменить("" + Обработка, "ВнешняяОбработкаОбъект.", "");
	ИмяОбработки = СтрЗаменить("" + ИмяОбработки, "ExternalDataProcessorObject.", "");
	
	Возврат Обработка;
	
КонецФункции

Процедура ПроверитьКорректностьФайла(Файл)
	Если Не Файл.Существует() Тогда
		ВызватьИсключение "Переданный файл не существует файл <" + Файл.ПолноеИмя + ">";
	КонецЕсли;
	Если Файл.ЭтоКаталог() Тогда
		ВызватьИсключение "Передан каталог вместо файла <" + Файл.ПолноеИмя + ">";
	КонецЕсли;
КонецПроцедуры

Функция ЗагрузитьФайл(ПостроительДереваТестов, ФайлОбработки, КонтекстЯдра, ИмяОбработки = "") Экспорт
	Обработка = ПолучитьКонтекстОбработки(ФайлОбработки, ИмяОбработки);
	ЗаполнитьСвойствоПриНаличии(Обработка, "ПутьКФайлуПолный", ФайлОбработки.ПолноеИмя);
	Попытка
		Контейнер = ЗагрузитьТестыВНовомФормате(ПостроительДереваТестов, Обработка, ФайлОбработки, ИмяОбработки, КонтекстЯдра);
	Исключение
		ТекстОшибки = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		Если ЭтоНовыйФорматОбработки(ТекстОшибки) Тогда
			ВызватьИсключение;
		Иначе
			Контейнер = ЗагрузитьТестыВСтаромФормате(ПостроительДереваТестов, Обработка, ФайлОбработки);
		КонецЕсли;
	КонецПопытки;
	
	Возврат Контейнер;
КонецФункции

Функция ЗагрузитьТестыВНовомФормате(ПостроительДереваТестов, Обработка, ФайлОбработки, ИмяОбработки, КонтекстЯдра)
	ЗагружаемыйПуть = ФайлОбработки.ПолноеИмя;
	КэшПостроительДереваТестов = ПостроительДереваТестов;
	Если НРег(ФайлОбработки.Расширение) = ".erf" Тогда
		ИконкаУзла = ПостроительДереваТестов.ИконкиУзловДереваТестов.Отчет; 
	Иначе
		ИконкаУзла = ПостроительДереваТестов.ИконкиУзловДереваТестов.Обработка; 
	КонецЕсли;
	КонтейнерТестов = ПостроительДереваТестов.СоздатьКонтейнер(ИмяОбработки, ИконкаУзла);
	
	Попытка
		Обработка.ЗаполнитьНаборТестов(ЭтотОбъект, КонтекстЯдра);
	Исключение
		Инфо = ИнформацияОбОшибке();
		Если (Инфо.ИмяМодуля = "ВнешняяОбработка.ЗагрузчикФайла.МодульОбъекта" ИЛИ Инфо.ИмяМодуля = "ExternalDataProcessor.ЗагрузчикФайла.ObjectModule") И
			(Инфо.Описание = "Слишком много фактических параметров" Или
			Инфо.Описание = "Too many actual parameters") И
			Найти(Инфо.ИсходнаяСтрока, "Обработка.ЗаполнитьНаборТестов(ЭтотОбъект, КонтекстЯдра);") > 0
			Тогда
				
				Обработка.ЗаполнитьНаборТестов(ЭтотОбъект);

			Иначе
				ВызватьИсключение;
			КонецЕсли;
	КонецПопытки;
	
	Результат = КонтейнерТестов;
	КонтейнерТестов = Неопределено;
	ТекущаяГруппа = Неопределено;
	
	Возврат Результат;
КонецФункции

Функция ЭтоНовыйФорматОбработки(Знач ТекстОшибки)
	ЭтоНовыйФорматОбработки = Не ЕстьОшибка_МетодОбъектаНеОбнаружен(ТекстОшибки, "ЗаполнитьНаборТестов");
	
	Возврат ЭтоНовыйФорматОбработки;
КонецФункции

Функция ЗагрузитьТестыВСтаромФормате(ПостроительДереваТестов, Обработка, ФайлОбработки)
	Попытка
		СписокТестов = Обработка.ПолучитьСписокТестов();
	Исключение
		Описание = ОписаниеОшибки();
		Если Найти(Описание, "Недостаточно фактических параметров") > 0 Тогда
			ВызватьИсключение "Старый формат тестов в обработке тестов <"+ФайлОбработки.ПолноеИмя+">."+Символы.ПС+
				"Метод ПолучитьСписокТестов сейчас не принимает параметров";
		КонецЕсли;
		
		Если Найти(Описание, "Метод объекта не обнаружен (ПолучитьСписокТестов)") = 0 И
			Найти(Описание, "Object method not found (ПолучитьСписокТестов)") = 0 Тогда
			ВызватьИсключение Описание;
		КонецЕсли;
	КонецПопытки;
	
	СлучайныйПорядокВыполнения = Истина;
	Попытка
		СлучайныйПорядокВыполнения = Обработка.РазрешенСлучайныйПорядокВыполненияТестов();
	Исключение
	КонецПопытки;
	Результат = ПолучитьКонтейнерДереваТестовПоСпискуТестов(ПостроительДереваТестов, СписокТестов, ФайлОбработки.ИмяБезРасширения, ФайлОбработки.ПолноеИмя, СлучайныйПорядокВыполнения);
	
	Возврат Результат;	
КонецФункции

Функция ПолучитьКонтейнерДереваТестовПоСпискуТестов(ПостроительДереваТестов, СписокТестов, ИмяКонтейнера, Путь, СлучайныйПорядокВыполнения = Истина) Экспорт
	Контейнер = ПостроительДереваТестов.СоздатьКонтейнер(ИмяКонтейнера, ПостроительДереваТестов.ИконкиУзловДереваТестов.Обработка);
	Контейнер.СлучайныйПорядокВыполнения = СлучайныйПорядокВыполнения;
	Если ЗначениеЗаполнено(СписокТестов) И ТипЗнч(СписокТестов) = Тип("Массив") Тогда
		Для каждого Тест Из СписокТестов Цикл
			Элемент = Неопределено;
			Если ТипЗнч(Тест) = Тип("Строка") Тогда
				Элемент = ПостроительДереваТестов.СоздатьЭлемент(Путь, Тест);
			ИначеЕсли ТипЗнч(Тест) = Тип("Структура") Тогда
				ИмяМетода = Тест.ИмяТеста;
				Представление = Неопределено;
				Если Не Тест.Свойство("ПредставлениеТеста", Представление) Тогда
					Представление = ИмяМетода;
				КонецЕсли;
				Элемент = ПостроительДереваТестов.СоздатьЭлемент(Путь, ИмяМетода, Представление);
				Параметр = Неопределено;
				Если Тест.Свойство("Параметр", Параметр) Тогда
					Элемент.Параметры.Добавить(Параметр);
				КонецЕсли;
			Иначе
				ВызватьИсключение "Тест может быть описан либо строкой либо структурой";
			КонецЕсли;
			Если ЗначениеЗаполнено(Элемент) Тогда
				Контейнер.Строки.Добавить(Элемент);
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
	Возврат Контейнер;
КонецФункции

// { API нового формата
Процедура СлучайныйПорядокВыполнения() Экспорт
	Если ЗначениеЗаполнено(КонтейнерТестов) Тогда
		КонтейнерТестов.СлучайныйПорядокВыполнения = Истина;
	КонецЕсли;
КонецПроцедуры

Процедура СтрогийПорядокВыполнения() Экспорт
	Если ЗначениеЗаполнено(КонтейнерТестов) Тогда
		КонтейнерТестов.СлучайныйПорядокВыполнения = Ложь;

		ОстановитьВыполнениеПослеПаденияТестов();
	КонецЕсли;
КонецПроцедуры

Процедура ПродолжитьВыполнениеПослеПаденияТеста() Экспорт
	Если ЗначениеЗаполнено(КонтейнерТестов) Тогда
		КонтейнерТестов.ПродолжитьВыполнениеПослеПаденияТеста = Истина;
	КонецЕсли;	
КонецПроцедуры

Процедура ОстановитьВыполнениеПослеПаденияТестов() Экспорт
	Если ЗначениеЗаполнено(КонтейнерТестов) Тогда
		КонтейнерТестов.ПродолжитьВыполнениеПослеПаденияТеста = Ложь;
	КонецЕсли;	
КонецПроцедуры

Процедура НачатьГруппу(Знач ИмяГруппы, Знач СтрогийПорядокВыполнения = Ложь) Экспорт
	ТекущаяГруппа = КэшПостроительДереваТестов.СоздатьКонтейнер(ИмяГруппы, КэшПостроительДереваТестов.ИконкиУзловДереваТестов.Группа);
	ТекущаяГруппа.Путь = ЗагружаемыйПуть;
	ТекущаяГруппа.СлучайныйПорядокВыполнения = Не СтрогийПорядокВыполнения;
	КонтейнерТестов.Строки.Добавить(ТекущаяГруппа);
КонецПроцедуры

Функция Добавить(Знач ИмяМетода, Знач Параметры = Неопределено, Знач Представление = "") Экспорт
	Если Не ЗначениеЗаполнено(Параметры) ИЛИ ТипЗнч(Параметры) <> Тип("Массив") Тогда
		Если ТипЗнч(Параметры) = Тип("Строка") И Представление = "" Тогда
			Представление = Параметры;
		КонецЕсли;
		Параметры = Неопределено;
	КонецЕсли;
	Элемент = КэшПостроительДереваТестов.СоздатьЭлемент(ЗагружаемыйПуть, ИмяМетода, Представление);
	Если Параметры <> Неопределено Тогда
		Элемент.Параметры = Параметры;
	КонецЕсли;
	Если ЗначениеЗаполнено(ТекущаяГруппа) Тогда
		ТекущаяГруппа.Строки.Добавить(Элемент);
	Иначе
		КонтейнерТестов.Строки.Добавить(Элемент);
	КонецЕсли;
	
	Возврат Элемент;
КонецФункции

Функция ДобавитьДеструктор(Знач ИмяМетодаДеструктора, Знач Представление = "") Экспорт
	ЭлементДеструктор = Добавить(ИмяМетодаДеструктора, Неопределено, Представление);
	Если ЗначениеЗаполнено(ТекущаяГруппа) Тогда
		ТекущаяГруппа.ЭлементДеструктор = ЭлементДеструктор;
	Иначе
		КонтейнерТестов.ЭлементДеструктор = ЭлементДеструктор;
	КонецЕсли;
КонецФункции

Функция ПараметрыТеста(Знач Парам1, Знач Парам2 = Неопределено, Знач Парам3 = Неопределено, Знач Парам4 = Неопределено, Знач Парам5 = Неопределено, Знач Парам6 = Неопределено, Знач Парам7 = Неопределено, Знач Парам8 = Неопределено, Знач Парам9 = Неопределено) Экспорт
	ВсеПараметры = Новый Массив;
	ВсеПараметры.Добавить(Парам1);
	ВсеПараметры.Добавить(Парам2);
	ВсеПараметры.Добавить(Парам3);
	ВсеПараметры.Добавить(Парам4);
	ВсеПараметры.Добавить(Парам5);
	ВсеПараметры.Добавить(Парам6);
	ВсеПараметры.Добавить(Парам7);
	ВсеПараметры.Добавить(Парам8);
	ВсеПараметры.Добавить(Парам9);
	
	ИндексСПоследнимПараметром = 0;
	Для Сч = 0 По ВсеПараметры.ВГраница() Цикл
		Индекс = ВсеПараметры.ВГраница() - Сч;
		Если ВсеПараметры[Индекс] <> Неопределено Тогда
			ИндексСПоследнимПараметром = Индекс;
			Прервать;
		КонецЕсли;
	КонецЦикла;
	
	ПараметрыТеста = Новый Массив;
	Для Сч = 0 По ИндексСПоследнимПараметром Цикл
		ПараметрыТеста.Добавить(ВсеПараметры[Сч]);
	КонецЦикла;
	
	Возврат ПараметрыТеста;
КонецФункции
// } API нового формата

// { Helpers
Функция ЕстьОшибка_МетодОбъектаНеОбнаружен(Знач ТекстОшибки, Знач ИмяМетода)
	Результат = Ложь;
	Если Найти(текстОшибки, "Метод объекта не обнаружен (" + ИмяМетода + ")") > 0 
		ИЛИ Найти(текстОшибки, "Object method not found (" + ИмяМетода + ")") > 0  Тогда
		Результат = Истина;
	КонецЕсли;
	
	Возврат Результат;
КонецФункции

// Универсальная функция для проверки наличия 
// свойств у значения любого типа данных
// Переменные:
// 1. Переменная - переменная любого типа, 
// для которой необходимо проверить наличие свойства
// 2. ИмяСвойства - переменная типа "Строка", 
// содержащая искомое свойства
// 
Функция ПеременнаяСодержитСвойство(Переменная, ИмяСвойства)
     // Инициализируем структуру для теста 
     // с ключом (значение переменной "ИмяСвойства") 
     // и значением произвольного GUID'а
     GUIDПроверка = Новый УникальныйИдентификатор;
     СтруктураПроверка = Новый Структура;
     СтруктураПроверка.Вставить(ИмяСвойства, GUIDПроверка);
     // Заполняем созданную структуру из переданного 
     // значения переменной
     ЗаполнитьЗначенияСвойств(СтруктураПроверка, Переменная);
     // Если значение для свойства структуры осталось 
     // NULL, то искомое свойство не найдено, 
     // и наоборот.
     Если СтруктураПроверка[ИмяСвойства] = GUIDПроверка Тогда
          Возврат Ложь;
     Иначе
          Возврат Истина;
     КонецЕсли;
КонецФункции

Процедура ЗаполнитьСвойствоПриНаличии(ОбъектЗаполнения, ИмяСвойство, ЗначениеСвойства)

	Если ПеременнаяСодержитСвойство(ОбъектЗаполнения, ИмяСвойство) Тогда
		ОбъектЗаполнения[ИмяСвойство] = ЗначениеСвойства;
	КонецЕсли;

КонецПроцедуры
// } Helpers
