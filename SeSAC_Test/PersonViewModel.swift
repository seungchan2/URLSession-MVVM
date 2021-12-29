//
//  PersonViewModel.swift
//  SeSAC_Test
//
//  Created by 김승찬 on 2021/12/28.
//

import Foundation

class PersonViewModel {
    
    var person: Observable<Person> = Observable(Person(page: 0, results: [], totalPages: 0, totalResults: 0))
    
    func fetchPerson(query: String, page: Int) {
        APIService.person(text: query, page: page) { response, error in
            guard let response = response else {
                return
            }
            
            self.person.value = response
        }
    }
}

extension PersonViewModel {
    var numberOfRowInSection: Int {
        return person.value.results.count
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> Result {
        return person.value.results[indexPath.row]
    }
}
