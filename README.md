# Flutter Gaming

Welcome to **Flutter Gaming**! This project is a Flutter application that contains three engaging games designed for fun and learning. Here’s a quick overview of the games and the packages used to build this app.

## Games Included

### 1. Match Images Game
In this game, the player must match pairs of images. It is a memory-based game where the player flips cards to find and match two identical images.

### 2. Word Puzzle Game
The player must form words by selecting the correct sequence of letters. Words and letters are fetched from an API.

### 3. Xylophone
This game is a classic xylophone simulation where players can explore sound and music by tapping on the xylophone bars.

## Packages Used

### 1. [http](https://pub.dev/packages/http)
- **Usage**: To fetch words and letters from the API.
- **API Endpoint "Letters"**: `https://mocki.io/v1/f6557703-eaf9-4264-9dbd-99e932166148`
- **API Endpoint "Words"**: `https://mocki.io/v1/92bff7d3-8ce3-43d9-b219-3ef090b09664`

### 2. [audioplayers](https://pub.dev/packages/audioplayers)
- **Usage**: To play audio files for the Xylophone game and any sound effects needed in other games.

### 3. [flip_card](https://pub.dev/packages/flip_card)
- **Usage**: To create flip animations for the cards in the Match Images Game.

### 4. [flutter_spinkit](https://pub.dev/packages/flutter_spinkit)
- **Usage**: To show loading indicators while fetching data or during other load times.

## Getting Started

To get started with this project, follow these steps:

1. **Clone the repository**:
    ```sh
    git clone https://github.com/HassanEssam308/flutter-gaming.git
    cd flutter_gaming
    ```

2. **Install dependencies**:
    ```sh
    flutter pub get
    ```

3. **Run the application**:
    ```sh
    flutter run
    ```

## API Usage

The Word Puzzle Game uses an API to fetch words and letters. The API endpoint :
- **Letters** `https://mocki.io/v1/f6557703-eaf9-4264-9dbd-99e932166148`
- **Words** `https://mocki.io/v1/92bff7d3-8ce3-43d9-b219-3ef090b09664`

## Demonstration Video

https://github.com/HassanEssam308/flutter-gaming/assets/121667429/008a8a78-da09-4259-8db6-6f9ba8668751

## Contact

For any inquiries or support, please contact us at hassanesam308@.gmail.com .

Enjoy playing and have fun with **Flutter Gaming**!
