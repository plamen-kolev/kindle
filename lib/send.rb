require 'rubygems'
require 'bundler/setup'
require 'dotenv/load'
require 'net/smtp'
require 'mailfactory'
require 'open-uri'

def smtp(article, must_download=true)
  _load_env()
  _validate()
  local_path = ''
  if must_download
    local_path = [File.dirname(__FILE__), 'tmp', 'article.html'].join('/')
    File.open(local_path, "wb") do |file|
      open(article, "rb") do |read_file|
        file.write(read_file.read)
      end
    end
  else
    local_path = article
  end

  # check if file exists
  if not File.exists? local_path
    raise ArgumentError, "File #{local_path} not found"
  end

  # convert format to mobi
  system("ebook-convert #{local_path} #{File.dirname(__FILE__)}/tmp/article.mobi 2>&1")

  Net::SMTP.start(
    ENV['SMTP_SERVER'],
    ENV['SMTP_PORT'],
    ENV['SMTP_DOMAIN'],
    ENV['SMTP_USERNAME'],
    ENV['SMTP_PASSWORD'],
    :login
  ) do |smtp|
    mail = MailFactory.new()
    mail.to = ENV['SMTP_RECIPIENT']
    mail.from = ENV['SMTP_USERNAME']
    mail.subject = "Sending some kindle resources"
    mail.text = "Reading materials are attached to this email"
    mail.html = "<p>Reading materials are attached to this email</p>"
    mail.attach("#{File.dirname(__FILE__)}/tmp/article.mobi")

    # write mail to file if in testing
    if ENV['ENVIRONMENT'] == 'test'
      File.open('#{File.dirname(__FILE__)}/tmp/mail.log', 'a') do |file|
        file.write mail.to_s
      end
    else
      smtp.send_message mail.to_s, ENV['SMTP_USERNAME'], ENV['SMTP_RECIPIENT']
    end
    
  end
end

def _validate
  # check env file exists
  # check all env vars are there
  # check if the mail server works
end

def _load_env()
  if ENV['ENVIRONMENT'] == 'test'
    Dotenv.load("#{File.dirname(__FILE__)}/../.test.env")
  else
    Dotenv.load("#{File.dirname(__FILE__)}/../.env")
  end
end