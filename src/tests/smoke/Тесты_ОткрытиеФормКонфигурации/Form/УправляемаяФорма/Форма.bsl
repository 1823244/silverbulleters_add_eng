﻿&НаКлиенте
Перем КонтекстЯдра;
&НаКлиенте
Перем Ожидаем;
&НаКлиенте
Перем Утверждения;

&НаКлиенте
Перем ТестируемаяФорма;

// { интерфейс тестирования

&НаКлиенте
Процедура Инициализация(КонтекстЯдраПараметр) Экспорт
	КонтекстЯдра = КонтекстЯдраПараметр;
	Утверждения = КонтекстЯдра.Плагин("БазовыеУтверждения");
	Ожидаем = КонтекстЯдра.Плагин("УтвержденияBDD");

	ПутьНастройки = "smoke";
	НачальнаяНастройка(КонтекстЯдра, ПутьНастройки);
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьНаборТестов(НаборТестов, КонтекстЯдраПараметр) Экспорт
	
	Инициализация(КонтекстЯдраПараметр);
	
	КонтекстЯдра = КонтекстЯдраПараметр;
	ОписанияТестов = Новый Массив;
	
	НужноИсключениеЕслиНеНайденоДокументов = Ложь;

	ВключенСтрогийПорядокВыполнения= ВключенСтрогийПорядокВыполнения();
	
	Если ВключенСтрогийПорядокВыполнения Тогда
		НаборТестов.СтрогийПорядокВыполнения();
		НаборТестов.ПродолжитьВыполнениеПослеПаденияТеста();
	КонецЕсли;
	
	СоздатьИменаОсновныхФорм();
	
	НастройкаГруппировки = ПолучитьНастройкуГруппировки();
	
	ТолькоУправляемыеФормы = Истина;
	#Если ТолстыйКлиентОбычноеПриложение или ТолстыйКлиентУправляемоеПриложение  Тогда
		ТолькоУправляемыеФормы = Ложь;
	#КонецЕсли
	
	Если Не ИспользоватьОбычныеФормыВТолстомКлиентеВУправляемомРежимеСервер() Тогда
		ТолькоУправляемыеФормы = Истина;
	КонецЕсли;
		
	ИменаОсновныхФорм_Объекты_Сервер = ИменаОсновныхФорм_Объекты_Сервер();
	мИменаОсновныхФорм_Списки_Сервер = мИменаОсновныхФорм_Списки_Сервер();
		
	Если НЕ ВидМетаданныхИсключенИзТестирования("Справочники") Тогда
		
		ОписанияТестов = Новый Массив;
		
		ДобавитьТестыДляСправочниковСервер(
			ОписанияТестов, ТолькоУправляемыеФормы, 
			ИменаОсновныхФорм_Объекты_Сервер, мИменаОсновныхФорм_Списки_Сервер, НастройкаГруппировки);
			
		Если ЗначениеЗаполнено(ОписанияТестов) Тогда
		
			Если НастройкаГруппировки.ГруппироватьПоВидуМетаданных Тогда
				НаборТестов.НачатьГруппу("Справочники", ВключенСтрогийПорядокВыполнения);
			КонецЕсли;
			
			ДобавитьОписанияТестовВНаборТестов(НаборТестов, ОписанияТестов, ВключенСтрогийПорядокВыполнения);

		КонецЕсли;
	КонецЕсли;
	
	Если НЕ ВидМетаданныхИсключенИзТестирования("Документы") Тогда
		
		ОписанияТестов = Новый Массив;
		
		ДобавитьТестыДляДокументовСервер(
			ОписанияТестов, ТолькоУправляемыеФормы, 
			ИменаОсновныхФорм_Объекты_Сервер, мИменаОсновныхФорм_Списки_Сервер, НастройкаГруппировки);
			
		Если ЗначениеЗаполнено(ОписанияТестов) Тогда
		
			Если НастройкаГруппировки.ГруппироватьПоВидуМетаданных Тогда
				НаборТестов.НачатьГруппу("Документы", ВключенСтрогийПорядокВыполнения);
			КонецЕсли;
			
			ДобавитьОписанияТестовВНаборТестов(НаборТестов, ОписанияТестов, ВключенСтрогийПорядокВыполнения);

		КонецЕсли;
	КонецЕсли;
	
	Если НЕ ВидМетаданныхИсключенИзТестирования("Обработки") Тогда

		ОписанияТестов = Новый Массив;
		
		ДобавлятьОбработки = Истина;
		ДобавитьТестыДляОтчетовОбработокСервер(ОписанияТестов, ТолькоУправляемыеФормы, ДобавлятьОбработки, НастройкаГруппировки);
		
		Если ЗначениеЗаполнено(ОписанияТестов) Тогда
		
			Если НастройкаГруппировки.ГруппироватьПоВидуМетаданных Тогда
				НаборТестов.НачатьГруппу("Обработки", ВключенСтрогийПорядокВыполнения);
			КонецЕсли;
			
			ДобавитьОписанияТестовВНаборТестов(НаборТестов, ОписанияТестов, ВключенСтрогийПорядокВыполнения);

		КонецЕсли;
	КонецЕсли;

	Если НЕ ВидМетаданныхИсключенИзТестирования("Отчеты") Тогда

		ОписанияТестов = Новый Массив;
		
		ДобавлятьОбработки = Ложь;
		ДобавитьТестыДляОтчетовОбработокСервер(ОписанияТестов, ТолькоУправляемыеФормы, ДобавлятьОбработки, НастройкаГруппировки);
		
		Если ЗначениеЗаполнено(ОписанияТестов) Тогда
		
			Если НастройкаГруппировки.ГруппироватьПоВидуМетаданных Тогда
				НаборТестов.НачатьГруппу("Отчеты", ВключенСтрогийПорядокВыполнения);
			КонецЕсли;
			
			ДобавитьОписанияТестовВНаборТестов(НаборТестов, ОписанияТестов, ВключенСтрогийПорядокВыполнения);
		
		КонецЕсли;
		
	КонецЕсли;

	Если НастройкаГруппировки.ГруппироватьПоВидуМетаданных Или НастройкаГруппировки.ГруппироватьПоКоличеству 
			Или НастройкаГруппировки.ГруппироватьПоВидуОбъекта Тогда
			
			НаборТестов.НачатьГруппу("Прочее", ВключенСтрогийПорядокВыполнения);
			
	КонецЕсли;

	ИмяТеста = "ТестДолжен_ПроверитьБагПлатформыПриОткрытииУправляемойФормыПриОткрытииКоторойЕстьИсключение";
	НаборТестов.Добавить(ИмяТеста, , ИмяТеста);
	
