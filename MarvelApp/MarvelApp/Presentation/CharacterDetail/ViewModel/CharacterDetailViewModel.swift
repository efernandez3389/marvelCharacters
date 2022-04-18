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
    private let _error =  BehaviorSubject<String>(value: "")
    
    var characters: Driver<[Character]> {
        return _characters.asDriver(onErrorJustReturn: [])
    }
    
    var isLoading: Driver<Bool> {
        return _isLoading.asDriver(onErrorJustReturn: false)
    }
    
    var imageURLString: Driver<String?> {
        return _imageURLString.asDriver(onErrorJustReturn: nil)
    }
    
    var error: Driver<String> {
        return _error.asDriver(onErrorJustReturn: "")
    }
    
    public init(characterId: Int, getCharacterByIdUseCase: GetCharacterByIdUseCaseProtocol = GetCharacterByIdUseCase()) {
        self.characterId = characterId
        self.getCharacterByIdUseCase = getCharacterByIdUseCase
        subscribeForFetch()
    }
    
    private func subscribeForFetch() {
        fetch.withLatestFrom(Observable.combineLatest(
            isLoading.asObservable(),
            characters.asObservable(),
            imageURLString.asObservable(),
            error.asObservable()
        ))
            .subscribe(onNext: {  (isLoading, _, _, _) in
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
                self.handle(error: error)
                self._isLoading.onNext(false)
            }
        }
    }
    
    private func getCharactersValue() -> [Character] {
        if let value = try? _characters.value() {
            return value
        }
        return []
    }
    
    private func handle(error: Error) {
        var errorMessage = ""
        if let error = error as? MarvelError {
            switch error {
            case .invalidRequest:
                errorMessage =  NSLocalizedString("error.invalid.request", comment: "")
            case .parsingError:
                errorMessage =  NSLocalizedString("error.parsing", comment: "")
            case .noInternet:
                errorMessage =  NSLocalizedString("error.no.internet", comment: "")
            case .unauthorized:
                errorMessage =  NSLocalizedString("error.unauthorized", comment: "")
            case .notFound:
                errorMessage =  NSLocalizedString("error.not.found", comment: "")
            case .unknown:
                errorMessage = NSLocalizedString("error.unknown", comment: "")
            }
        } else {
            errorMessage = NSLocalizedString("error.unknown", comment: "")
        }
        
        self._error.onNext(errorMessage)
    }
}
