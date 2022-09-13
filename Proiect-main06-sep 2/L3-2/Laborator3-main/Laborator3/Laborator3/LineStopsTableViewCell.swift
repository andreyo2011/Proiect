//
//  LineStopsTableViewCell.swift
//  Laborator3
//
//  Created by user216460 on 9/6/22.
//


import UIKit


class LineStopsTableViewCell:UITableViewCell{
    static let cellId = "LineStopsTableViewCell"
    
    let lineLabel = UILabel()
    let typeLabel = UILabel()

    let accesorryImageView = UIImageView()
    
    override init(style:UITableViewCell.CellStyle, reuseIdentifier:String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    func setUp(with model:Stop){
       
        lineLabel.text = "Statia \(String(model.name))"
        /*var type: String = ""
        if model.type == "BUS"{
            type = "Autobuz"
        }
        else if model.type == "TRAM"{
            type = "Tramvai"
        }
        else if model.type == "CABLE_CAR"{
            type = "Troleibuz"
        }
        else if model.type == "SUBWAY"{
            type = "Metrou"
        }
        else{
            type = "Necunoscut"
        }*/
            
        typeLabel.text = model.description
        
        
        
        
    }
  
    override var reuseIdentifier: String?{
        return LineStopsTableViewCell.cellId
    }
    
    required init(coder: NSCoder) {
        fatalError("init coder has not been implemented")
    }
}

private extension LineStopsTableViewCell{
    func configure(){
        lineLabel.font = UIFont.systemFont(ofSize: 23)
        lineLabel.numberOfLines = 2
        
        typeLabel.font = UIFont.systemFont(ofSize: 15)
        typeLabel.numberOfLines = 1
        
        
        typeLabel.textColor = UIColor.secondaryLabel

        
        contentView.addSubview(lineLabel)
        contentView.addSubview(typeLabel)
        
        lineLabel.translatesAutoresizingMaskIntoConstraints = false
        lineLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        lineLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        //titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.topAnchor.constraint(equalTo: lineLabel.bottomAnchor, constant: 5).isActive = true
        typeLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        typeLabel.rightAnchor.constraint(equalTo: lineLabel.rightAnchor, constant: -5).isActive = true
        typeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        
    }}