КонецПроцедуры

// } интерфейс тестирования

//{ ФормированиеСпискаТестовыхСлучаев

&НаКлиенте
Процедура ДобавитьОписанияТестовВНаборТестов(НаборТестов, ОписанияТестов, СтрогийПорядокВыполнения)
	Для Каждого Описание Из ОписанияТестов Цикл
		Если ТипЗнч(Описание) = Тип("Строка") Тогда
			
			ПредставлениеТеста = Описание;
			НаборТестов.Добавить(Описание, , ПредставлениеТеста);
			
		ИначеЕсли ТипЗнч(Описание) = Тип("Структура") И Описание.Свойство("Набор") Тогда
			НаборТестов.НачатьГруппу(Описание.Имя, СтрогийПорядокВыполнения);
			ДобавитьОписанияТестовВНаборТестов(НаборТестов, Описание.Набор, СтрогийПорядокВыполнения);
			
		Иначе

			НаборТестов.Добавить(Описание.ИмяТеста, НаборТестов.ПараметрыТеста(Описание.Параметр), 
				Описание.ПредставлениеТеста);
		КонецЕсли;
	КонецЦикла;
КонецПроцедуры

&НаСервере
Функция ДобавитьТестыДляСправочниковСервер(ОписанияТестов, ТолькоУправляемыеФормы, 
				ИменаОсновныхФорм_Объекты_Сервер, мИменаОсновныхФорм_Списки_Сервер, НастройкаГруппировки)
		
	ОсновнойОбъект = Объект();
	СписокИсключений_Существующие = ОсновнойОбъект.ПолучитьСписокИсключений_Справочники_Существующие();
	СписокИсключений_Новые = ОсновнойОбъект.ПолучитьСписокИсключений_Справочники_Новые();
	СписокИсключений_Списки = ОсновнойОбъект.ПолучитьСписокИсключений_Справочники_Списки();
	
	Счетчик = 0;
	
	менеджерМетаданного = Метаданные.Справочники;
	Для Каждого МетаОбъект Из менеджерМетаданного Цикл
		
		КоличествоЭлементовДо = ОписанияТестов.Количество();

		НаборОписанийТестов = ДобавитьГруппировкуЕслиНужно("Справочники", "Справочник." + МетаОбъект.Имя, 
			ОписанияТестов, НастройкаГруппировки, Счетчик);
		
		Если ПравоДоступа("ИнтерактивноеДобавление", МетаОбъект) Тогда
			
			ДобавитьТестыПереданныхВидовФормПоОдномОбъектуМетаданных(
				НаборОписанийТестов, 
				ОсновнойОбъект, МетаОбъект, 
				ТолькоУправляемыеФормы, 
				СписокИсключений_Новые, ИменаОсновныхФорм_Объекты_Сервер, 
				"ТестДолжен_ОткрытьФормуНовогоЭлементаСправочника", "Новые");
				
		КонецЕсли;		
		
		ДобавитьТестыПереданныхВидовФормПоОдномОбъектуМетаданных(
			НаборОписанийТестов, 
			ОсновнойОбъект, МетаОбъект, 
			ТолькоУправляемыеФормы, 
			СписокИсключений_Существующие, ИменаОсновныхФорм_Объекты_Сервер, 
			"ТестДолжен_ОткрытьФормуСуществующегоЭлементаСправочника", "Существующие");

		ДобавитьТестыПереданныхВидовФормПоОдномОбъектуМетаданных(
			НаборОписанийТестов, 
			ОсновнойОбъект, МетаОбъект, 
			ТолькоУправляемыеФормы, 
			СписокИсключений_Списки, мИменаОсновныхФорм_Списки_Сервер, 
			"ТестДолжен_ОткрытьФормуПоПолномуИмениФормы", "Списки");
			
		Если Не ЗначениеЗаполнено(НаборОписанийТестов) И ЗначениеЗаполнено(ОписанияТестов) Тогда
			Для Счетчик = КоличествоЭлементовДо По ОписанияТестов.Количество() - 1 Цикл
				ОписанияТестов.Удалить(ОписанияТестов.ВГраница());
			КонецЦикла;
		КонецЕсли; 
	КонецЦикла;
КонецФункции

