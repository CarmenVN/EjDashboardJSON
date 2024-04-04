//
//  ViewController.swift
//  EjemploDashBoard
//
//  Created by Carmen García on 2/4/24.
//

import UIKit
struct Invoice: Codable{ 
   // let imageInvoice: UIImage
    let importeOrdenacion: Double
    let fecha: String
 
}
struct Peticiones:Codable{ //CONTACTO
    let numFacturas: Int
    let facturas:[Invoice]
}


class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UISearchBarDelegate {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var invoices = [Invoice]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource=self
        collectionView.delegate=self
        loadDataFromJson()
    
    }
    func loadDataFromJson(){
        guard let path = Bundle.main.path(forResource: "invoice", ofType: "json") else{return}
            let url = URL(fileURLWithPath: path)
            do{
                let data = try Data(contentsOf: url)
                let json=try JSONSerialization.jsonObject(with: data,options: .mutableContainers)
                print(json)
                print("datos cargador correctamente desde json")
               
                let jsonDecoder=JSONDecoder()
                let dataFromJson = try jsonDecoder.decode(Peticiones.self, from: data)
                invoices = dataFromJson.facturas
                collectionView.reloadData()
            }catch{
                print("error")
            }
    }
       
            
            
        
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            let count = invoices.count
            print(count)
            return count
            
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InvoiceCollectionViewCell", for: indexPath) as! InvoiceCollectionViewCell
            cell.lblPrice.text = String(invoices[indexPath.row].importeOrdenacion)
            cell.lblConsumption.text = invoices[indexPath.row].fecha
            print(String(invoices[indexPath.row].importeOrdenacion))
            print(invoices[indexPath.row].fecha)
            return cell
        }
        
        
        
        
    }


