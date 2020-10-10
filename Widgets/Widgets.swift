//
//  Widgets.swift
//  Widgets
//
//  Created by Fumiya Tanaka on 2020/10/10.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> WidgetInfo {
        WidgetInfo(date: Date(), nutrient: "ビタミンC", vegetable: "トマト", image: Image("leaf"), configuration: ConfigurationIntent())
    }
    
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (WidgetInfo) -> ()) {
        let entry = WidgetInfo(date: Date(), nutrient: "ビタミンC", vegetable: "トマト", image: Image("leaf"), configuration: configuration)
        completion(entry)
    }
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [WidgetInfo] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = WidgetInfo(date: entryDate, nutrient: "ビタミンC", vegetable: "トマト", image: Image("leaf"), configuration: configuration)
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct WidgetInfo: TimelineEntry {
    var date: Date
    let nutrient: String
    let vegetable: String
    let image: Image
    let configuration: ConfigurationIntent
}

struct WidgetsEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0){
                VStack(spacing: 16){
                    VStack(alignment: .leading, spacing: 4) {
                        HStack(spacing: 5) {
                            Image("leaf").resizable()
                                .frame(width: 17, height: 17, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            Text("不足中の栄養素")
                                .foregroundColor(Color("Primary"))
                        }
                        Text(entry.nutrient + "不足中")
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        HStack(spacing: 5) {
                            Image("leaf")
                                .resizable()
                                .frame(width: 17, height: 17, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            Text("おすすめの野菜")
                                .foregroundColor(Color("Primary"))
                        }
                        Text(entry.nutrient)
                    }
                }
                .frame(width: geometry.size.width / 2, height: geometry.size.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                VStack{
                    HStack {
                        entry.image
                            .resizable()
                            .frame(width: 100, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        Image("leaf")
                            .resizable()
                            .frame(width: 20, height: 20, alignment: .center)
                    }
                }
                .frame(width: geometry.size.width / 2, height: geometry.size.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
        }
        
    }
}

@main
struct Widgets: Widget {
    let kind: String = "Widgets"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            WidgetsEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemMedium])
    }
}

struct Widgets_Previews: PreviewProvider {
    static var previews: some View {
        WidgetsEntryView(entry: WidgetInfo(date: Date(), nutrient: "ビタミンC", vegetable: "トマト", image: Image("leaf"), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