Функция ДобавитьГруппировкуЕслиНужно(Знач ИмяВидаМетаданного, Знач ИмяМетаданного, 
									Знач ОписанияТестов, Знач НастройкаГруппировки, Счетчик)
		
	НаборОписанийТестов = ОписанияТестов;
	Если НастройкаГруппировки.ГруппироватьПоКоличеству Тогда
		Если Счетчик % НастройкаГруппировки.КоличествоВГруппе = 0 Тогда
			ИмяГруппы = ИмяВидаМетаданного + " (" + Строка(Счетчик + 1) + "..." + Строка(Счетчик + НастройкаГруппировки.КоличествоВГруппе) + ")";
			ОписаниеГруппы = Новый Структура("Имя, Набор", ИмяГруппы, Новый Массив);
			НаборОписанийТестов.Добавить(ОписаниеГруппы);
			НаборОписанийТестов = ОписаниеГруппы.Набор;
		КонецЕсли;
	ИначеЕсли НастройкаГруппировки.ГруппироватьПоВидуОбъекта Тогда
		ИмяГруппы = ИмяМетаданного;
		ОписаниеГруппы = Новый Структура("Имя, Набор", ИмяГруппы, Новый Массив);
		НаборОписанийТестов.Добавить(ОписаниеГруппы);
		НаборОписанийТестов = ОписаниеГруппы.Набор;
	КонецЕсли;

	Счетчик = Счетчик + 1;
	
	Возврат НаборОписанийТестов;
КонецФункции

&НаСервере
Функция ДобавитьТестыДляДокументовСервер(ОписанияТестов, ТолькоУправляемыеФормы, 
			ИменаОсновныхФорм_Объекты_Сервер, мИменаОсновныхФорм_Списки_Сервер, НастройкаГруппировки)
			
	ОсновнойОбъект = Объект();
	СписокИсключений_Существующие = ОсновнойОбъект.ПолучитьСписокИсключений_Документы_Существующие();
	СписокИсключений_Новые = ОсновнойОбъект.ПолучитьСписокИсключений_Документы_Новые();
	СписокИсключений_Списки = ОсновнойОбъект.ПолучитьСписокИсключений_Документы_Списки();
	
	Счетчик = 0;

	менеджерМетаданного = Метаданные.Документы;
	Для Каждого МетаОбъект Из менеджерМетаданного Цикл
		
		КоличествоЭлементовДо = ОписанияТестов.Количество();
		
		НаборОписанийТестов = ДобавитьГруппировкуЕслиНужно("Документы", "Документ." + МетаОбъект.Имя, 
			ОписанияТестов, НастройкаГруппировки, Счетчик);
		
		Если ПравоДоступа("ИнтерактивноеДобавление", МетаОбъект) Тогда
			имяТеста = "ТестДолжен_ОткрытьФормуНовогоДокумента";
			ПрефиксПредставленияТеста = "Новые";
			СписокИсключений = СписокИсключений_Новые;
			ИменаОсновныхФорм = ИменаОсновныхФорм_Объекты_Сервер;
			ПроверяемоеПравоДоступа = "ИнтерактивноеДобавление";
			ДобавитьТестыПереданныхВидовФормПоОдномОбъектуМетаданных(ОписанияТестов, ОсновнойОбъект, МетаОбъект, ТолькоУправляемыеФормы, СписокИсключений, ИменаОсновныхФорм, имяТеста, ПрефиксПредставленияТеста);
		КонецЕсли;		
		
		имяТеста = "ТестДолжен_ОткрытьФормуСуществующегоЭлементаДокумента";
		ПрефиксПредставленияТеста = "Существующие";
		СписокИсключений = СписокИсключений_Существующие;
		ИменаОсновныхФорм = ИменаОсновныхФорм_Объекты_Сервер;
		
		ДобавитьТестыПереданныхВидовФормПоОдномОбъектуМетаданных(ОписанияТестов, ОсновнойОбъект, МетаОбъект, ТолькоУправляемыеФормы, СписокИсключений, ИменаОсновныхФорм, имяТеста, ПрефиксПредставленияТеста);

		имяТеста = "ТестДолжен_ОткрытьФормуПоПолномуИмениФормы";
		ПрефиксПредставленияТеста = "Списки";
		СписокИсключений = СписокИсключений_Списки;
		ИменаОсновныхФорм = мИменаОсновныхФорм_Списки_Сервер;
		
		ДобавитьТестыПереданныхВидовФормПоОдномОбъектуМетаданных(ОписанияТестов, ОсновнойОбъект, МетаОбъект, ТолькоУправляемыеФормы, СписокИсключений, ИменаОсновныхФорм, имяТеста, ПрефиксПредставленияТеста);
		
		Если Не ЗначениеЗаполнено(НаборОписанийТестов) И ЗначениеЗаполнено(ОписанияТестов) Тогда
			Для Счетчик = КоличествоЭлементовДо По ОписанияТестов.Количество() - 1 Цикл
				ОписанияТестов.Удалить(ОписанияТестов.ВГраница());
			КонецЦикла;
		КонецЕсли; 
	КонецЦикла;
КонецФункции

