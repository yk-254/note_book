📒 Note Management App

A Flutter application for managing categorized notes using Clean Architecture and GetX.

🚀 Overview

The Note Management App allows users to create, edit, delete, and categorize their personal notes. It follows a modular Clean Architecture, using GetX for state management, dependency injection, and routing.

The project demonstrates clean code structure, separation of concerns, local persistence, reusable widgets, and scalable architecture suitable for real-world applications.

🎯 Features

✔ Add new notes (title + content)
✔ Edit & delete existing notes
✔ Categorize notes (Personal, Work, University, etc.)
✔ Filter by categories
✔ Update note status (Draft / Completed)
✔ Local storage using GetStorage
✔ Clean Architecture (domain/data/presentation layers)
✔ Unit tests for logic and use-cases
✔ Simple, clean, and user-friendly UI

📱 Screens

Home Page – List of categories

Notes Page – Notes of selected category

Note Editor – Create or edit a note

Status Support – Draft / Completed

🧱 Project Architecture (Clean Architecture)
lib/
 ├── core/
 │    ├── constants/
 │    ├── errors/
 │    └── utils/
 ├── data/
 │    ├── datasources/
 │    ├── models/
 │    └── repositories/
 ├── domain/
 │    ├── entities/
 │    ├── repositories/
 │    └── usecases/
 └── presentation/
      ├── controllers/
      ├── pages/
      └── widgets/

Why Clean Architecture?

High scalability

Easy maintainability

Test-friendly structure

Clear separation of UI, logic, and data handling

🧰 Technologies Used
Component	Technology
Framework	Flutter (Dart)
State Management	GetX
Routing	GetX Navigation
Local Storage	GetStorage
Architecture	Clean Architecture
Testing	Flutter Test + Mocktail
📦 Installation & Setup
1. Clone the repository
git clone https://github.com/your-username/note-management-app.git
cd note-management-app

2. Install dependencies
flutter pub get

3. Run the app
flutter run

4. Build APK
flutter build apk --release


APK output location:

build/app/outputs/flutter-apk/app-release.apk

🗄️ Local Storage Structure (GetStorage)

Notes are stored as JSON inside a GetStorage box:

[
  {
    "id": "abc123",
    "title": "Shopping List",
    "content": "Buy milk, bread...",
    "category": "Personal",
    "status": "draft"
  }
]

🧪 Unit Tests

Sample tests included:

Use cases

Repositories

Controllers

Run tests:

flutter test

🛠️ Folder Details
data/

models/ – Data models (DTOs)

datasources/ – Local storage logic (GetStorage)

repositories/ – Implementation of domain repositories

domain/

entities/ – Pure data objects

repositories/ – Abstract contracts

usecases/ – Business logic

presentation/

controllers/ – GetX controllers

pages/ – UI screens

widgets/ – Reusable UI components

📘 Example Flow (Adding a Note)

User taps Add Note

UI sends data → Controller

Controller calls AddNoteUseCase

UseCase calls Repository

Repository saves note in GetStorage

UI updates automatically via GetX reactivity
