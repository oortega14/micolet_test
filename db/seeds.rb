# frozen_string_literal: true

# Spanish
survey = Survey.create(name: 'Encuesta de Bienvenida', language: 'es')
Question.create([
                  { question: '¿Como te enteraste de nuestra página?', position: 1, survey_id: survey.id },
                  { question: '¿Sientes que fue útil la información encontrada en esta página?',
                    position: 2, survey_id: survey.id },
                  { question: '¿Nos recomendarías a un conocido/a tuyo?', position: 3,
                    survey_id: survey.id },
                  { question: '¿Cuál de nuestros productos te llamó más la atención?', position: 4,
                    survey_id: survey.id }
                ])

# English
survey = Survey.create(name: 'Welcome survey', language: 'en')
Question.create([
                  { question: 'How did you find out about our page?', position: 1, survey_id: survey.id },
                  { question: 'Do you feel that the information found on the landing page was useful?', position: 2,
                    survey_id: survey.id },
                  { question: 'Would you recommend us to someone you know?', position: 3,
                    survey_id: survey.id },
                  { question: 'Which of our products caught your attention the most?', position: 4,
                    survey_id: survey.id }
                ])

# German
survey = Survey.create(name: 'Willkommensumfrage', language: 'de')
Question.create([
                  { question: 'Wie kommst du auf unsere Seite?', position: 1, survey_id: survey.id },
                  { question: 'Halten Sie die auf der Zielseite enthaltenen Informationen für nützlich?', position: 2,
                    survey_id: survey.id },
                  { question: 'Würden Sie uns jemandem empfehlen, den Sie kennen?', position: 3,
                    survey_id: survey.id },
                  { question: 'Welches unserer Produkte hat Ihre größte Aufmerksamkeit erregt?',
                    position: 4, survey_id: survey.id }
                ])

# French
survey = Survey.create(name: 'Sondage de bienvenue', language: 'fr')
Question.create([
                  { question: 'Comment avez-vous connu notre page ?', position: 1, survey_id: survey.id },
                  { question: 'Pensez-vous que les informations trouvées sur la page de destination étaient utiles ?', position: 2,
                    survey_id: survey.id },
                  { question: "Nous recommanderiez-vous à quelqu'un que vous connaissez ?", position: 3,
                    survey_id: survey.id },
                  { question: 'Lequel de nos produits a le plus retenu votre attention ?', position: 4,
                    survey_id: survey.id }
                ])
