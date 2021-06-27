class Arista
    def initialize(verticeInicio,verticeFin) #la arista se compondra de un vertice de inicio y un vertice final
        @verticeInicio = verticeInicio
        @verticeFin = verticeFin
    end
    attr_reader :verticeInicio, :verticeFin

    def get_verticeInicio
        return verticeInicio
    end

    def get_verticeFin
        return verticeFin
    end


end