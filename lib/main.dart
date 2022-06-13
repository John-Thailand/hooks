import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final counterProvider = StateNotifierProvider((_) => Counter());

class Counter extends StateNotifier<int> {
  Counter() : super(0);
  void increment() => state++;
}

void main() {
  runApp(
    const ProviderScope(
      child: CounterApp(),
    ),
  );
}

class CounterApp extends HookConsumerWidget {
  const CounterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(counterProvider);
    final isWhiteBackGround = useState(true);

    return MaterialApp(
      home: Scaffold(
        backgroundColor: isWhiteBackGround.value ? Colors.white : Colors.black,
        appBar: AppBar(
          title: const Text('CounterApp'),
          leading: IconButton(
            onPressed: () => isWhiteBackGround.value = !isWhiteBackGround.value,
            icon: const Icon(Icons.settings),
          ),
        ),
        body: Center(
          child: Text(
            state.toString(),
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: isWhiteBackGround.value ? Colors.black : Colors.white),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => ref.read(counterProvider.notifier).increment(),
        ),
      ),
    );
  }
}
