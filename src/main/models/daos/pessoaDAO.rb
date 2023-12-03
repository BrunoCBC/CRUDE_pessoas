require 'sqlite3'
require_relative '../entities/pessoa'
require_relative '../../utils/resultado'

class PessoaDAO
  include Resultado 

  def initialize
    @db = SQLite3::Database.new('bd.sqlite')
    @db.execute('CREATE TABLE IF NOT EXISTS pessoas (id INTEGER PRIMARY KEY NOT NULL, nome TEXT, email TEXT, idade INTEGER, telefone TEXT)')
  end

  def criar(pessoa)
    begin
      @db.execute('INSERT INTO pessoas (nome, email, idade, telefone) VALUES (?, ?, ?, ?)',
                   pessoa.nome, pessoa.email, pessoa.idade, pessoa.telefone)

      last_id = @db.last_insert_row_id

      pessoa.id = last_id

      return Resultado.sucesso('Pessoa criada com sucesso', pessoa)
    rescue SQLite3::Exception => e
      return Resultado.erro('Erro ao criar pessoa: ' + e.message)
    end
  end

  def listar
    begin
      result = @db.execute('SELECT * FROM pessoas')
      pessoas = result.map { |row| Pessoa.new(*row) } # Converter cada linha em um objeto Pessoa
      return Resultado.sucesso('Pessoas listadas com sucesso', pessoas)
    rescue SQLite3::Exception => e
      return Resultado.erro('Erro ao listar pessoas: ' + e.message)
    end
  end

  def buscar(id)
    begin
      result = @db.execute('SELECT * FROM pessoas WHERE id = ?', id)
      pessoa = result.empty? ? nil : Pessoa.new(*result.first) # Converter a primeira linha em um objeto Pessoa
      return Resultado.sucesso('Pessoa encontrada com sucesso', pessoa)
    rescue SQLite3::Exception => e
      return Resultado.erro('Erro ao buscar pessoa: ' + e.message)
    end
  end

  def editar(nova, antigo)
    begin
      @db.execute('UPDATE pessoas SET nome = ?, email = ?, idade = ?, telefone = ? WHERE id = ?',
                   nova.nome, nova.email, nova.idade, nova.telefone, antigo.id)
      return Resultado.sucesso('Pessoa editada com sucesso', nova)
    rescue SQLite3::Exception => e
      return Resultado.erro('Erro ao editar pessoa: ' + e.message)
    end
  end

  def excluir(id)
    begin
      @db.execute('DELETE FROM pessoas WHERE id = ?', id)
      return Resultado.sucesso('Pessoa excluída com sucesso', id)
    rescue SQLite3::Exception => e
      return Resultado.erro('Erro ao excluir pessoa: ' + e.message)
    end
  end
end