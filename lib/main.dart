// Импорт основных виджетов Flutter
import 'package:flutter/material.dart';
// Импорт пакета для работы с .env файлами
import 'package:flutter_dotenv/flutter_dotenv.dart';
// Импорт пакета для локализации приложения
import 'package:flutter_localizations/flutter_localizations.dart';
// Импорт пакета для работы с провайдерами состояния
import 'package:provider/provider.dart';
// Импорт кастомного провайдера для управления состоянием чата
import 'providers/chat_provider.dart';
// Импорт провадйера для настроек API провайдера
import 'providers/settings_provider.dart' as settings_provider;
// Импорт провайдера для расходов
import 'providers/expense_provider.dart';
// Импорт основного экрана чата
import 'screens/chat_screen.dart';
// Импорт новых экранов
import 'screens/about_screen.dart';
import 'screens/tokens_screen.dart';
import 'screens/expense_chart_screen.dart';
import 'screens/settings_screen.dart';

// Определение класса главного экрана приложения
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    ChatScreen(),
    TokensScreen(),
    ExpenseChartScreen(),
    SettingsScreen(),
    AboutScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.cyan[50],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Чат',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.generating_tokens_outlined),
            label: 'Токены',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Расходы',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Настройки',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'О приложении',
          ),
        ],
      ),
    );
  }
}

// Виджет для обработки и отлова ошибок в приложении
class ErrorBoundaryWidget extends StatelessWidget {
  // Дочерний виджет, который будет обернут в обработчик ошибок
  final Widget child;

  // Конструктор с обязательным параметром child
  const ErrorBoundaryWidget({super.key, required this.child});

  // Метод построения виджета
  @override
  Widget build(BuildContext context) {
    // Используем Builder для создания нового контекста
    return Builder(
      // Функция построения виджета с обработкой ошибок
      builder: (context) {
        // Пытаемся построить дочерний виджет
        try {
          // Возвращаем дочерний виджет, если ошибок нет
          return child;
          // Ловим и обрабатываем ошибки
        } catch (error, stackTrace) {
          // Логируем ошибку в консоль
          debugPrint('Error in ErrorBoundaryWidget: $error');
          // Логируем стек вызовов для отладки
          debugPrint('Stack trace: $stackTrace');
          // Возвращаем MaterialApp с экраном ошибки
          return MaterialApp(
            // Основной экран приложения
            home: Scaffold(
              // Красный фон для экрана ошибки
              backgroundColor: Colors.red,
              // Центрируем содержимое
              body: Center(
                // Добавляем отступы
                child: Padding(
                  // Отступы 16 пикселей со всех сторон
                  padding: const EdgeInsets.all(16.0),
                  // Текст с описанием ошибки
                  child: Text(
                    // Отображаем текст ошибки
                    'Error: $error',
                    // Белый цвет текста
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

// Основная точка входа в приложение
void main() async {
  try {
    // Инициализация Flutter биндингов
    WidgetsFlutterBinding.ensureInitialized();

    // Настройка обработки ошибок Flutter
    FlutterError.onError = (FlutterErrorDetails details) {
      // Отображение ошибки
      FlutterError.presentError(details);
      // Логирование ошибки
      debugPrint('Flutter error: ${details.exception}');
      // Логирование стека вызовов
      debugPrint('Stack trace: ${details.stack}');
    };

    // Загрузка переменных окружения из .env файла
    await dotenv.load(fileName: ".env");
    // Логирование успешной загрузки
    debugPrint('Environment loaded');
    // Проверка наличия API ключа
    debugPrint('API Key present: ${dotenv.env['OPENROUTER_API_KEY'] != null}');
    // Логирование базового URL
    debugPrint('Base URL: ${dotenv.env['BASE_URL']}');

    // Запуск приложения с обработчиком ошибок
    runApp(const ErrorBoundaryWidget(child: MyApp()));
  } catch (e, stackTrace) {
    // Логирование ошибки запуска приложения
    debugPrint('Error starting app: $e');
    // Логирование стека вызовов
    debugPrint('Stack trace: $stackTrace');
    // Запуск приложения с экраном ошибки
    runApp(
      MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.red,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Error starting app: $e',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Основной виджет приложения
class MyApp extends StatelessWidget {
  // Конструктор с ключом
  const MyApp({super.key});

  // Метод построения виджета
  @override
  Widget build(BuildContext context) {
    // Используем MultiProvider для управления состоянием
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            try {
              return ChatProvider();
            } catch (e, stackTrace) {
              debugPrint('Error creating ChatProvider: $e');
              debugPrint('Stack trace: $stackTrace');
              rethrow;
            }
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            try {
              return SettingsProvider();
            } catch (e, stackTrace) {
              debugPrint('Error creating SettingsProvider: $e');
              debugPrint('Stack trace: $stackTrace');
              rethrow;
            }
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            try {
              return ExpenseProvider();
            } catch (e, stackTrace) {
              debugPrint('Error creating ExpenseProvider: $e');
              debugPrint('Stack trace: $stackTrace');
              rethrow;
            }
          },
        ),
      ],
      child: MaterialApp(
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: ScrollBehavior(),
            child: child!,
          );
        },
        title: 'AI Chat',
        debugShowCheckedModeBanner: false,
        locale: const Locale('ru', 'RU'),
        supportedLocales: const [
          Locale('ru', 'RU'),
          Locale('en', 'US'),
        ],
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xFF1E1E1E),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF262626),
            foregroundColor: Colors.white,
          ),
          dialogTheme: const DialogThemeData(
            backgroundColor: Color(0xFF333333),
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
            ),
            contentTextStyle: TextStyle(
              color: Colors.white70,
              fontSize: 16,
              fontFamily: 'Roboto',
            ),
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 16,
              color: Colors.white,
            ),
            bodyMedium: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              textStyle: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14,
              ),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              textStyle: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14,
              ),
            ),
          ),
        ),
        home: HomeScreen(),
      ),
    );
  }
}
