import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todos/views/home/home_cubit.dart';
import 'package:flutter_todos/views/home/home_page.dart';
import 'package:flutter_todos/views/home/stats/stats_page.dart';
import 'package:flutter_todos/views/home/todos_overview/todos_overview_page.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:todos_repository/todos_repository.dart';

import '../../helpers/helpers.dart';

class MockHomeCubit extends MockCubit<HomeTab> implements HomeCubit {}

void main() {
  late TodosRepository todosRepository;

  group('HomePage', () {
    setUp(() {
      todosRepository = MockTodosRepository();
      when(todosRepository.getTodos).thenAnswer((_) => const Stream.empty());
    });

    testWidgets('renders HomeView', (tester) async {
      await tester.pumpApp(
        const HomePage(),
        todosRepository: todosRepository,
      );

      expect(find.byType(HomeView), findsOneWidget);
    });
  });

  group('HomeView', () {
    const addTodoFloatingActionButtonKey = Key(
      'homeView_addTodo_floatingActionButton',
    );

    late MockNavigator navigator;
    late HomeCubit cubit;

    setUp(() {
      navigator = MockNavigator();
      when(() => navigator.canPop()).thenReturn(false);
      when(() => navigator.push<void>(any())).thenAnswer((_) async {});

      cubit = MockHomeCubit();
      when(() => cubit.state).thenReturn(HomeTab.todos);

      todosRepository = MockTodosRepository();
      when(todosRepository.getTodos).thenAnswer((_) => const Stream.empty());
    });

    Widget buildSubject() {
      return MockNavigatorProvider(
        navigator: navigator,
        child: BlocProvider.value(
          value: cubit,
          child: const HomeView(),
        ),
      );
    }

    testWidgets(
      'renders TodosOverviewPage '
      'when tab is set to HomeTab.todos',
      (tester) async {
        when(() => cubit.state).thenReturn(HomeTab.todos);

        await tester.pumpApp(
          buildSubject(),
          todosRepository: todosRepository,
        );

        expect(find.byType(TodosOverviewPage), findsOneWidget);
      },
    );

    testWidgets(
      'renders StatsPage '
      'when tab is set to HomeTab.stats',
      (tester) async {
        when(() => cubit.state).thenReturn(HomeTab.todos);

        await tester.pumpApp(
          buildSubject(),
          todosRepository: todosRepository,
        );

        expect(find.byType(StatsPage), findsOneWidget);
      },
    );

    testWidgets(
      'calls setTab with HomeTab.todos on HomeCubit '
      'when todos navigation button is pressed',
      (tester) async {
        await tester.pumpApp(
          buildSubject(),
          todosRepository: todosRepository,
        );

        await tester.tap(find.byIcon(Icons.list_rounded));

        verify(() => cubit.setTab(HomeTab.todos)).called(1);
      },
    );

    testWidgets(
      'calls setTab with HomeTab.stats on HomeCubit '
      'when stats navigation button is pressed',
      (tester) async {
        await tester.pumpApp(
          buildSubject(),
          todosRepository: todosRepository,
        );

        await tester.tap(find.byIcon(Icons.show_chart_rounded));

        verify(() => cubit.setTab(HomeTab.stats)).called(1);
      },
    );

    group('add todo floating action button', () {
      testWidgets(
        'is rendered',
        (tester) async {
          await tester.pumpApp(
            buildSubject(),
            todosRepository: todosRepository,
          );

          expect(
            find.byKey(addTodoFloatingActionButtonKey),
            findsOneWidget,
          );

          final addTodoFloatingActionButton =
              tester.widget(find.byKey(addTodoFloatingActionButtonKey));
          expect(
            addTodoFloatingActionButton,
            isA<FloatingActionButton>(),
          );
        },
      );

      testWidgets('renders add icon', (tester) async {
        await tester.pumpApp(
          buildSubject(),
          todosRepository: todosRepository,
        );

        expect(
          find.descendant(
            of: find.byKey(addTodoFloatingActionButtonKey),
            matching: find.byIcon(Icons.add),
          ),
          findsOneWidget,
        );
      });

      testWidgets(
        'navigates to the EditTodoPage when pressed',
        (tester) async {
          await tester.pumpApp(
            buildSubject(),
            todosRepository: todosRepository,
          );

          await tester.tap(find.byKey(addTodoFloatingActionButtonKey));

          verify(
            () => navigator.push<void>(any(that: isRoute<void>())),
          ).called(1);
        },
      );
    });
  });
}