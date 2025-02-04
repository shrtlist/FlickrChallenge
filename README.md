Coding challenge for an iPhone application that allows a user to search Flickr for images.

Create the UI with a search bar at the top and a grid below it to display thumbnail images.
The user should be able to enter text into the search bar and see a grid of images whose tags match
the search string.
The search string can be a single word (such as “porcupine”) or comma-separated
words (such as “forest, bird”).

Fetch the list of images using this API from Flickr:

https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=porcupine

You’ll replace “porcupine” in that URL with the search word(s) typed by the user.
This is a free public feed. No API key is required. You can learn more about this API here: The App
Garden

Acceptance Criteria
- The search results should come from the API listed above (replace the word “porcupine”
with the one typed by the user).
- The search results should be updated after each keystroke or change to the search string.
- When performing the search, show a progress indicator without blocking the UI.
- Tapping on an image should display an image detail view that contains the following details:
  - The image
  - Text element that displays the title
  - Text element that displays the description
  - Text element that displays the author
  - Text element that displays a formatted version of the published date
- Add at least one unit test that covers some portion of your code.
