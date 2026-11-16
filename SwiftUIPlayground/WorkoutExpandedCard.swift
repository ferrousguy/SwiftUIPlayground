//
//  WorkoutExpandedCard.swift
//  swiftux-components
//
//  Created by SWIFT UX on 3/21/25.
//  Copyright © 2025 SWIFT UX. All rights reserved.
//

import SwiftUI

struct WorkoutExpandedCard: View {
    let workout: WorkoutData
    @State private var isExpanded = false
    
    // Format date to string
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: workout.date)
    }
    
    // Format duration to string
    private var formattedDuration: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: workout.duration) ?? "--"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(formattedDate)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    Text(workout.name)
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                
                Spacer()
                
                HStack(spacing: 8) {
                    Text("\(workout.exerciseCount)")
                        .foregroundStyle(.primary)
                        .font(.system(.callout, weight: .medium))
                        .frame(width: 32, height: 32)
                        .background(.background)
                        .clipShape(Circle())
                    
                    Image(systemName: "trophy.fill")
                        .foregroundStyle(.yellow)
                        .font(.system(.footnote, weight: .medium))
                        .frame(width: 32, height: 32)
                        .background(.yellow.secondary)
                        .clipShape(Circle())
                    
                    if isExpanded {
                        Button(action: {
                            
                        }) {
                            Text("View")
                                .font(.callout)
                                .fontWeight(.medium)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(.black)
                                .foregroundStyle(.white)
                                .clipShape(Capsule())
                        }
                        .buttonStyle(PlainButtonStyle())
                        .transition(.move(edge: .trailing).combined(with: .blurReplace))
                    }
                }
            }
            
            // Expanded content
            if isExpanded {
                HStack(alignment: .center) {
                    ExpandedInfoCard(title: "Time") {
                        Text(formattedDuration)
                    }
                    
                    ExpandedInfoCard(title: "Exercises") {
                        Text("\(workout.exerciseCount)")
                    }
                    
                    ExpandedInfoCard(title: "Effort") {
                        EffortIndicator(percentage: workout.effortPercentage)
                    }
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .padding(12)
        .background(.gray.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .onTapGesture {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                isExpanded.toggle()
            }
        }
    }
}

// MARK: - Extensions
extension WorkoutExpandedCard {
    struct ExpandedInfoCard<Content: View>: View {
        let title: String
        let content: Content
        
        init(title: String, @ViewBuilder content: () -> Content) {
            self.title = title
            self.content = content()
        }
        
        var body: some View {
            VStack {
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                content
                    .font(.callout)
                    .fontWeight(.medium)
                    .frame(height: 12)
            }
            .padding(10)
            .frame(maxWidth: .infinity)
            .background(.background)
            .cornerRadius(10)
        }
    }

    struct EffortIndicator: View {
        let percentage: Double
        private let pillCount = 4
        
        private var activePills: Int {
            Int(ceil(percentage / 25.0))
        }
        
        private func pillColor(_ index: Int) -> Color {
            if index >= activePills {
                return .gray.opacity(0.3)
            }
            
            switch index {
            case 0: return .green
            case 1: return .yellow
            case 2: return .orange
            default: return .gray.opacity(0.3)
            }
        }
        
        var body: some View {
            HStack(spacing: 4) {
                ForEach(0..<pillCount, id: \.self) { index in
                    Capsule()
                        .fill(pillColor(index))
                        .frame(width: 16, height: 6)
                }
            }
        }
    }
}

// MARK: - WorkoutData Model
struct WorkoutData {
    let name: String
    let date: Date
    let duration: TimeInterval
    let exerciseCount: Int
    let effortPercentage: Double
}

// MARK: - Previews
#Preview {
    VStack(spacing: 16) {
        WorkoutExpandedCard(workout: WorkoutData(
            name: "Morning Run",
            date: Date(),
            duration: 3600,
            exerciseCount: 12,
            effortPercentage: 65
        ))
        
        WorkoutExpandedCard(workout: WorkoutData(
            name: "Back & Biceps",
            date: Date(),
            duration: 2100,
            exerciseCount: 6,
            effortPercentage: 45
        ))
    }
    .padding(.horizontal)
}

