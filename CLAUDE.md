# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter music streaming application (网抑云音乐) built with TDesign UI components and GetX state management. The app follows the GetX MVC architecture pattern with modular organization.

## Development Commands

### Standard Flutter Commands
```bash
# Install dependencies
flutter pub get

# Run in debug mode
flutter run

# Run in release mode
flutter run --release
```

### Code Generation
When modifying model classes with `@JsonSerializable()` annotations or API interfaces:
```bash
# One-time code generation
dart run build_runner build

# Clean generated files
dart run build_runner clean

# Watch for changes and auto-generate
dart run build_runner watch
```

### Build Commands
```bash
# Android APK
flutter build apk --release --obfuscate --split-debug-info=./debug_info

# Android App Bundle
flutter build appbundle --release --obfuscate --split-debug-info=./debug_info

# iOS
flutter build ios --release --obfuscate --split-debug-info=./debug_info
```

## Architecture & Code Organization

### GetX MVC Pattern
Each feature module follows the GetX convention:
- `*_page.dart` / `*_view.dart` - UI Views
- `*_controller.dart` - Business logic controllers
- `*_bindings.dart` - Dependency injection bindings

### Key Directories
- `lib/app/` - Core application setup, routing, exception handling
- `lib/core/` - Utilities, HTTP client, constants, shared services
- `lib/modules/` - Feature modules (home, login, mine, etc.)
- `lib/shared/` - Reusable widgets and APIs
- `lib/config/` - Themes and configuration

### Network Layer Architecture
The HTTP client (`lib/core/http/http.dart`) includes:
- Cookie management with persistence
- Request/response caching via interceptors
- Alice network inspector for debugging (debug mode only)
- Comprehensive logging with PrettyDioLogger
- Error handling through custom interceptors

### Main UI Structure
- PageView-based tab navigation in `lib/modules/home/home_view.dart`
- Bottom navigation with keep-alive state management
- Android back button handling (minimizes app instead of closing)

## Key Dependencies

### State Management & UI
- **GetX**: ^4.7.2 (state management, routing, DI)
- **TDesign Flutter**: ^0.2.2 (UI components by Tencent)
- **Flutter ScreenUtil**: ^5.9.3 (screen adaptation)

### Networking & Data
- **Dio**: ^5.8.1 (HTTP client)
- **JSON Annotation/Serializable**: Code generation for models
- **Alice**: Network inspector for debugging

### Development & Debugging
- **Alice**: Integrated network request inspector (debug mode)
- **Pretty Dio Logger**: Enhanced network logging
- **Flutter Lints**: Code analysis rules

## Development Guidelines

### Adding New Features
1. Create module directory under `lib/modules/`
2. Follow GetX naming conventions for files
3. Register routes in `lib/app/routes/app_pages.dart`
4. Add route constants to `lib/app/routes/app_routes.dart`

### Working with Network Requests
- Use the configured Dio instance from `lib/core/http/http.dart`
- Network requests automatically include cookie management and caching
- Alice debugger is available in debug mode for inspecting requests

### Screen Adaptation
- Use `ScreenUtil` for responsive sizing: `100.w`, `50.h`, `16.sp`
- Initialize in `main.dart` before running the app

### State Management
- Use GetX reactive variables (`.obs`) in controllers
- Access controllers via `Get.find<ControllerName>()`
- Bind controllers in `*_bindings.dart` files

## Testing

Currently no test setup exists. When adding tests:
- Create `test/` directory structure
- Add test dependencies to `pubspec.yaml`
- Follow Flutter testing conventions for unit, widget, and integration tests

## Code Generation Requirements

Run `dart run build_runner build` after:
- Adding/modifying `@JsonSerializable()` model classes
- Changes to API interface definitions
- Any modifications requiring code generation

## Common File Locations

- App entry point: `lib/main.dart`
- Main app configuration: `lib/app/app.dart`
- HTTP client setup: `lib/core/http/http.dart`
- Route definitions: `lib/app/routes/app_pages.dart`
- Home shell with tabs: `lib/modules/home/home_view.dart`
- Keep-alive widget: `lib/shared/widgets/keep_alive_widget.dart`