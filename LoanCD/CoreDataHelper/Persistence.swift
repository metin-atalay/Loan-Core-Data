//
//  Persistence.swift
//  LoanCD
//
//  Created by Metin Atalay on 19.05.2022.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentCloudKitContainer
    
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "LoanCD")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    func save() {
        do {
            try viewContext.save()
        }
        catch {
            print("save loan error", error.localizedDescription)
        }
    }
    
    func fetchPayments(for loanId: String) -> [Payment] {
        
        let request: NSFetchRequest<Payment> = Payment.fetchRequest()
        request.predicate = NSPredicate(format: "loanId == %@", loanId)

        
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Payment.date, ascending: true)]
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
}
