require '../lib/send'

RSpec.describe "checkout", :type => :request do
  ENV["ENVIRONMENT"] = 'test'
  # show checkout with norwegian url
  it "raises on empty configuration" do
    
    expect { 
      smtp("tmp/sample.html", false)
    }.to raise_error ArgumentError, "Misconfigured application, missing configuration"
  end

  it "raises on missing arguments in configuration" do
  end

  it "raises on malformed smtp server" do
  end

  it "raises on invalid domain" do
  end

  it "raises on invalid smtp username and recipient" do
  end

  it 'tries to contact mail server but is misconfigured(config is ok but fake username)' do
  end

end