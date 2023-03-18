// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_string_escapes

import "package:galaxeus_lib/galaxeus_lib.dart";
import "package:universal_io/io.dart";

import "package:path/path.dart" as path_package;
import "package:yaml/yaml.dart" as yaml_package;
import "package:window_app/scheme/scheme.dart" as window_scheme;
import "package:window_app/shell/shell.dart" as window_shell;

void main(List<String> arguments) async {
  Args args = Args(arguments);
  String help_msg = "init";

  if (args.arguments.isEmpty) {
    print(help_msg);

    exit(0);
  }
  List<String> commands = [
    "help",
    "version",
    "create",
    "clean",
    // "run",
    "list_template",
    "live_server",
    "version",
    "reload",
    "github",
    "xendit",
    "env",
    "init",
  ];
  String first_args = args.arguments.first;
  if (!commands.contains(first_args.toLowerCase())) {
    print(help_msg);
    exit(0);
  }
  bool isSucces = false;
  if (first_args == "init") {
    Directory directory_current = Directory.current;

    File file = File(path_package.join(directory_current.path, "pubspec.yaml"));
    if (!file.existsSync()) {
      exit(0);
    }
    Map yaml_code = (yaml_package.loadYaml(file.readAsStringSync(), recover: true) as Map);
    window_scheme.Pubspec pubspec = window_scheme.Pubspec(yaml_code.clone());

    if (!pubspec.dependencies.rawData.containsKey("bitsdojo_window")) {
      // await window_shell.shell(
      //   executable: "dart",
      //   arguments: ["pub", "add", "bitsdojo_window"],
      //   onStdout: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
      //     stdout.add(data);
      //   },
      //   onStderr: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
      //     stderr.add(data);
      //   },
      // );
    }

    await window_shell.shell(
      executable: "flutter",
      arguments: ["create", ".", "--offline"],
      onStdout: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
        stdout.add(data);
      },
      onStderr: (data, executable, arguments, workingDirectory, environment, includeParentEnvironment, runInShell, mode) {
        stderr.add(data);
      },
    );
    // linux

    Directory directory_linux = Directory(path_package.join(directory_current.path, "linux"));
    Directory directory_windows = Directory(path_package.join(directory_current.path, "windows"));

    File file_app_linux = File(path_package.join(directory_linux.path, "my_application.cc"));
    if (file_app_linux.existsSync()) {
      String my_application_data = await file_app_linux.readAsString();
      bool is_update = false;
      if (!RegExp(RegExp.escape("#include <bitsdojo_window_linux/bitsdojo_window_plugin.h>"), caseSensitive: false).hashData(my_application_data)) {
        is_update = true;
        my_application_data = ("#include <bitsdojo_window_linux/bitsdojo_window_plugin.h>\n${my_application_data}");
      }
      if (RegExp(RegExp.escape("gtk_window_set_default_size(window, 1280, 720);"), caseSensitive: false).hashData(my_application_data)) {
        is_update = true;
        my_application_data = my_application_data.replaceAll(RegExp(RegExp.escape("gtk_window_set_default_size(window, 1280, 720);"), caseSensitive: false), """
auto bdw = bitsdojo_window_from(window);
bdw->setCustomFrame(true); 
""");
      }

      if (is_update) {
        print("update linux");
        await file_app_linux.writeAsString(my_application_data);
      }
    }

    File file_app_windows = File(path_package.join(directory_windows.path, "runner", "main.cpp"));

    if (file_app_windows.existsSync()) {
      String my_application_data = await file_app_windows.readAsString();
      bool is_update = false;

      if (!RegExp(RegExp.escape("#include <bitsdojo_window_windows/bitsdojo_window_plugin.h>"), caseSensitive: false).hashData(my_application_data)) {
        is_update = true;

        my_application_data = ("#include <bitsdojo_window_windows/bitsdojo_window_plugin.h>\nauto bdw = bitsdojo_window_configure(BDW_CUSTOM_FRAME | BDW_HIDE_ON_STARTUP);\n${my_application_data}");
      }

      if (is_update) {
        print("update windows");
        await file_app_windows.writeAsString(my_application_data);
      }
    }
    print("Succes");
    exit(0);
  }
}
