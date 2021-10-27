
# Shortly Code Challenge

Example:

![](https://github.com/thekavak/codeChallenge/blob/main/challengeapp/assets/intro1.gif)



- First, I created the folder structure. 
  - Constant
  - Core
  - Common
  - Model
  - Service
  - Network
  - Widgets.

- **application_constant.dart:** It contains the api url.
- **string_values.dart:** I added all the strings and svg paths I will use in it.
- **styles.dart:** I created a class 'abstract class ThemeText' in it and placed my application's color and textStyle here.

- **api_model.dart:** I modeled the response that will come from the API.
- **network_manager.dart:** I have an api request function.

- **detail_view.dart:** My history list page, I also keep a temporary list of shortened links and listed them on this page. From this page, I can request and query again, copy or delete what I have previously query.

- **home_view.dart:** in my app home page i am reading 2 data from local json so that my list is not empty at the top. I am checking if the value entered in **isValueUrl()** is url and not empty.

	If the textField is full and true I'm sending it to the **shortenUrl()** function. Here is the loading animation that covers the whole page at the beginning. I'm waiting for a response from the API. I've added error messages in case something unexpected happens. After the data comes and reads correctly, I send it to the detail page.

- **Widgets/button_bottom.dart:** I created the box area where I wrote the url, which is on both pages and comes right above it when the keyboard is opened. By creating a controller, I used the same widget on both my pages.

- **Widgets/button_short.dart:** The button_bottom.dart contains the 'Shorten' button that I use.
