//
//  CategoryViewController.swift
//  PokedexLab
//
//  Created by SAMEER SURESH on 2/25/17.
//  Copyright © 2017 iOS Decal. All rights reserved.
//  To do: displays a list of Pokemon which belong to the selected category. You will have to implement all of the tableview functionality for this class.

import UIKit

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var pokeTableView: UITableView!
    var pokemonArray: [Pokemon]?
    var cachedImages: [Int:UIImage] = [:]
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokeTableView.delegate = self
        pokeTableView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let list = pokemonArray {
            return list.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let pokeInfo = tableView.dequeueReusableCell(withIdentifier: "pokeInfo") as? PokeTableViewCell {
            let pokemon = pokemonArray![indexPath.item]
            
            if let image = cachedImages[indexPath.row] {
                pokeInfo.pokeimage.image = image
            } else {
                pokeInfo.pokeimage.image = nil
                if let url = URL(string: pokemon.imageUrl) {
                let session = URLSession(configuration: .default)
                let downloadPicTask = session.dataTask(with: url) { (data, response, error) in
                    if let e = error {
                        print("Error downloading picture: \(e)")
                    } else {
                        if let _ = response as? HTTPURLResponse {
                            if let imageData = data {
                                let image = UIImage(data: imageData)
                                DispatchQueue.main.async {
                                    self.cachedImages[indexPath.row] = image
                                    pokeInfo.pokeimage.image = image // UIImage(data: imageData)
                                }
                            } else {
                                print("Couldn't get image: Image is nil")
                            }
                        } else {
                            print("Couldn't get response code")
                        }
                    }
                }
                downloadPicTask.resume()
                }
            }
            
            pokeInfo.name.text = pokemon.name
            pokeInfo.number.text = "\(pokemon.number!)"
            pokeInfo.keyStats.text = "\(pokemon.attack!) / \(pokemon.defense!) / \(pokemon.health!)"
            
            return pokeInfo
        }
            
        else {
            print("Error creating pokemon table view cell")
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        performSegue(withIdentifier: "toInfoVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PokemonInfoViewController{
            destination.pokemon = pokemonArray![selectedIndexPath!.item]
            destination.image = self.cachedImages[selectedIndexPath!.item]
        }
    }
    



}
