#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require 'commander/import'
require 'dotenv/load'

program :name, 'kindle'
program :version, ENV['VERSION']
program :description, 'Linux and OSX command line tool for sending online articles and books to your kindle device via email. Send an html webpage directly to your kindle withing a second. The tool also enables local mobi, pdf and txt files to be sent.'

def validate
  # check env file exists
  # check all env vars are there
  # check if the mail server works
end
