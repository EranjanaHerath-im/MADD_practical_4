//
//  ContentView.swift
//  practical5
//
import SwiftUI

struct ContentView: View {

    @State private var tasks = [
        TaskItem(title: "Morning Walk", completed: true),
        TaskItem(title: "Drink Water", completed: false),
        TaskItem(title: "Read Notes", completed: false),
        TaskItem(title: "Call Home", completed: true)
    ]

    private var completedCount: Int {
        tasks.filter { $0.completed }.count
    }

    private var progressPercentage: Int {
        guard !tasks.isEmpty else {
            return 0
        }

        return Int(
            Double(completedCount) /
            Double(tasks.count) * 100
        )
    }

    var body: some View {

        NavigationStack {

            VStack(spacing: 4) {

                Text(
                    "\(completedCount) / \(tasks.count) Completed"
                )
                .font(.caption)
                .bold()

                // Part G - Progress Percentage
                Text("\(progressPercentage)% Complete")
                    .font(.caption2)
                    .foregroundStyle(.secondary)

                List(tasks.indices, id: \.self) { index in

                    // Tap this row to toggle completion
                    Button {
                        tasks[index].completed.toggle()
                    } label: {

                        HStack {

                            Image(
                                systemName:
                                    tasks[index].completed
                                    ? "checkmark.circle.fill"
                                    : "circle"
                            )
                            .foregroundStyle(
                                tasks[index].completed
                                ? .green
                                : .secondary
                            )

                            Text(tasks[index].title)
                        }
                    }

                    // Separate interaction for details
                    NavigationLink {
                        TaskDetailView(
                            task: tasks[index]
                        )
                    } label: {

                        Label(
                            "Details",
                            systemImage: "info.circle"
                        )
                    }
                }
            }
            .navigationTitle("Quick Tasks")
        }
    }
}

#Preview {
    ContentView()
}
