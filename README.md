# Flappy Dash (Flappy Bird Clone with custom engine)

This game is a Flappy Bird clone made just for fun. It’s built using a custom engine because I enjoy it and it’s a great way to gain valuable experience. Not for publish in play store or app store.

## Getting Started 🧭

This project is built with **Flutter**, ensuring versatility and compatibility with multiple operating systems. Follow the steps below to run the app:

1. Make sure Flutter is installed on your system. You can download it from [flutter.dev](https://flutter.dev).
    1. Flutter SDK 3.24.4
    2. Dart SDK 3.5.4
2. Clone the project repository to your local machine.
3. Before running the app, open a terminal in the project folder and execute the following command:
    ```bash
    flutter pub get
    ```
    This will install all necessary dependencies for the project.
4. Run the app with (dont forget use an emulator or physical device):
    ```bash
    flutter run
    ```

### Disclaimers

-   This is my second intent to create my own game engine only for fun. I added a Loader View only to
    learn how to load assets and separation of concerns. That's why i add a delayed in assets manager
-   The physics is not the same as the original game
-   I add a loading screen, only for testing purpose

### Ice Box

This is some features i could add in some moment of my live

-   Every three jump/flap play a sfx sound
-   Give GameState attr to gameobjects is a bad idea.
-   More songs and sfx audios
-   Pause/Play action

## License

This project is licensed under [CC BY-NC 4.0](http://creativecommons.org/licenses/by-nc/4.0/).  
You are free to use and adapt this code **for non-commercial purposes only**.  
Publishing this game or derivative works on commercial platforms like Google Play or App Store is **not allowed**.
