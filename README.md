# Load_Async_Image
This is a demo of loading image asynchronously in the grid. Also implemented pagination and error handling.

- **Overview**

  Develop an application for iOS to efficiently load and display images in a scrollable grid using the Unsplash API. You are not allowed to use any third-party image loading library.

- **Task Of the Demo**

  - **Image Loading:** Implement asynchronous image loading from the API URLs. The scrollable grid should efficiently work with even 10,000 images.
  - **Caching:** Develop a caching mechanism to store images retrieved from the API in memory and/or disk cache for efficient retrieval.
  - **Error Handling:** Handle network errors and image loading failures gracefully when fetching images from the API, providing informative error messages or   placeholders for failed image loads.

**
- IDE: XCODE 12.0
- Machine: Macbook Pro (Mid 2012)
- OSX: MAC OS Catalina (10.15.7)
- iOS version: iOS 14 (tested on iOS 14)
- Design pattern: MVVM
**

To run this application first you need to register you self on [Unsplash.com](https://unsplash.com/developers) as a developer to get Access Key. Put that access key in constant.swift file in client id veriable else you will get an error.

In this task I have implemented caching machanism to load already cached images from local cached storage. Also added placeholder image and error image to handle loading and failure state of image loading.

To handle various error I have created custom enum which extends the Error class. On each error I show message from bottom with red background. User can remove that message from screen by click on cross button or it will automatically removed after 4 seconds but in the case of internet connection that message will not remove automatically untill internet connection is available. User can remove that message by clicking cross button.
