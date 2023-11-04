



import Foundation
import CoreData



final class PersistentContainer {

    private static var _model: NSManagedObjectModel?

    private static func model(name: String) throws -> NSManagedObjectModel {
        if _model == nil {
            _model = try loadModel(name: name, bundle: Bundle.main)
        }
        return _model!
    }

    private static func loadModel(name: String, bundle: Bundle) throws -> NSManagedObjectModel {
        guard let modelURL = bundle.url(forResource: name, withExtension: "momd") else {
            throw CoreDataModelError.modelURLNotFound(forResourceName: name)
        }

        guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
            throw CoreDataModelError.modelLoadingFailed(forURL: modelURL)
        }
        return model
    }

    enum CoreDataModelError: Error {
        case modelURLNotFound(forResourceName: String)
        case modelLoadingFailed(forURL: URL)
    }

    public static func getContainer(iCloud: Bool) throws -> NSPersistentContainer {
        let name = "Exercises" // Put your model name here
        if iCloud {
            return NSPersistentCloudKitContainer(name: name, managedObjectModel: try model(name: name))
        } else {
            return NSPersistentContainer(name: name, managedObjectModel: try model(name: name))
        }
    }
}


class CoreDataManager {

    static let shared = CoreDataManager()

    lazy var persistentContainer: NSPersistentContainer = {
        setupContainer()
    }()

    func refreshCoreDataContainer() {
        try? self.persistentContainer.viewContext.save()
        self.persistentContainer = self.setupContainer()
    }

    private func setupContainer() -> NSPersistentContainer {

        let iCloud = UserDefaults.standard.bool(forKey: "iCloud") // Replace with your UserDefaults boolean here

        do {
            let newContainer = try PersistentContainer.getContainer(iCloud: iCloud)
            print(iCloud)
            guard let description = newContainer.persistentStoreDescriptions.first else { fatalError("No description found") }

            if iCloud == true {
                newContainer.viewContext.automaticallyMergesChangesFromParent = true
                newContainer.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
                print("ON")
            } else {
                description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
                print("Off")
            }

            description.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)

            newContainer.loadPersistentStores { (storeDescription, error) in
                if let error = error as NSError? { fatalError("Unresolved error \(error), \(error.userInfo)") }
            }

            return newContainer

        } catch {
            print(error)
        }

        fatalError("Could not setup Container")
    }
}
