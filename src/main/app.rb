require_relative 'controllers/principal'
require_relative 'models/repositories/repositorioPessoa'
require_relative 'models/daos/pessoaDAO'

pessoa_dao = PessoaDAO.new
repositorio_pessoa = RepositorioPessoa.new(pessoa_dao)

Principal.exibir(repositorio_pessoa)