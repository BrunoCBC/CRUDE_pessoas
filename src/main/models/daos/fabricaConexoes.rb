require 'sqlite3'
require 'singleton'

class FabricaConexoes
  include Singleton

  MAX_CONNECTIONS = 5

  def initialize
    @conexoes = Array.new(MAX_CONNECTIONS)
    # Carregar dados de conexão do .env
    @url_db = ENV['URL_DB']
    @db_name = ENV['DB_NAME']
    @con_string = "#{@url_db}/#{@db_name}"
    @user = ENV['DB_USER']
    @password = ENV['DB_PASSWORD']
  end

  def get_connection
    MAX_CONNECTIONS.times do |i|
      if @conexoes[i].nil? || @conexoes[i].closed?
        @conexoes[i] = SQLite3::Database.new(@con_string)
        @conexoes[i].execute("PRAGMA foreign_keys = ON;") # Ativar suporte a chaves estrangeiras
        return @conexoes[i]
      end
    end
    raise SQLite3::SQLException, 'Máximo de conexões atingido'
  end
end