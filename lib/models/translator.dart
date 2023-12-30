import 'package:get/get.dart';

class Translator extends Translations {
  //main - search Bar - Tab Bar
  static const tabNotes = 'TabNotes';
  static const tabTodos = 'TabTodos';
  static const tabFavorites = 'TabFavorites';
  static const tabSettings = 'TabSettings';
  static const noteAppBar = 'NoteAppBar';
  static const todoAppBar = 'TodoAppBar';
  static const favoriteAppBar = 'FavoriteAppBar';
  static const settingAppBar = 'SettingAppBar';
  static const searchTabNote = 'SearchTabNote';
  static const searchTabTodo = 'SearchTabTodo';
  static const searchTabFavorite = 'SearchTabFavorite';

  // Add Note Bottom Sheet
  static const addNoteText1 = 'AddNoteText1';
  static const addNoteText2 = 'AddNoteText2';
  static const addNoteText3 = 'AddNoteText3';
  static const addNoteText4 = 'AddNoteText4';
  static const addNoteText5 = 'AddNoteText5';
  static const addNoteText6 = 'AddNoteText6';
  static const addNoteText7 = 'AddNoteText7';

  // Colors
  static const color1 = 'Color1';
  static const color2 = 'Color2';
  static const color3 = 'Color3';
  static const color4 = 'Color4';
  static const color5 = 'Color5';
  static const color6 = 'Color6';
  static const color7 = 'Color7';
  static const color8 = 'Color8';
  static const color9 = 'Color9';
  static const color10 = 'Color10';
  static const color11 = 'Color11';
  static const color12 = 'Color12';
  static const color13 = 'Color13';
  static const color14 = 'Color14';
  static const color15 = 'Color15';
  static const color16 = 'Color16';
  static const color17 = 'Color17';
  static const color18 = 'Color18';
  static const color19 = 'Color19';
  static const color20 = 'Color20';
  static const color21 = 'Color21';
  static const color22 = 'Color22';
  static const color23 = 'Color23';
  static const color24 = 'Color24';
  static const color25 = 'Color25';
  static const color26 = 'Color26';
  static const color27 = 'Color27';
  static const color28 = 'Color28';
  static const color29 = 'Color29';
  static const color30 = 'Color30';
  static const color31 = 'Color31';
  static const color32 = 'Color32';
  static const color33 = 'Color33';
  static const color34 = 'Color34';
  static const color35 = 'Color35';
  static const color36 = 'Color36';
  static const color37 = 'Color37';
  static const color38 = 'Color38';
  static const color39 = 'Color39';
  static const color40 = 'Color40';
  static const color41 = 'Color41';
  static const color42 = 'Color42';
  static const color43 = 'Color43';
  static const color44 = 'Color44';
  static const color45 = 'Color45';
  static const color46 = 'Color46';
  static const color47 = 'Color47';
  static const color48 = 'Color48';
  static const color49 = 'Color49';

  //Settings Screen
  static const settingsText1 = 'SettingsText1';
  static const settingsText2 = 'SettingsText2';
  static const settingsText3 = 'SettingsText3';
  static const settingsText4 = 'SettingsText4';
  static const settingsText5 = 'SettingsText5';
  static const settingsText6 = 'SettingsText6';
  static const settingsText7 = 'SettingsText7';
  static const settingsText8 = 'SettingsText8';
  static const settingsText9 = 'SettingsText9';
  static const settingsText10 = 'SettingsText10';
  static const settingsText11 = 'SettingsText11';
  static const settingsText12 = 'SettingsText12';
  static const settingsText13 = 'SettingsText13';
  static const settingsText14 = 'SettingsText14';
  static const settingsText15 = 'SettingsText15';
  static const settingsText16 = 'SettingsText16';
  static const settingsText17 = 'SettingsText17';
  static const settingsText18 = 'SettingsText18';
  static const settingsText19 = 'SettingsText19';
  static const settingsText20 = 'SettingsText20';

  // Todos Screen
  static const todoText1 = 'TodosText1';
  static const todoText2 = 'TodosText2';
  static const todoText3 = 'TodosText3';
  static const todoText4 = 'TodosText4';
  static const todoText5 = 'TodosText5';
  static const todoText6 = 'TodosText6';
  static const todoText7 = 'TodosText7';
  static const todoText8 = 'TodosText8';
  static const todoText9 = 'TodosText9';
  static const todoText10 = 'TodosText10';
  static const todoText11 = 'todoText11';
  static const todoText12 = 'todoText12';
  static const todoText13 = 'todoText13';
  static const todoText14 = 'todoText14';
  static const todoText15 = 'todoText15';
  static const todoText16 = 'todoText16';
  static const todoText17 = 'todoText17';
  static const todoText18 = 'todoText18';
  static const todoText19 = 'todoText19';
  static const todoText20 = 'todoText20';
  static const todoText21 = 'todoText21';
  static const todoText22 = 'todoText22';

