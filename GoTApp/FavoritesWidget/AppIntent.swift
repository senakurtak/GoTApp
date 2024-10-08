//
//  AppIntent.swift
//  FavoritesWidget
//
//  Created by Sena Kurtak on 23.04.2024.
//

import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"
    static var description = IntentDescription("This is an example widget.")

    // An example configurable parameter.
    @Parameter(title: "Favorite House", default: "🛖")
    var favoriteEmoji: String
}
