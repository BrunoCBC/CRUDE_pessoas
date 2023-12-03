require_relative '../models/repositories/repositorioPessoa'
require_relative '../utils/resultado'

class CadastrarPessoa
  include Resultado

  def self.exibir(repositorio_pessoa)
    loop do
      clear_console
      puts "Cadastro de Pessoa\n\n"

      print "Nome: "
      nome = gets.chomp

      print "Email: "
      email = gets.chomp

      print "Idade: "
      idade = gets.chomp.to_i

      print "Telefone: "
      telefone = gets.chomp

      pessoa_existente = repositorio_pessoa.listar.comoSucesso.obj.find { |p| p.email == email }

      if pessoa_existente
        puts "Pessoa já existe. Deseja editar?"
        print "Digite 's' para editar ou 'n' para cancelar: "
        escolha = gets.chomp.downcase

        if escolha == 's'
          resultado = repositorio_pessoa.editar(nome, email, idade, telefone, pessoa_existente)
        else
          resultado = Resultado.erro('Cadastro cancelado.')
        end
      else
        resultado = repositorio_pessoa.cadastrar(nome, email, idade, telefone)
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