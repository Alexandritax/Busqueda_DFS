require_relative "Vertice"
require_relative "Arista"
require "matrix"
class Grafo
    $padres=[]          # Variables globales para la #
    $aristasDFS=[]      #        busqueda DFS        #
    def initialize(vertices, aristas)
        @vertices = vertices
        @aristas = aristas
        i=0
        for vertice in vertices do #inicializa la variable global para que tenga la misma cantidad de 0's como cantidad de vertices en el grafo
            $padres[i] = 0
            i += 1
        end
    end
    attr_reader :vertices, :aristas
    
    def get_vertices
        return vertices
    end
    
    def get_aristas
        return aristas
    end
        
    def DFS(vertice) #buscara primero los vertices con valores menores y luego los vertices con valores mayores
        index = vertice.get_valor - 1 # se obtiene el index del vertice
        $padres[index]=1   # la variable global registra que este vertice a sido visitado
            for arista in aristas do                            #
                if arista.get_verticeInicio == vertice then     # recorriendo las aristas se busca si alguno de los vertices iniciales
                    verticeF=arista.get_verticeFin              # de las aristas coinciden con nuestro vertice por donde empezara el recorrido
                    if  $padres[verticeF.get_valor-1] == 0 then # DFS. En caso sea asi, se verifica que el vertice final de la arista no haya sido
                        $aristasDFS.push(arista)                # visitado previamente, siendo asi que se añade la arista la variable global que
                        DFS(verticeF)                           # que almacenara las aristas que resulten de esta busqueda.
                    end                                         #
                end
            end
        newaristas = $aristasDFS #se pasa de la variable global a una variable local que sera retornada
        return newaristas
    end

    def reset #resetea las listas globales para futuras busquedas
        $padres = []
        $aristasDFS = []
    end

    def generate_matriz # genera una matriz de un grafo
        num = vertices.length
        matriz=Matrix.zero(num)
        i=0
        for linea in matriz do
            j=0
            for dato in matriz do
                for arista in aristas do
                    i_arista = arista.get_verticeInicio.get_valor - 1
                    j_arista = arista.get_verticeFin.get_valor - 1
                    if i == i_arista and j== j_arista then
                        matriz[i,j] += 1 #recorre la matriz y modifica los valores si los indices de los vertices inical y final de la arista
                    end                  #coinciden con los indices de la matriz
                end
                j += 1
            end
            i += 1
        end
        return matriz
    end

end