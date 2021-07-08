//
//  ViewController.swift
//  Image Viewer
//
//  Created by soohong ahn on 2021/07/07.
//

import UIKit

class ViewController: UITableViewController {
    
    var pictureArray = [String]()

    override func viewDidLoad () {
        super.viewDidLoad()
        title = "Famous Paintings"
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items{
            if item.hasPrefix("img"){
                pictureArray.append(item)
            }
        }
        pictureArray.sort()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictureArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = getTitle(completeName: pictureArray[indexPath.row])
        return cell
    }
    
    func getTitle(completeName: String) -> String{
        let underscoreIndex = completeName.index(after: completeName.firstIndex(of: "_")!)
        let dotIndex = completeName.index(completeName.firstIndex(of: ".")!, offsetBy: 0)
        let range = underscoreIndex..<dotIndex
        return String(completeName[range])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController{
            vc.selectedImage = pictureArray[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

