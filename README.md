# ProFixer - Technician Booking App

ProFixer is a comprehensive mobile application designed to connect users with skilled technicians for various home and office repair services. The platform simplifies the process of finding, booking, and managing services provided by verified technicians in areas like plumbing, electrical work, carpentry, HVAC, and more.

## Screenshots  
Below are some screenshots of the app:  
![Screenshot]([assets/images/screenshot.png](https://github.com/shriyanshkush/ProFixer-ServiceBookingApp/tree/b937d36dbdcec1fc998808ed5bb5401cd92de8b8/App%20ScreenShots))


## Table of Contents

- [Features](#features)
- [Tech Stack](#tech-stack)
- [Project Setup](#project-setup)
- [Key Functionality](#key-functionality)
    - [User Features](#user-features)
    - [Technician Features](#technician-features)
    - [Admin Features](#admin-features)
- [Folder Structure](#folder-structure)
- [Screenshots](#screenshots)
- [Future Enhancements](#future-enhancements)
- [Contributing](#contributing)
- [License](#license)

## Features

- **User Registration & Authentication**: Users and technicians can sign up, log in, and manage their accounts.
- **Technician Profiles**: View detailed profiles of technicians, including skills, availability, ratings, and reviews.
- **Search & Filter Technicians**: Find technicians based on skills, location, and availability.
- **Real-Time Technician Availability**: Check and book technicians based on their available time slots.
- **Booking Management**: Users can view, manage, and cancel their bookings.
- **Technician Cart**: Users can add technicians to their cart for easy booking.
- **Reviews & Ratings**: Users can leave feedback and rate the service after completion.
- **Real-Time Chat**: Chat functionality to communicate with technicians before or during service.
- **Admin Dashboard**: Manage users, technicians, bookings, and platform analytics.

## Tech Stack

- **Frontend**:
    - [Flutter](https://flutter.dev/)
- **Backend**:
    - [Firebase](https://firebase.google.com/) (Firestore, Authentication, Realtime Database)
- **Cloud Functions**:
    - Serverless functions using Firebase for business logic.
- **Cloud Storage**:
    - Firebase Cloud Storage for storing profile images, reviews, etc.
- **Payment Integration**:
    - Stripe API for handling payments between users, platform, and technicians.

## Project Setup

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Firebase account](https://firebase.google.com/)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/profixer-app.git
   
2. Navigate into the project directory:
   ```bash
   cd profixer-app

3. Install Flutter dependencies:
   ```bash
   flutter pub get
   
4. Set up Firebase:
   ## 1. Create a Firebase Project

   1. Go to the [Firebase Console](https://console.firebase.google.com/).
      2. Click on "Add project" and follow the setup flow.

   ## 2. Configure Firebase for Android

   1. In the Firebase Console, select your project.
   2. Click on the Android icon to add an Android app to your project.
   3. Register your app with the package name (you can find it in `android/app/build.gradle`).
   4. Download the `google-services.json` file.
   5. Place the `google-services.json` file in the `android/app` directory of your Flutter project.
   6. Modify `android/build.gradle` to include the Google services classpath:

      ```gradle
      buildscript {
          dependencies {
              // Add this line
              classpath 'com.google.gms:google-services:4.3.15'  // Check for the latest version
          }
      }
   7. Modify android/app/build.gradle to apply the Google services plugin:
      ```bash
      apply plugin: 'com.google.gms.google-services'

   for more details:
      - Follow the [Firebase setup instructions](https://firebase.google.com/docs/flutter/setup) to connect your app to Firebase.

5. Run the app on your device or emulator:
   ```bash
   flutter run


## Key Functionality

### User Features
- **Search & Filter Technicians**: Search for technicians based on services provided (e.g., plumber, electrician).
- **Real-Time Technician Availability**: View technician availability before booking.
- **Booking History**: Users can view past and upcoming bookings.
- **Technician Reviews & Ratings**: Users can leave reviews and rate technicians after the service.
- **Cart Functionality**: Users can add technicians to their cart and book multiple services at once.
- **In-App Messaging**: Chat with technicians directly through the app.

### Technician Features
- **Service Availability Management**: Technicians can set and manage their availability by day and time.
- **Profile Customization**: Technicians can update their skills, profile picture, and service areas.
- **Booking Management**: View, accept, or reject bookings.
- **Earnings Dashboard**: Track service earnings and payments.

### Admin Features
- **Dashboard**: View and manage users, technicians, and bookings.
- **Platform Fee Management**: Set platform fees and view payment splits between technicians and the platform.
- **Service Analytics**: View statistics on service bookings, technician performance, and customer satisfaction.


## Features

- **Technician Registration**: Allows technicians to register and list their services.
- **User Booking**: Enables users to book services from technicians.
- **Admin Management**: Provides admin functionalities for managing users and technicians.

## Future Enhancements

We have some exciting features planned for the future:

- **Geolocation Tracking**: Real-time location tracking for both technicians and users.
- **Advanced Payment Options**: Integration of additional payment gateways to offer more flexibility to users.
- **Service Subscription Plans**: Introduction of subscription services for regular maintenance and repairs.
- **Push Notifications**: Real-time notifications for booking status, technician availability, and payment confirmations.

## Contributing

We welcome contributions to make ProFixer even better! Please follow these steps to contribute:

1. **Fork the Repository**: Click the "Fork" button at the top right corner of this repository.
2. **Create a New Branch**:
   ```bash
   git checkout -b feature-branch

3. **Push to the Branch**:
    ```bash
    git push origin feature-branch
    ```
4.  **Commit Your Changes**:
   ```bash
   git commit -m 'Add feature'
   ```
5.  **Create a Pull Request**: Go to the "Pull Requests" tab on GitHub and click "New Pull Request". Select your branch and provide a description of your changes.

Thank you for your interest in contributing to ProFixer!

