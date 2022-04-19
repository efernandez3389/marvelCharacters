//
//  CharacterListViewModel.swift
//  MarvelApp
//
//  Created by Estefania Fernandez on 6/4/22.
//

import Foundation
import RxSwift
import RxCocoa

public class CharacterListViewModel {
 
    let getCharactersUseCase: GetCharactersUseCaseProtocol
    
    public let fetch = PublishSubject<()>()
    private let disposeBag = DisposeBag()
    private let appNavigator: AppNavigator

    public let _characters = BehaviorSubject<[Character]>(value: [])
    private let _isLoading =  BehaviorSubject<Bool>(value: false)
    private let _error =  BehaviorSubject<String>(value: "")
    
    var characters: Driver<[Character]> {
        return _characters.asDriver(onErrorJustReturn: [])
    }
    var isLoading: Driver<Bool> {
        return _isLoading.asDriver(onErrorJustReturn: false)
    }
    var error: Driver<String> {
        return _error.asDriver(onErrorJustReturn: "")
    }
    
    public init(getCharactersUseCase: GetCharactersUseCaseProtocol, appNavigator: AppNavigator) {
        self.getCharactersUseCase = getCharactersUseCase
        self.appNavigator = appNavigator
        subscribeForFetch()
    }
    
    private func subscribeForFetch() {
        fetch.withLatestFrom(Observable.combineLatest(isLoading.asObservable(), characters.asObservable(), error.asObservable()))
            .subscribe(onNext: {  (isLoading, _, _) in
                guard !isLoading else {return}
                self.getCharacters()
            }).disposed(by: disposeBag)
    }
    
    public func getCharacters() {
        _isLoading.onNext(true)
        getCharactersUseCase.execute(offset: numberOfCharacters) { (result)  in
            switch result {
            case .success(let response):
                self._characters.onNext(self.getCharactersValue() + response)
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
    
    var numberOfCharacters: Int {
        return getCharactersValue().count
    }
    
    func characterAtIndex(index: Int) -> Character {
        return  getCharactersValue()[index]
    }
    
    func characterViewModelCellForCharacterAtIndex(index: Int) -> CharacterTableViewCellViewModel {
        return CharacterTableViewCellViewModel(character: characterAtIndex(index: index))
    }
    
    func characterSelectedAtIndex(index: Int) {
        appNavigator.navigate(to: .characterDetails(characterId: characterAtIndex(index: index).id))
        
    }
}
