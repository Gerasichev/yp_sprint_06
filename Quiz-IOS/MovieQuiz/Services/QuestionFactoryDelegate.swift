//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Герасичев Сергей on 07.05.2024.
//

import Foundation
import UIKit

protocol QuestionFactoryDelegate {
    func didReceiveNextQuestion(question: QuizQuestion?)
    func didLoadDataFromServer() // сообщение об успешной загрузке
    func didFailToLoadData(with error: Error) // сообщение об ошибке загрузки
}
