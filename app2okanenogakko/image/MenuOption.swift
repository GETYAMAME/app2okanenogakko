//
//  MenuOption.swift
//  appokanenogakko
//
//  Created by mac user on 2019/05/20.
//  Copyright © 2019 mycompany. All rights reserved.
//
enum MenuOption: Int,CustomStringConvertible {
    
    case about
    case first_challenge
    case company
    case contact

    var description: String {
        switch self {
        case .about: return "私たちについて"
        case .first_challenge: return "初めて学ぶ方へ"
        case .company: return "運営会社"
        case .contact: return "お問い合わせ"
        }
    }
    

}
