" Vim syntax file
" Language:	Vue
" Author:	Ilia Loginov <iloginow@outlook.com>
" Created:	Feb 2, 2018

if !exists("main_syntax")
  if exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'vue'
endif

" ===============================================
" IMPORT PUG, JS AND STYLUS
" ===============================================
syntax include @PUG syntax/pug.vim
syntax include @JS syntax/javascript.vim
syntax include @STYL syntax/stylus.vim

" ===============================================
" MAIN TAGS
" ===============================================
syntax match vueEnclosure "\(<\|>\)"
      \ contained

highlight def link vueEnclosure SpecialChar

syntax match vueOperator "="
      \ contained

highlight def link vueOperator Operator

syntax match vueAttribute "\<\(\w\|-\)*\(\>\|=\@=\|>\@=\)"
      \ contained

highlight def link vueAttribute Type

syntax region vueString start=/\('\|"\)/ end=/\('\|"\)/
      \ contained
      \ keepend
      \ oneline

highlight def link vueString String

syntax match vueKeyword "\(<\/\=\)\@<=\(script\|style\|template\)\>"
      \ contained

highlight def link vueKeyword ModeMsg

syntax region vueMainTag matchgroup=vueEnclosure start="<\/\=\(script\|style\|template\)\@=" end=">"
      \ contains=vueKeyword,vueOperator,vueString,vueAttribute
      \ keepend
      \ oneline

" ===============================================
" DEFINE TEMPLATE, SCRIPT AND STYLE
" ===============================================

" Template
syntax region vueTemplate start="<template.\{-}>" end="<\/template>"
      \ contains=@PUG,vueMainTag,vueInterpolation
      \ keepend

" Script
syntax region vueScript start="<script.\{-}>" end="<\/script>"
      \ contains=@JS,vueMainTag
      \ keepend

" Style
syntax region vueStyle start="<style.\{-}>" end="<\/style>"
      \ contains=@STYL,vueMainTag
      \ keepend

" ===============================================
" INTERPOLATION
" ===============================================

syntax region vueInterpolation matchgroup=vueEnclosure start="{{" end="}}"
      \ contained
      \ contains=@JS
      \ keepend

let b:current_syntax = "vue"
