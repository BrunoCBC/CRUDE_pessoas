require_relative '../models/repositories/repositorioPessoa'
require_relative '../utils/resultado'
require_relative  'editarPessoa'

class ListarPessoa
    include Resultado

    def self.exibir(repositorioPessoa)
        resultado = repositorioPessoa.listar
      
        if resultado.foiSucesso?
            loop do
                clear_console
                pessoas = resultado.comoSucesso.obj
            
                puts "Lista de Pessoas\n\n"
                puts "ID\tNome"
                puts "===================="

                pessoas.each_with_index do |pessoa, index|
                    puts "#{index + 1}\t#{pessoa.nome}"
                end

                print "\nDigite o número da pessoa para ver detalhes(0 voltar): "
                escolha = gets.chomp
            
                if escolha.to_i > 0 && escolha.to_i <= pessoas.length
                    mostrar_detalhes(repositorioPessoa, pessoas[escolha.to_i - 1])
                elsif escolha == '0'
                    break
                end
            end
        else
          puts "Erro ao listar pessoas: #{resultado.msg}"
        end
    end      

    def self.mostrar_detalhes(repositorioPessoa, pessoa)
        loop do
            clear_console

            puts "Detalhes da Pessoa:\n\n"
            puts "ID: #{pessoa.id}"
            puts "Nome: #{pessoa.nome}"
            puts "Email: #{pessoa.email}"
            puts "Idade: #{pessoa.idade}"
            puts "Telefone: #{pessoa.telefone}"

            puts "\nOpções:"
            puts "0 - Voltar"
            puts "1 - Editar"
            puts "2 - Excluir"

            print "\nDigite o número da operação desejada e pressione ENTER: "

            escolha = gets.chomp

            case escolha
            when '0'
                break
            when '1'
                EditarPessoa.exibir(repositorioPessoa, pessoa)
            when '2'
                puts "Tem certeza que deseja deletar esta pessoa? (s/n)"
                escolha = gets.chomp.downcase
                if escolha == 's'
                    repositorioPessoa.excluir(pessoa.id)
                end
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
