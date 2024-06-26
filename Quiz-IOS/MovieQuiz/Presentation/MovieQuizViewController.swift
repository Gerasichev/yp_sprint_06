import UIKit

final class MovieQuizViewController: UIViewController {
    @IBOutlet private weak var noButton: UIButton!
    @IBOutlet private weak var yesButton: UIButton!
    @IBOutlet private weak var questionLabel: UILabel!
    @IBOutlet private weak var questionTitleLabel: UILabel!
    @IBOutlet private weak var indexLabel: UILabel!
    @IBOutlet private weak var previewImage: UIImageView!
    @IBOutlet private weak var ActivityIndicator: UIActivityIndicatorView!

    private var presenter: MovieQuizPresenter!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = MovieQuizPresenter(viewController: self)

        previewImage.layer.cornerRadius = 20
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - Actions

    @IBAction private func yesButtonClicked(_ sender: UIButton) {
        presenter.yesButtonClicked()
    }

    @IBAction private func noButtonClicked(_ sender: UIButton) {
        presenter.noButtonClicked()
    }

    // MARK: - Private functions

    func show(quiz step: QuizStepViewModel) {
        previewImage.layer.borderColor = UIColor.clear.cgColor
        previewImage.image = step.image
        questionLabel.text = step.question
        indexLabel.text = step.questionNumber
    }

    func show(quiz result: QuizResultsViewModel) {
        let message = presenter.makeResultsMessage()

        let alert = UIAlertController(
            title: result.title,
            message: message,
            preferredStyle: .alert)

            let action = UIAlertAction(title: result.buttonText, style: .default) { [weak self] _ in
                guard let self = self else { return }

                self.presenter.restartGame()
            }

        alert.addAction(action)

        self.present(alert, animated: true, completion: nil)
    }

    func highlightImageBorder(isCorrectAnswer: Bool) {
        previewImage.layer.masksToBounds = true
        previewImage.layer.borderWidth = 8
        previewImage.layer.borderColor = isCorrectAnswer ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor
    }

    func showLoadingIndicator() {
        ActivityIndicator.isHidden = false // говорим, что индикатор загрузки не скрыт
        ActivityIndicator.startAnimating() // включаем анимацию
    }

    func hideLoadingIndicator() {
        ActivityIndicator.isHidden = true
    }

    func showNetworkError(message: String) {
        hideLoadingIndicator()

        let alert = UIAlertController(
            title: "Ошибка",
            message: message,
            preferredStyle: .alert)

            let action = UIAlertAction(title: "Попробовать ещё раз",
            style: .default) { [weak self] _ in
                guard let self = self else { return }

                self.presenter.restartGame()
            }

        alert.addAction(action)
    }
}
