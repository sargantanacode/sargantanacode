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
  $('[data-toggle="tooltip"]').tooltip();
  let menu = $('.menu')
  let menuOffset = menu.offset()
  $(window).on('scroll', function () {
    if ($(window).scrollTop() > menuOffset.top) {
      menu.addClass('sticky')
    } else {
      menu.removeClass('sticky')
    }
  })
  checkCookies()
  $("ul.navbar-nav li a.active").not('.lang').parents('li').addClass('active')
})

let copyImageLink = document.querySelector('#copy-link-image')
if (document.body.contains(copyImageLink)) {
  copyImageLink.addEventListener('click', () => {
    document.querySelector('#link').select()
    let copyAlert = document.getElementById('alert-copy-link-image')
    try {
      document.execCommand('copy')
      copyAlert.classList.remove('hidden')
      setTimeout(() => {
        copyAlert.classList.add('hidden')
      }, 2000)
    } catch (err) {
      console.log('Oops, unable to copy')
    }
  }, false)
}

let copyMarkdownImageEs = document.querySelector('#copy-markdown-image-es')
if (document.body.contains(copyMarkdownImageEs)) {
  copyMarkdownImageEs.addEventListener('click', () => {
    document.querySelector('#markdown-link-es').select()
    let copyAlert = document.getElementById('alert-copy-markdown-image-es')
    try {
      document.execCommand('copy')
      copyAlert.classList.remove('hidden')
      setTimeout(() => {
        copyAlert.classList.add('hidden')
      }, 2000)
    } catch (err) {
      console.log('Oops, unable to copy')
    }
  }, false)
}

let copyMarkdownImageEn = document.querySelector('#copy-markdown-image-en')
if (document.body.contains(copyMarkdownImageEn)) {
  copyMarkdownImageEn.addEventListener('click', () => {
    document.querySelector('#markdown-link-en').select()
    let copyAlert = document.getElementById('alert-copy-markdown-image-en')
    try {
      document.execCommand('copy')
      copyAlert.classList.remove('hidden')
      setTimeout(() => {
        copyAlert.classList.add('hidden')
      }, 2000)
    } catch (err) {
      console.log('Oops, unable to copy')
    }
  }, false)
}

let replyButton = document.querySelectorAll('.reply-button')
if (replyButton) {
  for (let i = 0; i < replyButton.length; i++) {
    replyButton[i].addEventListener('click', () => {
      let id = replyButton[i].getAttribute('id')
      let parentId = document.getElementById('comment_parent_id')
      let newComment = document.getElementById('new-comment')
      let comment = document.getElementById('comment-' + id)
      let cancelButton = document.getElementById('cancel-reply-' + id)
      let commentSection = comment.parentNode
      replyButton[i].classList.add('hidden')
      cancelButton.classList.remove('hidden')
      parentId.value = id
      commentSection.insertBefore(newComment, comment.nextSibling)
      newComment.classList.remove('mt-5')
      newComment.classList.add('mb-2')
      cancelButton.addEventListener('click', () => {
        replyButton[i].classList.remove('hidden')
        cancelButton.classList.add('hidden')
        newComment.classList.add('mt-5')
        newComment.classList.remove('mb-2')
        parentId.value = 0
        let comments = document.getElementById('comments')
        let commentSection = comments.parentNode
        commentSection.insertBefore(newComment, comments.nextSibling)
      }, false)
    }, false)
  }
}

function checkCookies() {
  if (window.localStorage.acceptCookie !== 'true') {
    let cookies = document.getElementById('cookies')
    cookies.classList.remove('hidden')
  }
}

function acceptCookies() {
  window.localStorage.setItem('acceptCookie', 'true')
  let cookies = document.getElementById('cookies')
  cookies.classList.add('hidden')
}

let acceptCookie = document.getElementById('acceptcookies')
if (document.body.contains(acceptCookie)) {
  acceptCookie.addEventListener('click', () => {
    acceptCookies()
    console.log('Acepta cookies')
  }, false)
}