&НаСервере
Функция ДобавитьТестыДляОтчетовОбработокСервер(ОписанияТестов, ТолькоУправляемыеФормы, Знач ДобавлятьОбработки, Знач НастройкаГруппировки)
	ОсновнойОбъект = Объект();
	
	ОписаниеВидаМетаданного = Новый Структура;
	
	ИменаОсновныхФорм = мИменаОсновныхФорм_Сервер();
	Если ДобавлятьОбработки Тогда
		
		ОписаниеВидаМетаданного.Вставить("Менеджер", Метаданные.Обработки);
		ОписаниеВидаМетаданного.Вставить("ИмяВидаМнЧисло", "Обработки");
		ОписаниеВидаМетаданного.Вставить("ИмяВидаЕдЧисло", "Обработка");
		
		ДобавитьТестыПереданныхВидовФормДляКаждогоОбъектаМенеджераМетаданных(
			ОписанияТестов, ОсновнойОбъект, ОписаниеВидаМетаданного, 
			ТолькоУправляемыеФормы, 
			ОсновнойОбъект.ПолучитьСписокИсключений_Обработки(), 
			ИменаОсновныхФорм, 
			"ТестДолжен_ОткрытьФормуПоПолномуИмениФормы", "",
			НастройкаГруппировки);
		
	Иначе

		ОписаниеВидаМетаданного.Вставить("Менеджер", Метаданные.Отчеты);
		ОписаниеВидаМетаданного.Вставить("ИмяВидаМнЧисло", "Отчеты");
		ОписаниеВидаМетаданного.Вставить("ИмяВидаЕдЧисло", "Отчет");
		
		ДобавитьТестыПереданныхВидовФормДляКаждогоОбъектаМенеджераМетаданных(
			ОписанияТестов, ОсновнойОбъект, ОписаниеВидаМетаданного, 
			ТолькоУправляемыеФормы, 
			ОсновнойОбъект.ПолучитьСписокИсключений_Отчеты(), 
			ИменаОсновныхФорм, 
			"ТестДолжен_ОткрытьФормуПоПолномуИмениФормы", "",
			НастройкаГруппировки);
		
	КонецЕсли;

КонецФункции

&НаСервере
Процедура ДобавитьТестыПереданныхВидовФормДляКаждогоОбъектаМенеджераМетаданных(
		ОписанияТестов, ОсновнойОбъект, ОписаниеВидаМетаданного, 
		ТолькоУправляемыеФормы, СписокИсключений, ИменаОсновныхФорм, имяТеста, ПрефиксПредставленияТеста, НастройкаГруппировки)
		
	Счетчик = 0;
	
	Для Каждого МетаОбъект Из ОписаниеВидаМетаданного.Менеджер Цикл
		Если ОсновнойОбъект.ЭтоУстаревшийМетаОбъектДляУдаления(МетаОбъект) Тогда
			Продолжить;
		КонецЕсли;
		Если Лев(МетаОбъект.Имя, СтрДлина("xddTestRunner")) = "xddTestRunner" Тогда
			Продолжить;
		КонецЕсли;
		
		КоличествоЭлементовДо = ОписанияТестов.Количество();
		
		НаборОписанийТестов = ДобавитьГруппировкуЕслиНужно(
			ОписаниеВидаМетаданного.ИмяВидаМнЧисло, 
			ОписаниеВидаМетаданного.ИмяВидаЕдЧисло + "." + МетаОбъект.Имя, 
			ОписанияТестов, НастройкаГруппировки, Счетчик);
		
		Добавили = ДобавитьТестыПереданныхВидовФормПоОдномОбъектуМетаданных(ОписанияТестов, ОсновнойОбъект, МетаОбъект, ТолькоУправляемыеФормы, СписокИсключений, ИменаОсновныхФорм, имяТеста, ПрефиксПредставленияТеста);
		
		Если Не Добавили Тогда
				
			Для Счетчик = КоличествоЭлементовДо По ОписанияТестов.Количество() - 1 Цикл
				ОписанияТестов.Удалить(ОписанияТестов.ВГраница());
			КонецЦикла;

		КонецЕсли; 
	КонецЦикла;
КонецПроцедуры

&НаСервере
Функция ДобавитьТестыПереданныхВидовФормПоОдномОбъектуМетаданных(ОписанияТестов, ОсновнойОбъект, МетаОбъект, 
		ТолькоУправляемыеФормы, СписокИсключений, ИменаОсновныхФорм, имяТеста, ПрефиксПредставленияТеста)
		
	Если ОсновнойОбъект.ЭтоУстаревшийМетаОбъектДляУдаления(МетаОбъект) Тогда
		Возврат Ложь;
	КонецЕсли;
		
	CписокИменМетаФорм = Новый СписокЗначений;
	Успешно = ДобавитьИменаМетаФормДляОдногоОбъектаМетаданного(CписокИменМетаФорм, ОсновнойОбъект, МетаОбъект, ТолькоУправляемыеФормы, СписокИсключений, ИменаОсновныхФорм);
	ДобавитьТестПоПереданнымМетаФормамСсылочногоОбъектаСервер(ОписанияТестов, CписокИменМетаФорм, имяТеста, ПрефиксПредставленияТеста);
	
	Возврат Успешно;
КонецФункции

&НаСервере
Процедура ДобавитьТестПоПереданнымМетаФормамСсылочногоОбъектаСервер(ОписанияТестов, CписокИменМетаФорм, имяТеста, ПрефиксПредставленияТеста)
	Для каждого Элемент Из CписокИменМетаФорм  Цикл
		МетаФорма_ПолноеИмя = Элемент.Значение;
		ПредставлениеТеста = МетаФорма_ПолноеИмя;
		Если НЕ ПустаяСтрока(ПрефиксПредставленияТеста) Тогда
			ПредставлениеТеста = ПрефиксПредставленияТеста + " : " + МетаФорма_ПолноеИмя;
		КонецЕсли;
		
		лПараметры = Новый Структура("ПредставлениеТеста,ИмяТеста,Транзакция,Параметр", ПредставлениеТеста, имяТеста, Истина, МетаФорма_ПолноеИмя);
		ОписанияТестов.Добавить(лПараметры);
	КонецЦикла;
