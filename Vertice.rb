class Vertice
    def initialize(valor,name) #El vertices esta compuesto de valor que funcionara indirectamente como un index y un nombre para una facil identificacion
        @valor = valor
        @name = name
    end
    attr_reader :valor, :name

    def get_valor
        return valor
    end

    def get_name
        return name
    end
    
end