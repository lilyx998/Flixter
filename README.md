# Project 1 - *Flixter*

**Flixter** is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: ~**15** hours spent in total
## User Stories

The following **required** functionality is complete:

- [x] User sees an app icon on the home screen and a styled launch screen.
- [x] User can view a list of movies currently playing in theaters from The Movie Database.
- [x] Poster images are loaded using the UIImageView category in the AFNetworking library.
- [x] User sees a loading state while waiting for the movies API.
- [x] User can pull to refresh the movie list.
- [x] User sees an error message when there's a networking error.
- [x] User can tap a tab bar button to view a grid layout of Movie Posters using a CollectionView.

The following **optional** features are implemented:

- [x] User can tap a poster in the collection view to see a detail screen of that movie
- [x] User can search for a movie.
- [ ] All images fade in as they are loading.
- [ ] User can view the large movie poster by tapping on a cell.
- [ ] For the large poster, load the low resolution image first and then switch to the high resolution image when complete.
- [ ] Customize the selection effect of the cell.
- [ ] Customize the navigation bar.
- [ ] Customize the UI.
- [ ] Run your app on a real device.

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Some of the physical layouts have a hardcoded size, so I would like to find a way to make the size of the images, labels, etc. scale to the size of the device being used. 
2. In my implementation for the network connection alert message, I recursively retry to gain network connection. This seems like it could potentially cause problems, as I'm not really sure if the stack is cleared once a network connection is established. 

## Video Walkthrough

Here's a walkthrough of implemented user stories:
![](https://im3.ezgif.com/tmp/ezgif-3-1bca2eeb70.gif)
<img src='https://i.imgur.com/LDdYxp7.mp4' title='Required Features Demo' width='' alt='Video Walkthrough' />

## Notes

This was my first time doing app development and my first time writing in Objective C, so I faced a lot of unfamiliar challenges while building this app! In the beginning especially, I struggled with understanding how the objects on my storyboards were related to the outlets in my code, but after creating many objects and outlets, and using them in my code, I feel like I have a much better understanding of what they are and how I can use them. This was also my first time using an API, and I feel that I can now retrieve data, store it, and display it in my apps. I also initially found custom objects to be confusing, but after working with them multiple times in my app, I feel confident in creating them and using them. 

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library

## License

    Copyright [2022] [Lily Yang]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
