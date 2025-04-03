# Southbank Noir Mobile Application

## Table of Contents
- [Overview](#overview)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Main Classes](#main-classes)

## Overview
This project is a Flutter application built with a modular architecture. It follows best practices using Bloc for state management, dependency injection with get_it, and clean separation between presentation, domain, and data layers.

---

## Tech Stack
The project uses the following technologies to support its features and functionalities:

### **Flutter SDK**
- Version: `>=3.0.5 <4.0.0`

### **Dependencies**
- `cupertino_icons: ^1.0.2`
- `go_router: ^10.0.0`
- `dio: ^5.3.0`
- `flutter_bloc: ^8.1.3`
- `equatable: ^2.0.5`
- `get_it: ^7.6.0`
- `intl: ^0.18.1`
- `retrofit: ^4.0.1`
- `flutter_hooks: ^0.19.0`
- `cached_network_image: ^3.2.3`
- `email_validator: ^2.1.17`
- `shared_preferences: ^2.2.0`
- `internet_connection_checker: ^1.0.0+1`
- `connectivity_plus: ^4.0.2`
- `carousel_slider: ^4.2.1`
- `flutter_launcher_icons: ^0.13.1`

### **Dev Dependencies**
- `flutter_test: SDK: flutter`
- `flutter_lints: ^2.0.0`
- `retrofit_generator: ^7.0.8`
- `floor_generator: ^1.4.2`
- `build_runner: ^2.4.6`

---

## Project Structure
The project is organized into the following directories:

- `lib/config` - Configuration files for routing, theming, and other global settings.
- `lib/core` - Core utilities and shared components.
- `lib/features` - Contains application features, each with its subdirectories:
  - `presentation` - UI and Bloc logic.
  - `data` - Data handling, repositories, and API calls.
  - `domain` - Business logic or use cases.
- `lib/injection_container.dart` - Dependency injection setup using `get_it`.
- `lib/main.dart` - The entry point of the application.
- `lib/main_screen.dart` - The main navigation screen.

---

## Main Classes
### **Main Classes and Their Purpose**
- `MyApp` - The root of the application. It sets up theming, routing, and manages the app state using Bloc.
- `AuthBloc` - Handles authentication state and events, such as signing in, signing out, and checking user status.
- `Router` - Defines navigation rules using `go_router`.
- `Splash`, `Main`, and `Auth` screens - Core UI screens for user navigation and interaction.
- `InjectionContainer` - Manages dependency injection to facilitate decoupling and testing.

---

### 🎯 Happy Coding!