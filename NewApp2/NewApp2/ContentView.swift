//
//  ContentView.swift
//  NewApp2
//
//  Created by Trevino, Katie on 4/15/24.
//

import SwiftUI

struct ContentView: View {
    // Model for Mood Entry
    struct MoodEntry: Identifiable {
        let id = UUID()
        let date: Date
        var moodRating: Int
        var note: String
        var image: Image? // Optional image
    }
    
    @State private var moodEntries: [MoodEntry] = []
    @State private var selectedDate = Date()
    @State private var moodRating = 3 // Default mood rating
    @State private var note = ""
    @State private var showInstructions = false // State variable to control the visibility of instructions
    
    // Dictionary mapping mood ratings to corresponding images
    let moodImages: [Int: Image] = [
        1: Image("sad"),
        2: Image("net"),
        3: Image("meh"),
        4: Image("happy"),
        5: Image("ex")
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    if showInstructions {
                        // Instructions
                        InstructionsView()
                    } else {
                        // Main content
                        VStack {
                            // Calendar View
                            DatePicker("", selection: $selectedDate, displayedComponents: .date)
                                .datePickerStyle(.compact)
                                .padding()
                            
                            // Mood Rating Input
                            Text("Rate your mood:")
                                .font(.title) // Adjust the font size as desired
                            Stepper(value: $moodRating, in: 1...5) {
                                Text("\(moodRating)")
                                    .font(.title) // Adjust the font size as desired
                            }
                            .padding()
                            .frame(width: 150, height: 100) // Adjust the frame size as desired

                            
                            // Notes Entry
                            Text("Log Feelings:")
                            TextEditor(text: $note)
                                .frame(height: 150)
                                .padding()
                                .border(Color.gray, width: 1) // Add border here
                            
                            // Log Mood Button
                            Button("Log Mood") {
                                let entry = MoodEntry(date: selectedDate, moodRating: moodRating, note: note, image: moodImages[moodRating])
                                moodEntries.append(entry)
                                // Reset fields
                                moodRating = 3
                                note = ""
                            }
                            .padding()
                            
                            // Mood History Visualization
                            VStack {
                                Text("Mood History")
                                    .font(.title)
                                    .padding(.top)
                                
                                ScrollView {
                                    LazyVStack {
                                        ForEach(moodEntries) { entry in
                                            VStack(alignment: .leading) {
                                                Text("\(entry.date, formatter: DateFormatter.shortDate)")
                                                    .font(.headline)
                                                Text("Rating: \(entry.moodRating)")
                                                Text("Note: \(entry.note)")
                                                    .font(.caption)
                                                    .foregroundColor(.gray)
                                                if let image = entry.image {
                                                    image
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(maxHeight: 200)
                                                }
                                            }
                                            .padding()
                                            .background(Color.secondary.opacity(0.1))
                                            .cornerRadius(10)
                                            .padding(.vertical, 4)
                                        }
                                    }
                                }
                                .padding()
                            }
                        }
                        .padding()
                        .background(Color.blue.opacity(0.1)) // Set the background color here
                    }
                    
                    // Toggle button to switch between instructions and main content
                    Button(action: {
                        showInstructions.toggle()
                    }) {
                        Text(showInstructions ? "Hide Instructions" : "View Instructions")
                            .font(.headline)
                            .padding()
                            .foregroundColor(.blue)
                    }
                    
                    Spacer()
                }
            }
            .navigationBarTitle("Mood Tracker")
        }
    }
}

struct InstructionsView: View {
    var body: some View {
        VStack {
            Text("Welcome to Mood Tracker! Follow these steps:")
                .font(.headline)
                .padding()
                .multilineTextAlignment(.center)
            
            Text("1. Rate Your Mood: Use the stepper to select a rating from 1 to 5, with 1 being the lowest and 5 being the highest.")
                .padding()
            Text("2. Log Feelings: Enter any notes or thoughts about your mood in the text box provided.")
                .padding()
            Text("3. Select Date: Use the calendar to choose the date of the mood entry.")
                .padding()
            Text("4. Log Mood: Click the 'Log Mood' button to record your mood entry.")
                .padding()
            Text("5. View Mood History: Scroll down to see your mood history over time. Each entry includes the date, mood rating, notes, and an optional mood image.")
                .padding()
        }
        .padding()
    }
}

extension DateFormatter {
    static let shortDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}














