import { Application } from "@hotwired/stimulus";
import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading";
import StimulusReflex from "stimulus_reflex";
import consumer from "channels/consumer";

const application = Application.start();

lazyLoadControllersFrom("controllers", application);

StimulusReflex.initialize(application, { consumer });

application.debug = false;
window.Stimulus = application;