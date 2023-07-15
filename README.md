![movie](https://github.com/rai-rajeev/movie_finder/assets/106883666/9f0432d5-0ad3-4003-9091-0aea30bd1fd9)
# Find movies - Movies Lister App
Movies Lister is a mobile application designed to help you find and discover movies easily. With Movies Lister, you can search for movies, explore popular, top-rated movies and now playing movies, and get detailed information about each movie and helps you to find movie what suits to best.
# Features
 ## Authentication features
 + Register with Email Address and password
 + Login with Email Address and password
 + Reset password
 + Remember Me feature
## Key features
+  Display Popular movies 
+  Display Top rated movies 
+ Display Now playing movies 
+  Movies search functionality
+ Movies details (including genre )
# Tech Stack
**Client:** FLutter

**Server:** Firebase

**External API Used:** TMDB API (popular, top rated, now playing and search movies, genres API endpoints).
# Screenshots


![bbbf8041-32a7-4798-b558-e0e1916daf85](https://github.com/rai-rajeev/movie_finder/assets/106883666/ff2de556-d7c3-43ee-a1b4-defc5a6d4204)


![1d0723a0-d7aa-4615-bb78-1faa07b166df](https://github.com/rai-rajeev/movie_finder/assets/106883666/3acfeef2-7065-4685-a9c1-5e07213a6f48)


![b0457fcc-02a9-4c95-b9cc-648c69cea012](https://github.com/rai-rajeev/movie_finder/assets/106883666/404fd899-7d3c-4598-b2ee-5b2f0cc92180)

# Installation
 To get started with find movies, follow these steps:
1. Ensure that you have Flutter and Dart SDK installed on your machine. For installation instructions, refer to the official [Flutter documentation](https://docs.flutter.dev/get-started/install).

1. Clone the repository:
   
    ```bash
    git clone https://github.com/rai-rajeev/movie_finder.git
    ```

2. Install the dependencies:
   ```bash
   flutter pub get
  
3. Connect a physical device or emulator.
4. Run the app:
   ```bash
   flutter run
# Download Apk
https://drive.google.com/file/d/1wm7DeEAtWgw8b83DZnGfPZgJEpLDzCQq/view?usp=sharing
# Demo
https://drive.google.com/file/d/1_s4RultAjLc6beFC38xZBIVhOv8xNieW/view?usp=sharing
# Working of the App

If you have not logged in yet, the login screen will appear, prompting you to enter your email and password to continue. If you don't have an account, there is a **signup** button located at the bottom right of the screen. Tapping on the signup button will direct you to the signup screen where you can enter your email address and create a password to complete the signup process.

On the login screen, there are additional options available. One of them is the **Forgot passwor** option, which helps you reset your password if you have forgotten it. This typically involves a password reset link being sent to your registered email address, allowing you to create a new password.

Another option is the **Remember me** checkbox, which allows you to maintain your login state within the app. Enabling this option will keep you logged in even after closing and reopening the app, so you won't have to enter your credentials every time.

Once you successfully login, you will be directed to the home screen of the app.
# Home Screen
In the user interface you described, there is a search icon on the top left corner that leads to a search screen for movies. On the top right corner, there is a pop-up menu button that includes an option to log out.

there are three horizontally scrollable lists of movies: Trending, Top Rated, and Now Playing. 
 ## Trending Movies
This list displays a collection of trending movies, showcasing their posters and names. The required data is fetched from the TMDB trending movies API endpoint. By tapping on the name of a movie in this list, the user will be directed to the movie details screen for that particular movie.
 ## Top Rated Movies
Similar to the Trending Movies list, this list contains a selection of top rated movies. The functionality remains the same, with the required data being sourced from the TMDB top rated movies API endpoint. Tapping on a movie's name in this list will also lead to the movie details screen.
 ## Now Playing
 This list showcases movies that are currently playing . It follows a similar format as the previous two lists, and the required data is retrieved from the TMDB now playing movies API endpoint. By selecting a movie's name from this list, the user will be directed to the respective movie details screen.
 
 # search movies screen
  the search movies screen features an app bar with a text field for entering search queries. When a user types something into the text field and initiates the search, the app fetches a list of related movies from the TMDB search movies API endpoint. 
  
  Upon tapping on a movie's name from the search results, the user is directed to the movie details screen
 # Movie details screen
the movie details screen provides all the relevant information about a specific movie. It includes details such as the movie's title, poster image, release date, original language, description, and other relevant information. This screen is accessed by tapping on a movie's name  from either the Trending Movies list, Top Rated Movies list, Now Playing Movies list, or the search results in the search movies screen. The data for the movie details is retrieved from the respective movie's API endpoint, such as TMDB (The Movie Database) API.
 # Author
 + [rai-rajeev](https://github.com/rai-rajeev)


