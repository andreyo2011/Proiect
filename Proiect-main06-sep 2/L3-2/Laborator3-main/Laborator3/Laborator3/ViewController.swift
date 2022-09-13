
//
//  ViewController.swift
//  Laborator3
//
//  Created by user216460 on 8/31/22.
//

import UIKit


struct NasaNewsModel: Decodable{
    var lines: [Line] = []
}

/*struct Item: Decodable{
    //let id:Int
    let title: String
    let date: String
    //let body: String
    
    //campurile trebuie sa se potriveasca cu json
    //Coding keys ptr a schimba
}*/

struct Line: Decodable{
    let id: Int
    let name: String
    let type: String
    //et date: String
    
}
class ViewController: UIViewController {
    
    
    private var model = NasaNewsModel()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("here;;")
        configure()
        requestItems()
        // Do any additional setup after loading the view.
    }
    
    private func requestItems(){
        //let pathString = "https://mars.nasa.gov/api/v1/news_items/?page=0&per_page=10&order=publish_date+desc,created_at+desc"
        let pathString = "https://info.stbsa.ro/rp/api/lines"
       // let pathString  = "google.com"
        let url = URL(string: pathString)!
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let _ = error{
                //print("here::",error.localizedDescription)
                return
            }
            
            let jsonDecoder = JSONDecoder()
    
            guard let data = data else {return}
            guard let welf = self else {return}

            guard let lines = try? jsonDecoder.decode(NasaNewsModel.self, from: data) else {return}
            welf.model.lines = lines.lines //sau self?. fara welf
            DispatchQueue.main.async {
                welf.tableView.reloadData() // sau self?. fara welf
                
            }
        
            print(lines)
  
        }
        task.resume()
    }
    
    private func configure(){
        title = "Linii STB"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(NasaNewsTableViewCell.self, forCellReuseIdentifier: NasaNewsTableViewCell.cellId)
    }
    
    private func navigate(item: Line){
        //guard let viewController = storyboard?.instantiateViewController(withIdentifier: "ArticleViewController")
        //as? ArticleViewController else {return}
        
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "LineStopsController")
        as? LineStopsController else {return}
        viewController.item = item //inlocuiteste cele 2 de jos in urma modificarilor ArticleViewController
        print(item.id)
        //viewController.textView?.text = item.body
        //viewController.title = item.title
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
}

extension ViewController:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)->UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NasaNewsTableViewCell.cellId, for: indexPath) as? NasaNewsTableViewCell else {return UITableViewCell()}
        
        //let model = NasaNewsTableViewCellModel(title: "title", date: "date\(indexPath.row)")
        let cellModel = model.lines[indexPath.row]
        cell.setUp(with: cellModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return model.lines.count
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        let item = model.lines[indexPath.row]
        navigate(item: item)
    }
}



























































