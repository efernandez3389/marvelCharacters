//
//  CharacterDetailViewModel.swift
//  MarvelApp
//
//  Created by Estefania Fernandez on 7/4/22.
//

import Foundation
import RxSwift
import RxCocoa

public class CharacterDetailViewModel {

    let getCharacterByIdUseCase: GetCharacterByIdUseCaseProtocol
    let characterId: Int
    
    public let fetch = PublishSubject<()>()
    private let disposeBag = DisposeBag()
    
    public let _characters = BehaviorSubject<[Character]>(value: [])
    private let _isLoading =  BehaviorSubject<Bool>(value: false)
    private let _imageURLString =  BehaviorRelay<String?>(value: nil)
    
    var characters: Driver<[Character]> {
        return _characters.asDriver(onErrorJustReturn: [])
    }
    
    var isLoading: Driver<Bool> {
        return _isLoading.asDriver(onErrorJustReturn: false)
    }
    
    var imageURLString: Driver<String?> {
        return _imageURLString.asDriver(onErrorJustReturn: nil)
    }
    
    public init(characterId: Int, getCharacterByIdUseCase: GetCharacterByIdUseCaseProtocol = GetCharacterByIdUseCase()) {
        self.characterId = characterId
        self.getCharacterByIdUseCase = getCharacterByIdUseCase
        subscribeForFetch()
    }
    
    private func subscribeForFetch() {
        fetch.withLatestFrom(Observable.combineLatest(isLoading.asObservable(), characters.asObservable(), imageURLString.asObservable()))
            .subscribe(onNext: {  (isLoading, _, _) in
                guard !isLoading else {return}
                self.getCharacterById()
            }).disposed(by: disposeBag)
    }
    
    private func getCharacterById() {
        _isLoading.onNext(true)
        getCharacterByIdUseCase.execute(id: self.characterId) { (result)  in
            switch result {
            case .success(let response):
                
                self._imageURLString.accept(response.data.results.first?.thumbnail.getUrlString(quality: .landscape)) 
                self._characters.onNext(response.data.results)
                self._isLoading.onNext(false)
            case .failure(let error):
                print("ERROR")
            }
        }
    }
    
    private func getCharactersValue() -> [Character] {
        if let value = try? _characters.value() {
            return value
        }
        return []
    }
}
