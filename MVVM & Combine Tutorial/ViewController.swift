//
//  ViewController.swift
//  MVVM & Combine Tutorial
//
//  Created by Akshay  on 2024-05-29.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func refreshBtnAction(_ sender: Any) {
        
    }
    
    protocol QuoteServiceType {
        func getRandomQuote() -> AnyPublisher<Quote, Error>
    }
    
    class QuoteService: QuoteServiceType {
        
        func getRandomQuote() -> AnyPublisher<ViewController.Quote, any Error> {
            let url = URL(string: "https://api.quotable.io/random")!
            return URLSession.shared.dataTaskPublisher(for: url)
                .catch { error in
                    return Fail(error: error).eraseToAnyPublisher()
                }.map({ $0.data })
                .decode(type: Quote.self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
        }
        
        
    }
    
    struct Quote: Decodable {
        let content: String
        let author: String
    }
    
}

