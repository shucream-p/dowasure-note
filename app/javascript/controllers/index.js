// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application";

import ModalController from "./modal_controller";
application.register("modal", ModalController);

import RemovalController from "./removal_controller";
application.register("removal", RemovalController);

import SearchFormController from "./search_form_controller";
application.register("search-form", SearchFormController);

import SortLinkController from "./sort_link_controller";
application.register("sort-link", SortLinkController);

import SwiperController from "./swiper_controller";
application.register("swiper", SwiperController);

import TagifyController from "./tagify_controller";
application.register("tagify", TagifyController);

import TextController from "./text_controller";
application.register("text", TextController);
