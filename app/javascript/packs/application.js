/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import $ from 'jquery'
import Rails from 'rails-ujs'
import hljs from 'highlight.js'
import 'bootstrap'
import 'bootstrap/scss/bootstrap.scss'
import 'highlight.js/styles/monokai-sublime.css'
import 'normalize.css/normalize.css'
import 'font-awesome/scss/font-awesome.scss'

global.$ = $
global.jQuery = $
Rails.start()
global.Rails = Rails

require.context('../stylesheets/', true, /^\.\/[^_].*\.(css|scss|sass)$/i)
require.context('../images/', true, /\.(gif|jpg|png|svg)$/i)

hljs.initHighlightingOnLoad()

$(document).ready(function () {
  let menu = $('.menu')
  let menuOffset = menu.offset()
  $(window).on('scroll', function () {
    if ($(window).scrollTop() > menuOffset.top) {
      menu.addClass('sticky')
    } else {
      menu.removeClass('sticky')
    }
  })
})
