//
//  ViewController.swift
//  TableViewIndex
//
//  Created by Saadet Şimşek on 08/08/2024.
//

import UIKit

struct Group {
    let title: String
    let animals: [String]
}

final class ViewController: UIViewController {
    
    private let animals: [String: [String]] = [
        "A": ["Ant Eater"],
        "B": [ "Bear", "Bird"],
        "C": [ "Cat"],
        "D": [ "Donkey", "Duck", "Dog"],
        "F": ["Fish", "Frog"],
        "G": ["Gorilla", "Gold Fish"],
        "L": ["Lion" ],
        "M": ["Mouse", "Mountain Lion"],
        "p": ["Panther"],
        "R": ["Rabbit", "Rat"],
        "S": ["Snake"],
        "T": ["Tiger", "Turtle"],
    ]
    
    private let alphabet = "abcdefghijklmnopqrstuvwxyz"
    
    var models = [Group]()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.backgroundColor = .systemBackground
        setupData()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupData(){
        for (key, value) in animals{
            models.append(Group(title: key, animals: value))
        }
        models = models.sorted(by: { $0.title < $1.title})
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 0,
                                 y: view.safeAreaInsets.top,
                                 width: view.frame.size.width,
                                 height: view.frame.size.height-view.safeAreaInsets.top)
    }
}

//MARK: - Tableview Delegate
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.section].animals[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return models[section].title
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return Array(alphabet.uppercased()).compactMap({ "\($0)"})
     //   return Array(alphabet.uppercased()).shuffled().compactMap({ "\($0)"}) // shuffle harfleri karıştırır
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        guard let targetIndex = models.firstIndex(where: { $0.title == title }) else {
            return 0
        }
        return targetIndex
    }
    
}
