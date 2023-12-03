require_relative '../entities/pessoa'
require_relative '../daos/pessoaDAO'
require_relative '../../utils/resultado'

class RepositorioPessoa
  include Resultado

  def initialize(dao)
    @dao = dao
  end
  

  def cadastrar(nome, email, idade, telefone)
    if nome.empty? || !nome.is_a?(String)
      return Resultado.erro('Nome inválido')
    end

    if email.empty? || !email.is_a?(String)
      return Resultado.erro('E-mail inválido')
    end

    if idade < 0 || !idade.is_a?(Integer)
      return Resultado.erro('Idade inválida')
    end

    if telefone.empty? || !telefone.is_a?(String)
      return Resultado.erro('Telefone inválido')
    end

    pessoa = Pessoa.new(nil, nome, email, idade, telefone)
    return @dao.criar(pessoa)
  end

  def listar
    return @dao.listar
  end

  def buscar(id)
    return @dao.buscar(id)
  end

  def editar(nome, email, idade, telefone, antigo)
    if nome.empty? || !nome.is_a?(String)
      return Resultado.erro('Nome inválido')
    end

    if email.empty? || !email.is_a?(String)
      return Resultado.erro('E-mail inválido')
    end

    if idade < 0 || !idade.is_a?(Integer)
      return Resultado.erro('Idade inválida')
    end

    if telefone.empty? || !telefone.is_a?(String)
      return Resultado.erro('Telefone inválido')
    end

    nova = Pessoa.new(nil, nome, email, idade, telefone)
    return @dao.editar(nova, antigo)
  end

  def excluir(id)
    return @dao.excluir(id)
  end
end