  //Calender Screen
  static const calenderText1 = 'calenderText1';
  static const calenderText2 = 'calenderText2';
  static const calenderText3 = 'calenderText3';
  static const calenderText4 = 'calenderText4';
  static const calenderText5 = 'calenderText5';
  static const calenderText6 = 'calenderText6';
  static const calenderText7 = 'calenderText7';
  static const calenderText8 = 'calenderText8';

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          tabNotes: 'Notes',
          tabTodos: 'To Dos',
          tabFavorites: 'Favorites',
          tabSettings: 'Settings',
          noteAppBar: 'Notes',
          todoAppBar: 'To Dos',
          favoriteAppBar: 'Favorites',
          settingAppBar: 'Settings',
          searchTabNote: 'Search in notes',
          searchTabTodo: 'Search in to-dos',
          searchTabFavorite: 'Search in favorites',
          addNoteText1: 'Enter title',
          addNoteText2: 'Select color notes :',
          addNoteText3: 'Tags :',
          addNoteText4: 'Enter tag',
          addNoteText5: 'Create Note',
          addNoteText6: 'Cancel',
          addNoteText7: 'Select Color',
          color1: 'Yellow gold',
          color2: 'Gold',
          color3: 'Orange bright',
          color4: 'Orange dark',
          color5: 'Rust',
          color6: 'Pale rust',
          color7: 'Brick red',
          color8: 'Mod red',
          color9: 'Pale red',
          color10: 'Red',
          color11: 'Rose bright',
          color12: 'Rose',
          color13: 'Plum light',
          color14: 'Plum',
          color15: 'Orchid light',
          color16: 'Orchid',
          color17: 'Default blue',
          color18: 'Navy blue',
          color19: 'Purple shadow',
          color20: 'Purple shadow dark',
          color21: 'Iris pastel',
          color22: 'Iris Spring',
          color23: 'Violet red light',
          color24: 'Violet red',
          color25: 'Cool blue bright',
          color26: 'Coll blue',
          color27: 'Seafoam',
          color28: 'Seafoam teal',
          color29: 'Mint light',
          color30: 'Mint dark',
          color31: 'Turf green',
          color32: 'Sport green',
          color33: 'Gray',
          color34: 'Gray brown',
          color35: 'Steel blue',
          color36: 'Metal blue',
          color37: 'Pale moss',
          color38: 'Moss',
          color39: 'Meadow green',
          color40: 'Green',
          color41: 'Overcast',
          color42: 'Storm',
          color43: 'Blue gray',
          color44: 'Gray dark',
          color45: 'Liddy green',
          color46: 'Sage',
          color47: 'Camouflage desert',
          color48: 'Camouflage',
          color49: 'White',
          // Settings Screen
          settingsText1: 'Theme',
          settingsText2: 'Light',
          settingsText3: 'Dark',
          settingsText4: 'System',
          // List Titles
          settingsText5: 'Lock',
          settingsText6: 'Date format',
          settingsText7: 'Language',
          settingsText8: 'Trash',
          settingsText9: 'Archive',
          settingsText10: 'Version',
          settingsText11: 'Exit',
          settingsText12: 'Change date format',
          settingsText13: 'Save',
          settingsText14: 'AD date',
          settingsText15: 'Solar date',
          settingsText16: 'Change language',
          settingsText17: 'You go out',
          settingsText18: 'Do you really want to exit the program?',
          settingsText19: 'Exit',
          settingsText20: '',

          //Todos Screen
          todoText1: 'Add new to-do',
          todoText2: 'Enter title',
          todoText3: 'Enter description',
          todoText4: 'Priority :',
          todoText5: 'Low',
          todoText6: 'Normal',
          todoText7: 'High',
          todoText8: 'Create todo',
          todoText9: 'Delete this todo',
          todoText10: 'Description :',
          todoText11: 'Done',
          todoText12: 'Undone',
          todoText13: "You don’t have any to-dos yet.",
          todoText14: 'No results found',
          todoText15: 'Delete todo',
          todoText16: 'Todo was successfully deleted',
          todoText17: 'Todo',
          todoText18: 'Repetitive todo',
          todoText19: 'This todo has already been added',
          todoText20: 'Please enter the title of the todo',
          todoText21: 'This category has already been added',
          todoText22: 'Please enter the title of the category',

