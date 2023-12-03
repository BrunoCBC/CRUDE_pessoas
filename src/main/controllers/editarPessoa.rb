require_relative '../models/repositories/repositorioPessoa'
require_relative '../utils/resultado'

class EditarPessoa
  include Resultado

  def self.exibir(repositorio_pessoa, pessoa)
    loop do
      clear_console
      puts "Edição de Pessoa\n\n"

      print "Nome (atual: #{pessoa.nome}): "
      nome = gets.chomp

      print "Email (atual: #{pessoa.email}): "
      email = gets.chomp

      print "Idade (atual: #{pessoa.idade}): "
      idade = gets.chomp.to_i

      print "Telefone (atual: #{pessoa.telefone}): "
      telefone = gets.chomp

      pessoa_existente = repositorio_pessoa.listar.comoSucesso.obj.find { |p| p.email == email && p.email != pessoa.email}

      if pessoa_existente
        resultado.erro("Email já utilizado...")
      else
        resultado = repositorio_pessoa.editar(nome, email, idade, telefone, pessoa)
      end

      if resultado.foiSucesso?
        puts resultado.msg
        print "\nDigite 'enter' para sair: "
        escolha = gets.chomp
        break
      else
        puts resultado.msg
        print "\nDigite 'enter': "
        escolha = gets.chomp
      end
    end
  end

  def self.clear_console
    if Gem.win_platform?
      system "cls"
    else
      system "clear"
    end
  end
end