КонецПроцедуры

&НаСервереБезКонтекста
Функция ДобавитьИменаМетаФормДляОдногоОбъектаМетаданного(CписокИменМетаФорм, ОсновнойОбъект, МетаОбъект, ТолькоУправляемыеФормы, списокИсключений, ИменаОсновныхФорм)
	Если списокИсключений.НайтиПоЗначению(МетаОбъект.Имя) <> Неопределено Тогда
		Возврат Ложь;
	КонецЕсли;
	Результат = Ложь;
	Если ПравоДоступа("Просмотр", МетаОбъект) Тогда
		МетаФормы = ОсновнойОбъект.ПолучитьМетаФормыОбъектаДляПроверки(МетаОбъект, ИменаОсновныхФорм);

		Для каждого МетаФорма Из МетаФормы Цикл

			МетаФорма_ПолноеИмя = МетаФорма.ПолноеИмя();
			Если Метаданные.ОсновнаяФормаОтчета = МетаФорма Тогда
				МетаФорма_ПолноеИмя = МетаОбъект.ПолноеИмя() + ".Форма";
			ИначеЕсли Метаданные.ОсновнаяФормаНастроекОтчета = МетаФорма Тогда
				МетаФорма_ПолноеИмя = МетаОбъект.ПолноеИмя() + ".ФормаНастроек";
			КонецЕсли;
			
			//МетаОбъект.Имя <Отчет1>, МетаФорма_ПолноеИмя <Отчет.Отчет1.Форма.УправляемаяФормаОтчета> 
			//МетаОбъект.Имя <Отчет2>, МетаФорма_ПолноеИмя <ОбщаяФорма.ФормаОтчета> // в ОФ Отчет.Отчет2.Форма

			Если ТолькоУправляемыеФормы Тогда
				Если Не ЭтоУправляемаяФорма(МетаФорма) Тогда
					Продолжить;
				КонецЕсли;
			КонецЕсли;
		
			Если СписокИсключений.НайтиПоЗначению(МетаФорма_ПолноеИмя) <> Неопределено Тогда
				Продолжить;
			КонецЕсли;
			
			CписокИменМетаФорм.Добавить(МетаФорма_ПолноеИмя);
			Результат = Истина;
		КонецЦикла;
	КонецЕсли;
	
	Возврат Результат;
КонецФункции

//}

//{ РаботаСФормами

&НаСервереБезКонтекста
Функция ИспользоватьОбычныеФормыВТолстомКлиентеВУправляемомРежимеСервер()
	Возврат Метаданные.ИспользоватьОбычныеФормыВУправляемомПриложении;
КонецФункции

