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
    
    public let _characters = BehaviorSubject<Character?>(value: nil)
    private let _isLoading =  BehaviorSubject<Bool>(value: false)
    private let _imageURLString =  BehaviorRelay<String?>(value: nil)
    private let _error =  BehaviorSubject<String>(value: "")
    
    var characters: Driver<Character?> {
        return _characters.asDriver(onErrorJustReturn: nil)
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
    
    public init(characterId: Int, getCharacterByIdUseCase: GetCharacterByIdUseCaseProtocol) {
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
    
    public func getCharacterById() {
        _isLoading.onNext(true)
        getCharacterByIdUseCase.execute(id: self.characterId) { (result)  in
            switch result {
            case .success(let response):
                
                self._imageURLString.accept(response.thumbnail.getUrlString(quality: .landscape))
                self._characters.onNext(response)
                self._isLoading.onNext(false)
            case .failure(let error):
                self.handle(error: error)
                self._isLoading.onNext(false)
            }
        }
    }
    
    private func handle(error: Error) {
        var errorMessage = ""
        if let error = error as? MarvelError {
            switch error {
            case .invalidRequest:
                errorMessage =  "error.invalid.request".localized
            case .parsingError:
                errorMessage =  "error.parsing".localized
            case .noInternet:
                errorMessage =  "error.no.internet".localized
            case .unauthorized:
                errorMessage =  "error.unauthorized".localized
            case .notFound:
                errorMessage =  "error.not.found".localized
            case .unknown:
                errorMessage = "error.unknown".localized
            }
        } else {
            errorMessage = "error.unknown".localized
        }
        
        self._error.onNext(errorMessage)
    }
}
