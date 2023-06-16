import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["questionContainer", "nextQuestion", "questionInput"];
  static values = { currentQuestion: Number, questionCount: Number };

  connect() {
    this.questionHistory = [this.element.dataset.surveyFormCurrentQuestion];
    this.updateButtons();
    const inputElement = document.getElementById('answer-input');
    inputElement.addEventListener("input", this.buildAnswer.bind(this));
  }

  updateButtons() {
    const questionContainer = this.questionContainerTarget;
    
    if (this.questionHistory.length ===1){
    } else if (this.questionHistory.length > 4) {
      this.nextQuestionTarget.textContent = "Finish";
      questionContainer.innerHTML = "";
    } else {
      this.nextQuestionTarget.textContent = "Next";
    }
  }

  nextQuestion() {
    const questionContainer = this.questionContainerTarget;
    const currentQuestionUUID = this.element.dataset.surveyFormCurrentQuestion;
    const questionURL = `/surveys/question/${currentQuestionUUID}/next`;
    const flat = false;
    this.getInfo(questionURL, questionContainer, flat)
      .then(() => {
        this.updateButtons();
      });
  }

  getInfo(questionURL, questionContainer, flat) {
    return new Promise((resolve, reject) => {
      fetch(questionURL)
        .then(response => response.json())
        .then(data => {
          const nextQuestionUUID = data.nextQuestionUUID;
          const questionHTML = data.questionHTML;
          questionContainer.innerHTML = questionHTML;
          this.element.dataset.surveyFormCurrentQuestion = nextQuestionUUID;
          if (flat === false) {
            this.questionHistory.push(nextQuestionUUID);
          }
          this.nextQuestionTarget.dataset.surveyFormNextQuestion = nextQuestionUUID;
          resolve(); 
        })
        .catch(error => {
          reject(error); 
        });
    });
  }

  buildAnswer(e) {
    this.answer = e.target.value;
  }

  saveAnswerAndNext() {
    this.saveAnswer();
    this.nextQuestion();
  }

  saveAnswer() {
    const currentQuestionUUID = this.element.dataset.surveyFormCurrentQuestion;
    const url = '/survey_questions'
    const csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content");

    const formData = new FormData()
    formData.append('question_id', currentQuestionUUID);
    formData.append('answer', this.answer);

    fetch(url, {
      method: 'POST',
      headers: {
        'X-CSRF-Token': csrfToken 
      },
      body: formData
    })
      .then(response => response.json())
      .then(data => {
        console.log(data)
      })
      .catch(error => {
        console.error(error);
      });
  }
}

