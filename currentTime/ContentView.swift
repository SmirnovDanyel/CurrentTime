//
//  ContentView.swift
//  currentTime
//
//  Created by Даниил Смирнов on 13.06.2023.
//
// До изменений с алертом

import SwiftUI
import Foundation

struct Item {
    let id: UUID = UUID()
    
    let title: String
}

struct ContentView: View {
    @State private var items: [Item] = []

    @State private var editMode: EditMode = .inactive
    
    @State private var alertItem: String?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items, id: \.id) { item in
                    NavigationLink {
                        Text(item.title)
                    } label: {
                        Text(item.title)
                    }
                }
                .onDelete(perform: removeRows)
            }
            
            .navigationBarTitle("Текущее время")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing,
                        content: {
                        PlusButtonView(onEdit: { onAdd() })
                })
                
                ToolbarItem(placement: .bottomBar,
                            content: {
                    Button(action: {
                        withAnimation{
                            editMode = editMode.isEditing ? .inactive : .active
                        }
                    },
                           label: {
                        Text("Ввод")
                    })
                })
                
                
                ToolbarItem(placement: .navigationBarLeading,
                            content: {
                    Button(action: {
                        withAnimation{
                            editMode = editMode.isEditing ? .inactive : .active
                        }
                    },
                           label: {
                        Text("Ред")
                    })
                })
            
                
            }
            .environment(\.editMode, $editMode)
        }
    }

    private func removeRows(at offsets: IndexSet) {
        withAnimation{
            items.remove(atOffsets: offsets)
        }
    }
    
    private func onAdd(){
        withAnimation{
            items.append(Item(title: "\(Date().displayFormat)"))
        }
    }
}

struct PlusButtonView: View{
    
    let onEdit: () -> Void
    
    var body: some View{
        Button(action: { onEdit() },
               label: {
            Image(systemName: "plus")
        })
    }
    
}

extension Date {
    var displayFormat: String {
        self.formatted(
            .dateTime.locale(.init(identifier: "ru_RU"))
            .month()
            .year()
            .day()
            .hour()
            .minute()
            .second()
            .timeZone(.exemplarLocation)
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
