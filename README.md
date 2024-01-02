# favorite_places

The Flutter application opens with a display of locally saved places. Clicking on a list item navigates to a details page. The home screen includes an icon in the app bar, allowing users to access the "Add Place" screen. On this screen, users can provide the following details:

Enter the place name manually.
Capture a photo using the camera feature.
Retrieve the current location from the map, with a preview displayed in the UI.
Choose the "Select on Map" option, and preview the selected location in the UI.
Upon clicking the "Add Place" button, the entered details are saved into Sqflite. The state management is facilitated using Riverpod.
