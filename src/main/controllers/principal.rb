require_relative 'cadastrarPessoa'
require_relative 'listarPessoa'

class Principal
  def self.exibir(repositorio_pessoa)
    loop do
      clear_console
      puts "Seja bem-vindo ao Sistema de CRUD de Pessoas!"
      puts "\n\nEscolha uma opção:"
      puts "\n0. Sair"
      puts "1. Cadastrar Nova Pessoa"
      puts "2. Listar Pessoas Cadastradas\n\n"

      print "Digite o número da opção desejada e pressione ENTER: "
      opcao = gets.chomp
      clear_console

      case opcao
      when '0'
        break
      when '1'
        CadastrarPessoa.exibir(repositorio_pessoa)
      when '2'
        ListarPessoa.exibir(repositorio_pessoa)
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