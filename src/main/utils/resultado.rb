# resultado.rb
module Resultado
  class Resultado
    attr_reader :msg

    def initialize(msg)
      @msg = msg
    end

    def self.sucesso(msg, obj)
      Sucesso.new(msg, obj)
    end

    def self.erro(msg)
      Erro.new(msg)
    end

    def foiErro?
      instance_of?(Erro)
    end

    def foiSucesso?
      instance_of?(Sucesso)
    end

    def comoErro
      self
    end

    def comoSucesso
      self
    end
  end

  class Sucesso < Resultado
    attr_reader :obj

    def initialize(msg, obj)
      super(msg)
      @obj = obj
    end
  end

  class Erro < Resultado
  end
end