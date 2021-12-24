//
//  CoreDataHandler.swift
//  Assignment12
//
//  Created by DCS on 24/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class CoreDataHandler {
    
    static let shared = CoreDataHandler()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedObjectContext: NSManagedObjectContext?
    
    private init()
    {
        managedObjectContext = appDelegate.persistentContainer.viewContext
    }
    
    func save() {
        appDelegate.saveContext()
    }
    
    func insert(spid: Int, name: String, gender:String,dob: Date,sclass: String,password: String,completion: @escaping () -> Void) {
        let s = Student(context: managedObjectContext!)
        
        s.spid = Int64(spid)
        s.name = name
        s.gender = gender
        s.dob = dob
        s.sclass = sclass
        s.password = password
        save()
        completion()
    }
    
    func update(s:Student,name: String, gender:String,dob: Date,sclass: String, completion: @escaping () -> Void){
        
        s.name = name
        s.gender = gender
        s.dob = dob
        s.sclass = sclass
    
        save()
        completion()
    }
    
    func delete(s:Student, completion: @escaping () -> Void){
        
        managedObjectContext!.delete(s)
        save()
        completion()
    }
    
    func fetch() -> [Student] {
        let fetchRequest:NSFetchRequest<Student> = Student.fetchRequest()
        do{
            let studentArray = try managedObjectContext?.fetch(fetchRequest)
            return studentArray!
        } catch {
            print(error)
            return [Student]()
        }
    }
    
    func fetchStudentClassWise(classname1: String) -> [Student] {
        let fetchRequest:NSFetchRequest<Student> = Student.fetchRequest()
        
        do{
            fetchRequest.predicate = NSPredicate(format: "sclass == %@", classname1)
            let studentArray = try managedObjectContext?.fetch(fetchRequest)
            return studentArray!
        } catch {
            print(error)
            return [Student]()
        }
    }
    
    func fetchLastRecord() -> [Student] {
        
        let fetchRequest:NSFetchRequest<Student> = Student.fetchRequest()
        
        fetchRequest.fetchLimit = 1
        fetchRequest.sortDescriptors? = [NSSortDescriptor(key: "spid", ascending: false)]
        
        do{
            let studentArray = try managedObjectContext?.fetch(fetchRequest)
            return studentArray!
        } catch {
            print(error)
            return [Student]()
        }
    }
    
    func CheckUser(spid: Int,password: String) -> [Student] {
        let fetchRequest:NSFetchRequest<Student> = Student.fetchRequest()
        do{
            
            let p1 = NSPredicate(format: "spid == %i", spid)
            let p2 = NSPredicate(format: "password == %@", password)
            
            fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [p1,p2])

            let studentArray = try managedObjectContext?.fetch(fetchRequest)
            return studentArray!
        } catch {
            print(error)
            return [Student]()
        }
    }
    
    func fetchStudentSpecific(Spid: Int) -> [Student] {
        let fetchRequest:NSFetchRequest<Student> = Student.fetchRequest()
        
        do{
            fetchRequest.predicate = NSPredicate(format: "spid == %i", Spid)
            let studentArray = try managedObjectContext?.fetch(fetchRequest)
            return studentArray!
        } catch {
            print(error)
            return [Student]()
        }
    }
    
    
    func ChangePassword(s:Student,password: String,completion: @escaping () -> Void){
    
        s.password = password
        save()
        completion()
    }
    
    
    //Notice Table ===============================================================================================
    func insertNotice(noticeTitle: String, noticeDate: Date, noticeDescription:String,sclass:String,completion: @escaping () -> Void) {
        let n = Notice(context: managedObjectContext!)
        
        n.noticeTitle = noticeTitle
        n.noticeDate = noticeDate
        n.noticeDescription = noticeDescription
        n.sclass = sclass
        save()
        completion()
    }
    
    func updateNotice(n:Notice,noticeTitle: String, noticeDate: Date, noticeDescription:String,sclass: String, completion: @escaping () -> Void){
        
        n.noticeTitle = noticeTitle
        n.noticeDate = noticeDate
        n.noticeDescription = noticeDescription
        n.sclass = sclass
        save()
        completion()
    }
    
    func deleteNotice(n: Notice, completion: @escaping () -> Void){
        
        managedObjectContext!.delete(n)
        save()
        completion()
    }
    
    func fetchNotice() -> [Notice] {
        let fetchRequest:NSFetchRequest<Notice> = Notice.fetchRequest()
        do{
            let NoticeArray = try managedObjectContext?.fetch(fetchRequest)
            return NoticeArray!
        } catch {
            print(error)
            return [Notice]()
        }
    }
    
    func fetchNoticeByClass(classname1: String) -> [Notice] {
        let fetchRequest:NSFetchRequest<Notice> = Notice.fetchRequest()
        do{
            
            fetchRequest.predicate = NSPredicate(format: "sclass == %@", classname1)
            let NoticeArray = try managedObjectContext?.fetch(fetchRequest)
            return NoticeArray!
        } catch {
            print(error)
            return [Notice]()
        }
    }

    
}

