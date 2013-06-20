# Load the rails application
require File.expand_path('../application', __FILE__)

ENV['JAVA_HOME'] = "/usr/lib/jvm/java-7-openjdk-amd64"

# Initialize the rails application
Integra1::Application.initialize!