&НаКлиенте
Процедура ТестироватьФорму(ПолноеИмяФормы, ПараметрыФормы) Экспорт
	Если Объект.ВыводитьСообщенияВЖурналРегистрации Тогда
		ВыполнитьЗаписьВЖурналРегистрации(ПолноеИмяФормы);
	КонецЕсли;
	
	ПредыдущиеОкна = ПолучитьОкна();
	
	Попытка
	
		// К сожалению, здесь часто исключения не ловятся https://github.com/xDrivenDevelopment/xUnitFor1C/issues/154
		
		ТестируемаяФорма = ОткрытьФорму(ПолноеИмяФормы, ПараметрыФормы,, Новый УникальныйИдентификатор);
	
	Исключение
		ИнфоОшибки = ИнформацияОбОшибке();
		
		Если Не ПропускаемОшибкуПоТекстуИсключенияСервер(ИнфоОшибки.Описание) Тогда
			ВызватьИсключение;
		КонецЕсли;
		
		Возврат;
	КонецПопытки;
	
	Если ТестируемаяФорма = Неопределено Или Не ТестируемаяФорма.Открыта() Тогда
		
		НеПроверятьФорму = ТестируемаяФорма = Неопределено;
		
		НовыеОкна = ПолучитьОкна();
		
		МассивНовыхОкон = Новый Массив;
		Для Каждого НовоеОкно Из НовыеОкна Цикл
			НашлиОкно = Ложь;
			Для Каждого ОкноДо Из ПредыдущиеОкна Цикл
				Если ОкноДо.Заголовок = НовоеОкно.Заголовок Тогда
					НашлиОкно = Истина;
					Продолжить;
				КонецЕсли;
			КонецЦикла;
			
			Если НашлиОкно Тогда
				Продолжить;
			КонецЕсли;
			
			МассивНовыхОкон.Добавить(НовоеОкно);
		КонецЦикла;

		Если МассивНовыхОкон.Количество() = 0 И НеПроверятьФорму Тогда
			Возврат;
		КонецЕсли;
		
		Если МассивНовыхОкон.Количество() > 0 Тогда
			МассивФорм = МассивНовыхОкон[0].Содержимое;
			Если МассивНовыхОкон.Количество() = 0 И НеПроверятьФорму Тогда
				Возврат;
			КонецЕсли;
			Если МассивНовыхОкон.Количество() > 0 Тогда
				ТестируемаяФорма = МассивФорм[0];
			КонецЕсли;
		КонецЕсли;
		
	КонецЕсли;
	
	//ТестируемаяФорма.Открыть(); // К сожалению здесь исключения не ловятся http://partners.v8.1c.ru/forum/thread.jsp?id=1080350#1080350
	Утверждения.Проверить(ТестируемаяФорма.Открыта(), "ТестируемаяФорма """+ПолноеИмяФормы+""" не открылась, а должна была открыться");
		
	Если ТипЗнч(ТестируемаяФорма) = Тип("УправляемаяФорма") Тогда
		ТестируемаяФорма.ОбновитьОтображениеДанных();
	Иначе
		ТестируемаяФорма.Обновить();
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ТестироватьФормуСсылочногоОбъекта(Мета_ПолноеИмя, СсылочныйОбъект)
	ПараметрыФормы = Новый Структура("Ключ", СсылочныйОбъект);
	ТестироватьФорму(Мета_ПолноеИмя, ПараметрыФормы);
КонецПроцедуры

&НаКлиенте
Процедура ЗакрытьФорму()
	Если ТипЗнч(ТестируемаяФорма) <> Тип("УправляемаяФорма") Тогда
		Возврат;
	КонецЕсли; 
	ТестируемаяФорма.Модифицированность = Ложь;
	Если ТестируемаяФорма.Открыта() Тогда
		ТестируемаяФорма.Модифицированность = Ложь;
		//Попытка
			ТестируемаяФорма.Закрыть();
		//Исключение
		//	Ошибка = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		//	ЗакрытьФормуБезусловноСОтменойТранзакции(ТестируемаяФорма);
		//	//Если ТранзакцияАктивна() Тогда
		//	//	ОтменитьТранзакцию();
		//	//КонецЕсли;
		//	//	//ДобавитьСтрокуРезультата(ИмяОперации, ИнформацияОбОшибке());
		//	//НачатьТранзакцию();
		//	//ТестируемаяФорма.УстановитьДействие("ПередЗакрытием", Неопределено);
		//	//ТестируемаяФорма.УстановитьДействие("ПриЗакрытии", Неопределено);
		//	//ТестируемаяФорма.Закрыть();
		//	ВызватьИсключение Ошибка; 			
		//КонецПопытки;
	Иначе
		Попытка
			ТестируемаяФорма.Закрыть();
		Исключение
		КонецПопытки;
	КонецЕсли;
	ТестируемаяФорма = "";

КонецПроцедуры

&НаСервере
Процедура СоздатьИменаОсновныхФорм()
	ОсновнойОбъект = Объект();
	ОсновнойОбъект.СоздатьИменаОсновныхФорм();
	ОсновнойОбъект.ВидыМетаданных = ОсновнойОбъект.ВидыМетаданных();
	ОсновнойОбъект.ВидыПроверок = ОсновнойОбъект.ВидыПроверок();
	ОсновнойОбъект.СпособыГруппировки = ОсновнойОбъект.СпособыГруппировки();
	ЗначениеВРеквизитФормы(ОсновнойОбъект, "Объект");
КонецПроцедуры

&НаСервере
Функция ИменаОсновныхФорм_Объекты_Сервер()
	Возврат Объект().мИменаОсновныхФорм_Объекты;
КонецФункции

&НаСервере
Функция мИменаОсновныхФорм_Списки_Сервер()
	Возврат Объект().мИменаОсновныхФорм_Списки;
КонецФункции

&НаСервере
Функция мИменаОсновныхФорм_Сервер()
	Возврат Объект().мИменаОсновныхФорм;
КонецФункции

&НаСервереБезКонтекста
Функция ЭтоУправляемаяФорма(МетаФорма)
	Возврат МетаФорма <> Неопределено И МетаФорма.ТипФормы = Метаданные.СвойстваОбъектов.ТипФормы.Управляемая;
КонецФункции

//}

//{ РаботаСНастройками

&НаКлиенте
Процедура НачальнаяНастройка(КонтекстЯдра, Знач ПутьНастройки)

	//Отладка(СтрШаблон("Дымовые ФлагОтладки %1", КонтекстЯдра.Объект.ФлагОтладки));
	
	ПлагинНастроек = КонтекстЯдра.Плагин("Настройки");
	Объект.Настройки = ПлагинНастроек.ПолучитьНастройку(ПутьНастройки);
	Если Не ЗначениеЗаполнено(Объект.Настройки) Тогда
		Объект.Настройки = Новый Структура;
	КонецЕсли;
	
	Если ЕстьНастройка("ВыводитьСообщенияВЖурналРегистрации", Объект.Настройки) Тогда
		Объект.ВыводитьСообщенияВЖурналРегистрации = Объект.Настройки.ВыводитьСообщенияВЖурналРегистрации;
		//Отладка(СтрШаблон("ВыводитьСообщенияВЖурналРегистрации %1", Объект.ВыводитьСообщенияВЖурналРегистрации));
	КонецЕсли;
	
	НаборНастроекПоУмолчанию = СоздатьНаборНастроекПоУмолчанию();
	
	ЗаменитьНесуществующиеНастройкиЗначениямиПоУмолчанию(Объект.Настройки, НаборНастроекПоУмолчанию);
	
КонецПроцедуры

&НаСервере
Функция СоздатьНаборНастроекПоУмолчанию() Экспорт

	Возврат Объект().СоздатьНаборНастроекПоУмолчанию();

КонецФункции // ()

&НаКлиенте
Процедура ЗаменитьНесуществующиеНастройкиЗначениямиПоУмолчанию(Знач Настройки, Знач НаборНастроекПоУмолчанию)
	
	Для каждого КлючЗначение Из НаборНастроекПоУмолчанию Цикл
		Если Не ЕстьНастройка(КлючЗначение.Ключ) Тогда
			Настройки.Вставить(КлючЗначение.Ключ, КлючЗначение.Значение);
		КонецЕсли;
	КонецЦикла;

КонецПроцедуры

// Позволяет одним вызовом получить значение из вложенных друг в друга структур
// по строке ключей, объединенных точкой. 
//
// Параметры:
//  ПутьНастроек		 - Строка	 - Путь или ключ настроек
//  СтруктураНастроек	 - Произвольный, Неопределено - полученное значение
//		( необязательно )
// 
// Возвращаемое значение:
//   Булево - Истина, если ключ/путь найден, иначе Ложь
//
// Пример: 
// 		Структура = Новый Структура("Ключ1", Новый Структура("Ключ2", Новый Структура("Ключ3", 42)));
//		РезультатПроверки = ЕстьНастройка("Ключ1.Ключ2.Ключ3", ВремЗнач);
// В результате получим ВремЗнач == 42
//
&НаКлиенте
Функция ЕстьНастройка(Знач ПутьНастроек, СтруктураНастроек = Неопределено) Экспорт
	
	Если СтруктураНастроек = Неопределено Тогда
		СтруктураНастроек = Объект.Настройки;
	КонецЕсли;

	Возврат КонтекстЯдра.Плагин("Настройки").ЕстьНастройка(ПутьНастроек, СтруктураНастроек);
	
КонецФункции

&НаКлиенте
Функция ВключенСтрогийПорядокВыполнения()
	Если ЕстьНастройка("СтрогийПорядокВыполнения", Объект.Настройки) И Объект.Настройки.СтрогийПорядокВыполнения = Ложь Тогда
		Возврат Ложь;
	КонецЕсли;
	Возврат Истина;
КонецФункции

&НаСервере
Функция ПолучитьНастройкуГруппировки()
	Возврат Объект().ПолучитьНастройкуГруппировки(Объект.Настройки);
КонецФункции

&НаКлиенте
Функция ВидМетаданныхИсключенИзТестирования(ВидМетаданных)
	Если ЕстьНастройка(ВидМетаданных) Тогда
		Возврат (ТипЗнч(Объект.Настройки[ВидМетаданных]) = Тип("Булево") И НЕ Объект.Настройки[ВидМетаданных]);
	КонецЕсли;
	Возврат Ложь;
КонецФункции

&НаСервере
Функция ПропускаемОшибкуПоТекстуИсключенияСервер(Знач ТекстИсключения) 
	Возврат Объект().ПропускаемОшибкуПоТекстуИсключения(ТекстИсключения);
КонецФункции

//}

//{ блок юнит-тестов - САМИ ТЕСТЫ

&НаКлиенте
Процедура ПередЗапускомТеста() Экспорт
	
	CоздаваемыйЭлемент = Неопределено;
	
	ОбновитьПовторноИспользуемыеЗначения();

	НужноИсключениеЕслиНеНайденоДокументов = Ложь;

	СоздатьИменаОсновныхФорм();
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗапускаТеста() Экспорт
	
	ЗакрытьФорму();
	Попытка
		УдалитьСозданныйОбъект();
	Исключение
	КонецПопытки;
КонецПроцедуры

&НаКлиенте
Процедура ТестДолжен_ПропуститьТестФормы(Знач ПричинаПропускаТеста) Экспорт
	КонтекстЯдра.ПропуститьТест(ПричинаПропускаТеста);
КонецПроцедуры

&НаКлиенте
Процедура ТестДолжен_ОткрытьФормуПоПолномуИмениФормы(ПолноеИмяФормы) Экспорт
	ТестироватьФорму(ПолноеИмяФормы, Неопределено);
КонецПроцедуры

&НаКлиенте
Процедура ТестДолжен_ОткрытьФормуСуществующегоЭлементаСправочника(Мета_ПолноеИмя) Экспорт
	СуществующийЭлемент = ПолучитьОбъектСуществующегоЭлементаСправочникаИВернутьСсылкуСервер(Мета_ПолноеИмя);
	Если ЗначениеЗаполнено(СуществующийЭлемент) Тогда
		ТестироватьФормуСсылочногоОбъекта(Мета_ПолноеИмя, СуществующийЭлемент);
	Иначе
		СоздатьЭлементИВернутьСсылкуСервер(Мета_ПолноеИмя);
		Если ЗначениеЗаполнено(CоздаваемыйЭлемент) Тогда
			ТестироватьФормуСсылочногоОбъекта(Мета_ПолноеИмя, CоздаваемыйЭлемент);	
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура СоздатьЭлементИВернутьСсылкуСервер(Мета_ПолноеИмя)
	ИД = ПолучитьВидМетаданного(Мета_ПолноеИмя);

	ОсновнойОбъект = Объект();
	CоздаваемыйЭлемент = ОсновнойОбъект.СоздатьЭлементИВернутьСсылку(ИД, "существующий");
КонецПроцедуры

&НаКлиенте
Процедура ТестДолжен_ОткрытьФормуНовогоЭлементаСправочника(Мета_ПолноеИмя) Экспорт
	ТестироватьФормуСсылочногоОбъекта(Мета_ПолноеИмя, Неопределено);
КонецПроцедуры

&НаКлиенте
Процедура ТестДолжен_ОткрытьФормуНовогоДокумента(Мета_ПолноеИмя) Экспорт
	ТестироватьФормуСсылочногоОбъекта(Мета_ПолноеИмя, Неопределено);
КонецПроцедуры

&НаКлиенте
Процедура ТестДолжен_ОткрытьФормуСуществующегоЭлементаДокумента(Мета_ПолноеИмя) Экспорт
	Док = ПолучитьСуществующийДокументОбъектИВернутьСсылкуСервер(Мета_ПолноеИмя);
	Если Док <> Неопределено Тогда
		ТестироватьФормуСсылочногоОбъекта(Мета_ПолноеИмя, Док);
	КонецЕсли;
КонецПроцедуры

&НаСервере
Функция ПолучитьСуществующийДокументОбъектИВернутьСсылкуСервер(Мета_ПолноеИмя)
	ИД = ПолучитьВидМетаданного(Мета_ПолноеИмя);
	
	ОсновнойОбъект = Объект();
	Док = ОсновнойОбъект.ПолучитьСуществующийДокументОбъектИВернутьСсылку(ИД, НужноИсключениеЕслиНеНайденоДокументов, "ТестДолжен_ОткрытьФормуСуществующегоДокумента");
	Возврат Док;
КонецФункции

&НаСервере
Функция ПолучитьОбъектСуществующегоЭлементаСправочникаИВернутьСсылкуСервер(Мета_ПолноеИмя)
	ИД = ПолучитьВидМетаданного(Мета_ПолноеИмя);
	
	ОсновнойОбъект = Объект();
	Элем = ОсновнойОбъект.ПолучитьОбъектСуществующегоЭлементаСправочникаИВернутьСсылку(ИД, Ложь, "ТестДолжен_ОткрытьФормуСуществующегоЭлементСправочника");
	Возврат Элем;
КонецФункции

// проверка бага https://github.com/xDrivenDevelopment/xUnitFor1C/issues/154
&НаКлиенте
Процедура ТестДолжен_ПроверитьБагПлатформыПриОткрытииУправляемойФормыПриОткрытииКоторойЕстьИсключение() Экспорт
	Мета_ПолноеИмя = "Обработка.ТестОбработка_Форма_ИсключениеПриОткрытии.Форма.УправляемаяФорма";
	ошибка ="";
	Попытка
		ОткрытьФорму(Мета_ПолноеИмя);
	Исключение
		ошибка = ОписаниеОшибки();
	КонецПопытки;
	Утверждения.ПроверитьЗаполненность(ошибка, "Ошибка");
КонецПроцедуры

//} 

//{ Переопределение исключений, чтобы не открывать формы.
//}

//{ ВспомогательныеМетоды

&НаСервере
Процедура УдалитьСозданныйОбъект()
	Если ЗначениеЗаполнено(CоздаваемыйЭлемент) Тогда
		CозданныйОбъект = CоздаваемыйЭлемент.ПолучитьОбъект();
		CозданныйОбъект.Удалить();
	КонецЕсли;
	CоздаваемыйЭлемент = Неопределено;
КонецПроцедуры

&НаСервере
Функция Объект()
	Возврат РеквизитФормыВЗначение("Объект");
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция ПолучитьВидМетаданного(Мета_ПолноеИмя)
	//Если ВключенаАнглийскаяЛокализация() Тогда
	//	СтрокаФорма = ".Form.";
	//Иначе
	//	СтрокаФорма = ".Форма.";
	//КонецЕсли;
		
	Поз = Найти(Мета_ПолноеИмя, ".Форма.");
	Если Поз = 0 Тогда
		Поз = Найти(Мета_ПолноеИмя, ".Form.");
	КонецЕсли; 
	ИД = Лев(Мета_ПолноеИмя, Поз - 1);
	//TODO локализация Английская - Мета_ПолноеИмя	"Catalog.ПростойСправочник.Form.УпрФормаЭлемента"	String;
	ИД = Сред(ИД, Найти(ИД, ".") + 1);
	Возврат ИД;
КонецФункции

&НаСервереБезКонтекста
Функция ИмяМетодаПропускаТестов()
	Возврат "ТестДолжен_ПропуститьТестФормы";		
КонецФункции

&НаСервере
Процедура ВыполнитьЗаписьВЖурналРегистрации(ПолноеИмяФормы)
	ЗаписьЖурналаРегистрации(Объект().Метаданные().Синоним, УровеньЖурналаРегистрации.Информация, , , "Операция: " + ПолноеИмяФормы);
КонецПроцедуры

&НаКлиенте
Процедура Отладка(Знач Сообщение)
	КонтекстЯдра.Отладка(Сообщение);
КонецПроцедуры

&НаСервереБезКонтекста
Функция ВключенаАнглийскаяЛокализация()
	ВариантВстроенногоЯзыкаАнглийский = Ложь;
	Если Metadata.ScriptVariant = Metadata.ObjectProperties.ScriptVariant.English Или
			ТекущийЯзыкСистемы() = "en" Тогда
		
		ВариантВстроенногоЯзыкаАнглийский = Истина;
	КонецЕсли; 
	
	Возврат ВариантВстроенногоЯзыкаАнглийский;
КонецФункции

//}
