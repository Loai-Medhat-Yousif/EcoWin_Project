@echo off
"D:\\FlutterEnvironment\\SDK\\cmake\\3.22.1\\bin\\cmake.exe" ^
  "-HC:\\Users\\Loai Medhat\\AppData\\Local\\Pub\\Cache\\hosted\\pub.dev\\rive_common-0.4.15\\android" ^
  "-DCMAKE_SYSTEM_NAME=Android" ^
  "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON" ^
  "-DCMAKE_SYSTEM_VERSION=19" ^
  "-DANDROID_PLATFORM=android-19" ^
  "-DANDROID_ABI=x86_64" ^
  "-DCMAKE_ANDROID_ARCH_ABI=x86_64" ^
  "-DANDROID_NDK=D:\\FlutterEnvironment\\SDK\\ndk\\25.1.8937393" ^
  "-DCMAKE_ANDROID_NDK=D:\\FlutterEnvironment\\SDK\\ndk\\25.1.8937393" ^
  "-DCMAKE_TOOLCHAIN_FILE=D:\\FlutterEnvironment\\SDK\\ndk\\25.1.8937393\\build\\cmake\\android.toolchain.cmake" ^
  "-DCMAKE_MAKE_PROGRAM=D:\\FlutterEnvironment\\SDK\\cmake\\3.22.1\\bin\\ninja.exe" ^
  "-DCMAKE_LIBRARY_OUTPUT_DIRECTORY=D:\\Projects\\Eco Win\\ecowin\\build\\rive_common\\intermediates\\cxx\\RelWithDebInfo\\6a2ls6m3\\obj\\x86_64" ^
  "-DCMAKE_RUNTIME_OUTPUT_DIRECTORY=D:\\Projects\\Eco Win\\ecowin\\build\\rive_common\\intermediates\\cxx\\RelWithDebInfo\\6a2ls6m3\\obj\\x86_64" ^
  "-DCMAKE_BUILD_TYPE=RelWithDebInfo" ^
  "-BC:\\Users\\Loai Medhat\\AppData\\Local\\Pub\\Cache\\hosted\\pub.dev\\rive_common-0.4.15\\android\\.cxx\\RelWithDebInfo\\6a2ls6m3\\x86_64" ^
  -GNinja
