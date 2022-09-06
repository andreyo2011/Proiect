//
//  LineStopsController.swift
//  Laborator3
//
//  Created by user216460 on 9/6/22.
//



import UIKit


struct StopsModel: Decodable{
    var stops: [Stop] = []
}

/*struct Item: Decodable{
    //let id:Int
    let title: String
    let date: String
    //let body: String
    
    //campurile trebuie sa se potriveasca cu json
    //Coding keys ptr a schimba
}*/

struct Stop: Decodable{
    let id: Int
    let name: String
    let description: String
    //et date: String
    
}
class LineStopsController: UIViewController {
    
    
    private var model = StopsModel()

       
    @IBOutlet weak var tableView: UITableView!
    var item: Line!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("here;;")
        configure()
        requestItems()
        // Do any additional setup after loading the view.
    }
    
    private func requestItems(){
        //let pathString = "https://mars.nasa.gov/api/v1/news_items/?page=0&per_page=10&order=publish_date+desc,created_at+desc"
        //print("=================",item?.id ?? <#default value#>)
        let pathString = "https://info.stbsa.ro/rp/api/lines/\(String(item.id))"
        print(pathString)
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

            guard let stops = try? jsonDecoder.decode(StopsModel.self, from: data) else {return}
            welf.model.stops = stops.stops //sau self?. fara welf
            DispatchQueue.main.async {
                welf.tableView.reloadData() // sau self?. fara welf
                
            }
        
            print(stops)
  
        }
        task.resume()
    }
    
    private func configure(){
        
        guard let item = item else {
            return
        }
 
        title = "NasaNews"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(LineStopsTableViewCell.self, forCellReuseIdentifier: LineStopsTableViewCell.cellId)
    }
    
}

extension LineStopsController:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)->UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LineStopsTableViewCell.cellId, for: indexPath) as? LineStopsTableViewCell else {return UITableViewCell()}
        
        //let model = NasaNewsTableViewCellModel(title: "title", date: "date\(indexPath.row)")
        let cellModel = model.stops[indexPath.row]
        cell.setUp(with: cellModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return model.stops.count
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
















