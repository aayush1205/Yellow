# Yellow

**Important: This project is in reference to a hiring challenge.**

**Yellow** is a Flutter based cross-platform mobile application that acts as a Movie Showcase. It is based on Clean Architecture keeping in mind the requirements of efficient scaling and maintenance. 

<p align = "center">
<img src="https://i.imgur.com/T6hcd6D.png"
     width="300",
     height="300">
 </p>

<br>

## Note
1. **Yellow** is a rudimentary mobile application made in a short span, hence isn't throughly tested for corner cases yet. 
2. The app has certain limitations on state management and UI reloads.

## Features

1. Explore page allows you to add a movie using The Movie Database API.
2. You can add a custom Movie with a Poster Path.
3. The state is persisted using Hive.

## Getting Started
These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites
1. [Flutter](https://flutter.dev/docs)

### Installing
The repository has the installer script. This is what you need to do to get muCLIar running on your system:

1. Clone the repository:

```
git clone https://github.com/aayush1205/Yellow.git
```

2. Get into the directory:

```
cd Yellow or cd /path/to/Yellow
```
3. Connect a device or start up an Emulator

3. Run the installer: 

```
flutter run -v
```

<br>


## Built With
* [Flutter](https://flutter.dev/) - Cross-Platform Mobile Dev Framework
* [FireBase](https://firebase.google.com/docs) - Web Driver

<br>

## Contributing
### How to Contribute?
* Make sure that your changes do not conflict with the core files (changing file directories will require a change in all called paths)
* Follow the original code structure
* Refactoring contributions are welcome, explicitly mention "[Refactor]" in your pull request
* Give a few days to review PRs, code reviews are welcome 

### Steps to sync fork with master (Open Source Contributors):
If you fork is behind from the master project you can do these to get the latest version in the master branch of your fork.
First go to your(cloned) project folders.
Open the terminal in this directory then enter the following commands in the terminal:
 - Configuring a remote for fork

       $ git remote -v 
       //Lists the current configured remote repository for your fork//
       $ git remote add upstream https://github.com/aayush1205/Yellow.git
       //Specifies a new remote upstream repository that will be synced with the fork//
       $ git remote -v
       //Should show the newly made remote *upstream* along with your previous remote//

 - Syncing the fork

       $ git fetch upstream
       //Fetch the branches and their respective commits from the upstream repository//
       $ git checkout master
       //Switches to local master branch//
       $ git merge upstream/master
       //Merges the upstearm remote (Main repo) into your local fork//     
<br>

## License
This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

<br>

