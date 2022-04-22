//
//  String+Localization.swift
//  MarvelApp
//
//  Created by Estefania Fernandez on 22/4/22.
//
import UIKit

extension String {

  var localized: String {
    return NSLocalizedString(self, comment: "\(self)_comment")
  }
}
