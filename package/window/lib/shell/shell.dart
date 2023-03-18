// ignore_for_file: non_constant_identifier_names
 

import 'package:universal_io/io.dart';

Future<void> shell({
  required String executable,
  required List<String> arguments,
  String? workingDirectory,
  Map<String, String>? environment,
  bool includeParentEnvironment = true,
  bool runInShell = true,
  ProcessStartMode mode = ProcessStartMode.normal,
  required void Function(
    List<int> data,
    String executable,
    List<String> arguments,
    String? workingDirectory,
    Map<String, String>? environment,
    bool includeParentEnvironment,
    bool runInShell,
    ProcessStartMode mode,
  )
      onStdout,
  required void Function(
    List<int> data,
    String executable,
    List<String> arguments,
    String? workingDirectory,
    Map<String, String>? environment,
    bool includeParentEnvironment,
    bool runInShell,
    ProcessStartMode mode,
  )
      onStderr,
}) async {
  bool is_complete = false;
  Process shell = await Process.start(
    executable,
    arguments,
    workingDirectory: workingDirectory,
    environment: environment,
    includeParentEnvironment: includeParentEnvironment,
    runInShell: runInShell,
    mode: mode,
  );

  var stdout_shell = shell.stdout.listen(
    (List<int> data) {
      onStdout(data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode);
    },
    onDone: () { 
      is_complete = true;
    },
    cancelOnError: true,
  );
  var stderr_shell = shell.stderr.listen(
    (List<int> data) {
      onStderr(data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode);
    },
    onDone: () { 
      is_complete = true;
    },
    cancelOnError: true,
  );

  while (true) {
    await Future.delayed(Duration(milliseconds: 1));

    if (is_complete) {
      await Future.delayed(Duration(milliseconds: 500));
      // await stdin_shell.cancel();
      await stdout_shell.cancel();

      await Future.delayed(Duration(milliseconds: 500));
      await stderr_shell.cancel();

      await Future.delayed(Duration(milliseconds: 500));
      shell.kill(ProcessSignal.sigkill);
      return;
    }
  }
}
