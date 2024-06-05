# Metuverse - Social Media Application for Campus Students

Welcome to the Metuverse project! This repository contains the source code and documentation for the Metuverse social media application, designed specifically for university students residing on and around campus.

## Introduction
Metuverse is a social media platform developed to meet the unique needs of university students. It provides a safe, convenient, and efficient platform for students to trade goods, find sports buddies, discuss social issues, and help each other with transportation.

## Features
- **User Registration and Verification**: Secure registration using school emails with a confirmation code.
- **Recommendation System**: Personalized suggestions based on users' search history and favorited items.
- **Transportation Service**: Coordinate transportation needs with other students.
- **Buy and Sell Service**: Marketplace for students to buy, sell, or give away items.
- **Sports Friend Service**: Find fitness enthusiasts and organize games or training sessions.
- **Profile Management**: View and manage personal information and settings.
- **External Communication**: Integration with WhatsApp for direct messaging.
- **User Notifications**: Timely notifications based on user interests.

## Tech Stack
### Frontend
- **Framework**: Flutter
- **Language**: Dart
- **Packages**:
  - `flutter_bloc`: State management using BLoC pattern
  - `http`: HTTP requests
  - `shared_preferences`: Persistent storage
  - `provider`: State management
  - `flutter_local_notifications`: Local notifications

### Backend
- **Language**: PHP
- **Framework**: Custom MVC
- **Database**: MySQL
- **Packages**:
  - `phpmailer/phpmailer`: Email handling
  - `firebase/php-jwt`: JWT token handling for authentication

### Tokens
- **Public Token**: Used for allowing users to reach each other without exposing their actual user ID. This token is persistent.
- **Private Token**: Used for system authentication to ensure that incoming API calls are from the legitimate user. This token is updated with each login and is stored securely on the user's device.

## Installation
To install and run Metuverse locally, follow these steps:

### Prerequisites
- [Flutter](https://flutter.dev/docs/get-started/install)
- [Dart](https://dart.dev/get-dart)
- [MySQL](https://www.mysql.com/downloads/)
- [PHP](https://www.php.net/downloads)
- [Composer](https://getcomposer.org/)

### Clone the Repository
```bash
git clone https://github.com/your-username/metuverse.git
cd metuverse
```

### Set Up Backend
1. Configure your MySQL database.
2. Update the database configuration in `backend/config.php`.
3. Install PHP dependencies:
   ```bash
   cd backend
   composer install
   ```
4. Run the backend services:
   ```bash
   php -S localhost:8000 -t backend
   ```

### Set Up Frontend
1. Navigate to the frontend directory:
   ```bash
   cd frontend
   ```
2. Install Flutter dependencies:
   ```bash
   flutter pub get
   ```
3. Run the Flutter application:
   ```bash
   flutter run
   ```

## Usage
After setting up the project, you can start using the Metuverse app. The app provides functionalities like user registration, post creation, searching and filtering posts, managing profiles, and more.

## Architecture
Metuverse is designed with a modular architecture, utilizing Flutter for the frontend and PHP/MySQL for the backend. The backend services are RESTful APIs that interact with the MySQL database to handle data operations. The frontend communicates with these APIs to provide a seamless user experience.

### Key Components
- **User Management**: Handles user registration, login, and profile management.
- **Post Management**: Manages the creation, modification, and deletion of posts.
- **Recommendation System**: Provides personalized recommendations based on user interests.
- **Notification System**: Sends timely notifications to users.

## Contributing
We welcome contributions to Metuverse! To contribute, follow these steps:

1. Fork the repository.
2. Create a new branch for your feature or bugfix.
3. Commit your changes and push to your branch.
4. Open a pull request and describe your changes.


## Acknowledgements
This project was developed by Batuhan Sandıkcı, Burak Eken, Ege Erdem, and Yavuz Erbaş . 
