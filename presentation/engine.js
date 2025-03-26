const { Marp } = require('@marp-team/marp-core')

const markdownItInclude = require('markdown-it-include');

module.exports = (opts) => new Marp(opts).use(markdownItInclude, { root: '../' })