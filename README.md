
# iFacility - Facilities Selection

This project demonstrates a user interface that allows users to select options from a list of facilities. The user can select one option from each facility, and there are exclusion conditions in place to prevent certain combinations of options from being selected together.

## Features

- Display a list of facilities and their options.
- Allow users to select one option from each facility.
- Apply exclusion conditions to prevent incompatible options from being selected together.

## Screenshots 

<img width="586" alt="Screenshot 2023-06-30 at 2 34 22 PM" src="https://github.com/jameelshehadeh/iFacility/assets/24472126/108c42bb-50cb-4fbb-b3c4-46be15769f4f">

## Explanation 

- Design Pattern

In this project, the MVVM (Model-View-ViewModel) design pattern was chosen for its simplicity and effectiveness in managing data flow.

To facilitate data binding between the View and ViewModel, closures were used. Closures provide a straightforward and efficient way to observe changes in the ViewModel due to the simplicity and the absence of complex data pipelines. This approach simplifies the implementation of data binding

- Third-Party Frameworks/Libraries

For managing UI constraints, the SnapKit framework was employed. SnapKit is a popular third-party library that simplifies Auto Layout constraint creation and management in code. By leveraging SnapKit, the project achieves a more streamlined and expressive way of defining UI constraints, reducing the boilerplate code and enhancing the flexibility and responsiveness of the user interface.


## Installation

1. Clone the repository to your local machine.
2. Open the project in Xcode.
3. Build and run the project on the iOS Simulator or a connected device.

## Usage

1. Launch the app to see the list of facilities and options.
2. Tap on an option to select it for each facility.
3. The app will handle the exclusion conditions and prevent incompatible options from being selected together.

