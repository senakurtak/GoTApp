//
//  FavoritesWidget.swift
//  FavoritesWidget
//
//  Created by Sena Kurtak on 23.04.2024.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent(), favoriteHousesCount: 0)
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration, favoriteHousesCount: fetchFavoriteHousesCount())
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []
        let favoriteHousesCount = fetchFavoriteHousesCount()  // Fetch the count here
        
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration, favoriteHousesCount: favoriteHousesCount)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }

    private func fetchFavoriteHousesCount() -> Int {
        return FavoritesManager.shared.favoriteHouses.count
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
    let favoriteHousesCount: Int
}

struct FavoritesWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        ZStack {
            VStack {
                Text("\(entry.favoriteHousesCount)")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.black.opacity(0.3))
                HStack {
                    Text("🛖")
                        .font(.title)
                    Text("Favorite Houses")
                        .font(.subheadline)
                        .foregroundStyle(.black.opacity(0.7))
                }
                .padding(0)
            }
        }
    }
}

struct FavoritesWidget: Widget {
    let kind: String = "FavoritesWidget"
    
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            FavoritesWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    FavoritesWidget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley, favoriteHousesCount: 1)
    SimpleEntry(date: .now, configuration: .starEyes, favoriteHousesCount: 1)
}