          //Calender Screen
          calenderText1: 'You don’t have any to-dos on this date',
          calenderText2: 'You don’t have any notes on this date',
          calenderText3: 'Notes',
          calenderText4: 'To-dos',
        },
        'fa_IR': {
          tabNotes: 'یادداشت ها',
          tabTodos: 'تودو ها',
          tabFavorites: 'علاقه مندی ها',
          tabSettings: 'تنظیمات',
          noteAppBar: 'یادداشت ها',
          todoAppBar: 'تودو ها',
          favoriteAppBar: 'علاقه مندی ها',
          settingAppBar: 'تنظیمات',
          searchTabNote: 'جستجو در یادداشت ها',
          searchTabTodo: 'جستجو در تودو ها',
          searchTabFavorite: 'جستجو در علاقه مندی ها',
          addNoteText1: 'عنوان را وارد کنید',
          addNoteText2: 'رنگ یادداشت را انتخاب کنید :',
          addNoteText3: 'تگ ها :',
          addNoteText4: 'تگ خود را وارد کنید',
          addNoteText5: 'ایجاد یادداشت',
          addNoteText6: 'انصراف',
          addNoteText7: 'انتخاب رنگ',
          color1: 'زرد طلایی',
          color2: 'طلایی',
          color3: 'نارنجی روشن',
          color4: 'نارنجی تیره',
          color5: 'زنگ زدگی',
          color6: 'زنگ زدگی کم رنگ',
          color7: 'قرمز آجری',
          color8: 'مد قرمز',
          color9: 'قرمز کم رنگ',
          color10: 'قرمز',
          color11: 'رز روشن',
          color12: 'رز',
          color13: 'آلو روشن',
          color14: 'آلو',
          color15: 'ارکیده روشن',
          color16: 'ارکیده',
          color17: 'آبی پیش فرض',
          color18: 'بی سرمه ای',
          color19: 'سایه بنفش',
          color20: 'سایه بنفش تیره',
          color21: 'پاستیل زنبق',
          color22: 'بهار زنبق',
          color23: 'قرمز بنفش روشن',
          color24: 'قرمز بنفش',
          color25: 'بی سرد روشن',
          color26: 'گل آبی',
          color27: 'فوم دریایی',
          color28: 'کف دریایی',
          color29: 'نعنا روشن',
          color30: 'نعنایی تیره',
          color31: 'سبز چمنی',
          color32: 'سبز ورزشی',
          color33: 'خاکستری',
          color34: 'قهوه ای خاکستری',
          color35: 'آبی فولادی',
          color36: 'آبی فلزی',
          color37: 'خزه کم رنگ',
          color38: 'خزه',
          color39: 'سبز علفزار',
          color40: 'سبز',
          color41: 'ابری',
          color42: 'طوفان',
          color43: 'آبی خاکستری',
          color44: 'خاکستری تیره',
          color45: 'سبز لیدی',
          color46: 'مریم گلی',
          color47: 'کویر استتار',
          color48: 'استتار',
          color49: 'سفید',
          settingsText1: 'تم',
          settingsText2: 'روشن',
          settingsText3: 'تاریک',
          settingsText4: 'سیستم',
          // List Titles
          settingsText5: 'قفل',
          settingsText6: 'فرمت تاریخ',
          settingsText7: 'زبان',
          settingsText8: 'سطح زباله',
          settingsText9: 'آرشیو',
          settingsText10: 'ورژن',
          settingsText11: 'خروج',
          settingsText12: 'تغییر فرمت تاریخ',
          settingsText13: 'ذخیره',
          settingsText14: 'میلادی',
          settingsText15: 'شمسی',
          settingsText16: 'تغییر زبان',
          settingsText17: 'خارج میشود',
          settingsText18: 'آیا واقعا میخواهید از برنامه خارج شوید؟',
          settingsText19: 'خروج',
          settingsText20: '',

          //Todos Screen
          todoText1: 'اضافه کردن تودو جدید',
          todoText2: 'عنوان را وارد کنید',
          todoText3: 'توضیحات را وارد کنید',
          todoText4: 'اولویت',
          todoText5: 'کم',
          todoText6: 'نرمال',
          todoText7: 'زیاد',
          todoText8: 'ایجاد تودو',
          todoText9: 'حذف این تودو',
          todoText10: 'توضیحات :',
          todoText11: 'انجام شد',
          todoText12: 'انجام نشد',
          todoText13: 'هنوز تودو ای ندارید',
          todoText14: 'نتیجه ای پیدا نشد',
          todoText15: 'حذف تودو',
          todoText16: 'تودو با موفقعیت حذف شد',
          todoText17: 'تودو',
          todoText18: 'تودو تکراری',
          todoText19: 'این تودو قبلا اضافه شده',
          todoText20: 'لطفا عنوان تودو را وارد کنید',
          todoText21: 'این دسته بندی قبلا اضافه شده',
          todoText22: 'لطفا عنوان دیته بندی را وارد کنید',

          //Calender Screen
          calenderText1: 'شما در این تاریخ تودو ای ندارید',
          calenderText2: 'شما در این تاریخ یادداشتی ندارید',
          calenderText3: 'یادداشت ها',
          calenderText4: 'تو دو ها',
        }
      };
}
