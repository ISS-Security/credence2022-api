# frozen_string_literal: true

require 'roda'
require 'figaro'
require 'logger'
require 'sequel'
require './app/lib/secure_db'

module Credence
  # Configuration for the API
  class Api < Roda
    plugin :environments

    # load config secrets into local environment variables (ENV)
    Figaro.application = Figaro::Application.new(
      environment: environment, # rubocop:disable Style/HashSyntax
      path: File.expand_path('config/secrets.yml')
    )
    Figaro.load
    def self.config() = Figaro.env

    # Database Setup
    db_url = ENV.delete('DATABASE_URL')
    DB = Sequel.connect("#{db_url}?encoding=utf8")
    def self.DB() = DB # rubocop:disable Naming/MethodName

    # Logger setup
    LOGGER = Logger.new($stderr)
    def self.logger() = LOGGER

    configure :development, :test do
      require 'pry'
      logger.level = Logger::ERROR
    end
  end
end
