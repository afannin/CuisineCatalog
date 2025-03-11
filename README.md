### Summary: Include screen shots or a video of your app highlighting its features

This is a simple app that lists out recipes that are fetched from an endpoint.  Screenshots detailing some of the features are listed below:
|Sorted by name (default)|Sorted by cuisine type|Search results|No search results state|Recipe detail|Error state|
|---|---|---|---|---|---|
|![IMG_3985](https://github.com/user-attachments/assets/7a300f7c-c5dd-483d-b8e5-b97656e40dd7)|![IMG_3986](https://github.com/user-attachments/assets/f3f7eb81-c364-4bd4-825a-2bcd4bd17f3a)|![IMG_3987](https://github.com/user-attachments/assets/520bd888-0508-4b3f-97fd-bf454886bc4a)|![IMG_3988](https://github.com/user-attachments/assets/c3458b39-60c9-43a7-98ae-3d5b3052964d)|![IMG_3990](https://github.com/user-attachments/assets/4be9aaed-1844-4b54-9ea3-56d99bfc57fd)|![IMG_3991](https://github.com/user-attachments/assets/3b79c5c3-1fc7-4f76-83fe-dda088d11686)|

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

I proritized writing unit tests for the services and model layers.  Focusing on testing pointed out some things in the original code that needed to be updated.  For example, in the view model tests I was manually setting the recipes object.  However, I realized this shouldn't be able to be written to outside of the view model, so I updated the initializer to take in an object that conforms to the NetworkClient protocol so I could inject a mock in the test.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

I split development time of the project across a few days.  I'd estimate I spent around 7 hours total on the project.

I allocated the bulk of the time on a weekend to get the initial requirements finished (Creating the model, UI work, creating the network service, consuming and displaying the data).  I spent time after with some refinements (adding in caching, error states) as well as writing unit tests.

As I've been supporting older production apps, it was nice to be able to research and implement coding utilizing Swift Concurrency and the @Observable macro.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

I stuck with a simple UI.  I started to mock up some UI improvements, but wanted to prevent scope creep for the project.  Error handling is also basic, errors are logged but there are only two error states displayed to the user (no search results and no results due to malformed/empty data).

This app only supports iPhone portrait.  The list displays fine in landscape, but the sheet presentation covered the entire screen.  Due to timeboxing the projet, I just restricted orientation and disabled iPad support

### Weakest Part of the Project: What do you think is the weakest part of your project?

The UI is very simplistic in this project.  While it hits the inital requirement of displaying the data, a more refined UI would provide a better user experience.  I debated scrapping the list and changing to LazyHStacks grouped by cuisine.  However, I wanted to timebox the project so stuck with the list/sheet view to display data.  With the grid approach, the sheet could be removed as it would be easier to display all data (image, name, links).  Initially I had the links in each list item, but it looked cluttered so I added the sheet to show more details.

The caching utility is also very simple.  I've generally used SDWebImage or other 3rd party libraries to handle image caching.  There is some optimization that could be added such as flushing the cache if it grows too big or removing images that are no longer used.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.

I enjoyed working on this project and appreciate that the scope was clear in the requirements.
