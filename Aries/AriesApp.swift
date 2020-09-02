//
//  AriesApp.swift
//  Aries
//
//  Created by Haruta Yamada on 2020/08/18.
//

import SwiftUI
import CoreData

final class PersistentStore {
    static let shared = PersistentStore()
    let persistentContainer: NSPersistentContainer
    private init() {
        self.persistentContainer = {
            let container = NSPersistentContainer(name: "Aries")
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container
        }()
    }
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

@main
struct AriesApp: App {
    @AppStorage(wrappedValue: true, AppStorageKey.isFirstLaunch.rawValue) var isFirstLaunch
    
    @Environment(\.scenePhase) private var scenePhase
    private var store = PersistentStore.shared
    var body: some Scene {
        WindowGroup {
            if isFirstLaunch {
                NavigationView(content: {
                    PrepareBankView()
                })
            } else {
                HomeView()
                    .environment(\.managedObjectContext, store.persistentContainer.viewContext)
            }
        }
    }
}
