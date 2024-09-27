# Image Storage App

## Overview

The Image Storage App is a Flutter application that allows users to upload, view, and delete images using Firebase Storage. This app provides a simple and intuitive interface for managing your images.

## Features

- Upload images from your device's gallery
- View uploaded images in a scrollable list
- Delete images from storage
- Real-time updates of upload status

## Prerequisites

Before you begin, ensure you have met the following requirements:

- Flutter SDK (latest stable version)
- Dart SDK (latest stable version)
- Firebase account and project set up
- Android Studio / VS Code with Flutter plugins installed

## Getting Started

To get this project up and running on your local machine, follow these steps:

1. Clone the repository:

   ```
   git clone https://github.com/damooola/image-storage-app.git
   ```

2. Navigate to the project directory:

   ```
   cd image-storage-app
   ```

3. Install dependencies:

   ```
   flutter pub get
   ```

4. Set up Firebase:
   - Create a new Firebase project in the [Firebase Console](https://console.firebase.google.com/)
   - Follow Firebase's [Flutter setup guide](https://firebase.google.com/docs/flutter/setup) to initialize Firebase in your app

5. Run the app:

   ```
   flutter run
   ```

## Project Structure

The main components of the app are:

- `home_page.dart`: The main screen of the app, displaying the list of images and upload button
- `image_post.dart`: A widget for displaying individual images with a delete option
- `storage_service.dart`: A service class that handles interactions with Firebase Storage

## Dependencies

This project uses the following main dependencies:

- `firebase_core`: For Firebase initialization
- `firebase_storage`: For interacting with Firebase Storage
- `provider`: For state management
- `image_picker`: For selecting images from the device gallery

## Contributing

Contributions to the Image Storage App are welcome. Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [MIT License File](LICENSE) for details.

## Contact

If you have any questions or feedback, please open an issue in the GitHub repository.
