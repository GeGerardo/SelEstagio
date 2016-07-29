


//Resolver problemas: Nova sintaxe do swift 2.2 em relação a erros no JSON e principalmente
//Implementar o MAPKIT annotation depois de corrigir o error anterior e finalizar o projeto
//Não consegui implementar tudo porque tive, basicamente, que aprender tudo do zero


//  ViewController.swift
//  SelEstagio
//
//  Created by Gemerson Gerardo on 23/07/16.
//  Copyright © 2016 Gemerson Gerardo. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var descriTempo: UILabel!
    @IBOutlet weak var tempMin: UILabel!
    @IBOutlet weak var tempMax: UILabel!
    @IBOutlet weak var nomeCidade: UILabel!
    @IBOutlet weak var inputMapView: MKMapView!



    
    //Jogar as informacoes para a proxima tela. Nao realizei prox tela. Teria que ter um singleton e as chamadas em outra viewController, mas devido ao erro no json e o tempo de estudo,n tive tempo de fazer e deixei tudo na mesma tela
    @IBAction func botaoBuscar(sender: AnyObject) {
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Recebe 15 cidades proximas das coordenadas e passa informacao em sistema metrico
        //Nao implementei LAT e LON pela informacao do PIN marcado pelo usuario no mapView.
        //Esta comentado porque existe um erro no retorno na funcao getinfotempo com o estouro da quantidade de cidades retornadas
        //getInfoTempo("http://api.openweathermap.org/data/2.5/find?lat= {LAT}&lon={LON}&cnt=15&units=metric&APPID=749ab851d83e5523cc11e05c84f4611f")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Funcao para info da URL
    func getInfoTempo(urlString: String){
        let url = NSURL(string: urlString)
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(dados, resposta, error) in
            dispatch_async(dispatch_get_main_queue(), {
            self.setLabel(dados!)
            })
        }
        task.resume()
    }
    
    //Estrutura e parse do JSON. 
    
    var json: AnyObject?

    func setLabel( infoTempo: NSData) {
        
        do {
            self.json = try NSJSONSerialization.JSONObjectWithData(infoTempo, options: []) as! NSDictionary
        } catch {
            print(error)
        }
        
        if let name = json!["name"] as? String {
            nomeCidade.text = name
        }
        
        if let main = json!["main"] as? NSDictionary {
            if let temp_max = main["temp_max"] as? Double{
                tempMax.text = String(format: "%.1f", temp_max)
            }
            if let temp_min = main["temp_min"] as? Double{
                tempMin.text = String(format: "%.1f", temp_min)
            }
        }
        if let weather = json!["weather"] as? NSDictionary {
            if let descricao = weather["description"] as? String{
                descriTempo.text = descricao
            }
        }
    }
}

