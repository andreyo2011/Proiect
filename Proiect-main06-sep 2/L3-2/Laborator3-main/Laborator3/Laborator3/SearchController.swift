//
//  SearchController.swift
//  Laborator3
//
//  Created by user216460 on 9/12/22.
//


import UIKit

final class SearchArticleViewController: UIViewController{
    
    
    @IBOutlet weak var tableView: UITableView!
    //@IBOutlet weak var tableView: UITableView!
    //@IBOutlet weak var tableView: UITableView!
    //@IBOutlet weak var searchTextField: UITextField!
    
    private var model: [LineEntity] = []{
        didSet{
            DispatchQueue.main.async { [weak self] in
                self?.tableView?.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        getAllModels()
    }
    
    private func configure(){
        //searchTextField?.delegate = self
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(SearchArticleTableViewCell.self, forCellReuseIdentifier: SearchArticleTableViewCell.cellId)
        
    }
    
    private func getAllModels(){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = LineEntity.fetchRequest()
        //fetchRequest.predicate() sortari,filtrari etc
        do{
            model = try managedContext.fetch(fetchRequest)
            
        }catch{
            print("here::",error.localizedDescription)
            
        }
        
    }
}


extension SearchArticleViewController: UITextFieldDelegate{
    
}

extension SearchArticleViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchArticleTableViewCell.cellId, for: indexPath)
                as? SearchArticleTableViewCell else { return UITableViewCell() }
        let cellModel = model[indexPath.row]
        cell.setup(ratingEntity: cellModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
}
