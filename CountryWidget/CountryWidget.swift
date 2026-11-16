//
//  CountryWidget.swift
//  CountryWidget
//
//  Created by Joben Gohlke on 5/30/22.
//

import WidgetKit
import SwiftUI

struct CountryProvider: TimelineProvider {
  static let sampleData = Country(name: "United Kingdom", capital: "London", population: 66_488_991)
  
  func placeholder(in context: Context) -> CountryEntry {
    CountryEntry(date: Date(), country: CountryProvider.sampleData)
  }
  
  func getSnapshot(in context: Context, completion: @escaping (CountryEntry) -> ()) {
    let country: Country
    if context.isPreview {
      country = CountryProvider.sampleData
    } else {
      country = CountryProvider.sampleData // load countries from network source
    }
    let entry = CountryEntry(date: Date(), country: country)
    completion(entry)
  }
  
  func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
    var entries: [CountryEntry] = []
    
    let countries = loadCountries()
    let currentDate = Date()
    var dayOffset = 0

    for country in countries {
      let entryDate = Calendar.current.date(byAdding: .day,
        value: dayOffset, to: currentDate)!
      let entry = CountryEntry(date: entryDate, country: country)
      entries.append(entry)
      dayOffset += 1
    }

    let timeline = Timeline(entries: entries, policy: .atEnd)
    completion(timeline)
  }
  
  func loadCountries() -> [Country] {
    return [
      Country(name: "United States", capital: "Washington D.C.", population: 332_709_084),
      Country(name: "China", capital: "Beijing", population: 1_412_600_000),
      Country(name: "India", capital: "New Delhi", population:   1_410_062_250),
      Country(name: "Indonesia", capital: "Jakarta", population: 272_248_500),
      Country(name: "Pakistan", capital: "Islamabad", population: 225_199_937),
    ]
  }
}

struct Country {
  let name: String
  let capital: String
  let population: Int
}

extension Country {
  static var uk: Country {
    return Country(name: "United Kingdom", capital: "London", population: 66_488_991)
  }
}

struct CountryEntry: TimelineEntry {
  let date: Date
  let country: Country
}

struct CountryWidgetEntryView : View {
  var entry: CountryEntry
  @Environment(\.widgetFamily) var family // to get size to adjust UI
  
  var body: some View {
    ZStack {
      Color.blue
      
      ContainerRelativeShape()
        .inset(by: 8)
        .fill(.yellow)
      
      Image(systemName: "atom")
        .font(.system(size: 52, weight: .light))
        .foregroundColor(.blue)
        .shadow(color: .gray, radius: 2.0, x: 2, y: 2)
      
//      VStack(alignment: .leading) {
//        Text(entry.country.name)
//          .foregroundColor(.yellow)
//
//        Text(entry.country.capital)
//
//        Text(entry.country.population, format: .number)
//      }
//      .foregroundColor(.white)
    }
  }
}

@main
struct CountryWidget: Widget {
  let kind: String = "CountryWidget"
  
  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: CountryProvider()) { entry in
      CountryWidgetEntryView(entry: entry)
    }
    .configurationDisplayName("Country of the day")
    .description("Show a new country every day.")
    .supportedFamilies([.systemSmall, .systemMedium, .systemLarge, .systemExtraLarge])
  }
}

struct CountryWidget_Previews: PreviewProvider {
  static var previews: some View {
    CountryWidgetEntryView(entry: CountryEntry(date: Date(), country: Country.uk))
      .previewContext(WidgetPreviewContext(family: .systemSmall))
  }
}
