# Developer Guide - E-commerce Flutter App

Welcome to the E-commerce Flutter App repository! This document serves as the central source of truth for the project's current state, architecture, strict rules, and available features.

## 🚀 Project Overview
This project is a modern, high-performance Flutter E-commerce application. It is built utilizing **Feature-Based Architecture combined with Shared Business Logic domains** and robust State Management via **BLoC**.

---

## 🧱 Architectural Structure
The project relies on a hybrid clean architecture pattern:

```text
lib/
 ├── core/              # Shared essentials (constants, routes, theme, utils)
 │
 ├── features/          # Contains both UI-driven features and data-driven features
 │    ├── home/         # UI Feature: Drives the main product feed (Bloc, Screens, Widgets)
 │    ├── product/      # Data Feature: Shared business logic (Models, Repositories, Services, Entities)
 │    ├── auth/
 │    ├── cart/
 │    └── order/
 │
 └── main.dart          # App entry point
```

### 🧠 Core Rule: Hybrid Architecture Definition
1. **Feature = Full Screen Flow**: Like `home`, `cart`, `auth`. These folders contain `bloc`, `screens`, `widgets`.
2. **Shared Business Logic = Separate Feature**: Like `product`. Because products are shared across Cart, Home, and Order, it lives internally with `data/` and `domain/` structure, lacking UI elements to act as a pure, shared data conduit.

---

## ⚠️ Strict Rules & Development Guidelines

1. **State Management**: BLoC is mandatory. No business logic UI. UI code must strictly listen to BLoC states (`Loading`, `Loaded`, `Error`). 
2. **Data Integrity**: UI must NEVER contain hardcoded mock data. Mock data belongs isolated inside the `product/data/services/` layer until APIs are ready.
3. **Error Handling**: Follow structured try/catch handling in the `repositories` layer and emit proper `Error` states via BLoC to display to the user.
4. **Types & Immutability**: 
    - No `dynamic` typing allowed. Use explicitly typed models.
    - Use `Equatable` across all Models, Events, and States for efficient memory mapping.
5. **Version Control hygiene**: Every empty folder retains a `.gitkeep` file so Git tracks it. *Crucial:* Once a real Dart file is placed into an empty folder, the `.gitkeep` file MUST be immediately deleted.
6. **Dependency Injection Strictness**: Utilize `GetIt` as the service locator STRICTLY for isolating `Bloc` and `Repositories` injections. Do not inject components blindly or unnecessarily. Controlled injection keeps architecture scalable without becoming unmanageable.

---

## 📱 Current Features

### 1. Home (`lib/features/home`)
* **Status**: In Development (UI & Bloc Functional)
* **Description**: Handles the product listing feed for the app.
* **Implementation Details**:
  * Employs `HomeBloc` with `LoadHomeData` event.
  * Connects to `ProductRepository` for data fetching.
  * `HomeScreen` UI relies strictly on `BlocBuilder` and `BlocProvider` to trigger loads and render `ListView.builder` of `ProductCard`s.

### 2. Product (`lib/features/product`)
* **Status**: In Development (Data Layer + Domain Entity Complete)
* **Description**: Centralized Data Layer for products.
* **Implementation Details**:
  * `product_model` safely serializes/deserializes data.
  * `product_service` fetches raw JSON (currently simulated safely with `Future.delayed`).

### 3. Auth, Cart, Order 
* **Status**: Placeholder Structures Defined
