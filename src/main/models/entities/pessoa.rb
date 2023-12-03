class Pessoa
    attr_accessor :id, :nome, :email, :idade, :telefone

    def initialize(id, nome, email, idade, telefone)
        @id = id
        @nome = nome
        @email = email
        @idade = idade
        @telefone = telefone
    end
end