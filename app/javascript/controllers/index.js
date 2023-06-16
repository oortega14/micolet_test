import { application } from "./application"

import FormController from "./form_controller"
application.register("form", FormController)

import NotificationsController from "./notifications_controller"
application.register("notifications", NotificationsController)

import SurveyFormController from "./survey_form_controller"
application.register("survey-form", SurveyFormController)
