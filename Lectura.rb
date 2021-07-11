require "matrix"
require_relative "Vertice"
require_relative "Arista"
require_relative "Grafo"

def get_num_vertices(thefile)
    content = File.read(thefile) # Lee el archivo
    lines = content.split("\n")  # Recorre el archivo de texto y para obtener
    num = lines.length           # el numero de vertices.
    return num
end

class Lectura
    def initialize(thefile)
        @thefile = thefile
    end
    attr_reader :thefile

    def generate_matriz #genera la matriz del archivo de texto
        num = get_num_vertices(thefile)  
        matriz=Matrix.zero(num) #genera una matriz cuadrada de num x num con todos sus valores en 0
        i = 0                               #------------------------------------------------------#
        File.foreach(thefile) do |line|     #                                                      #
            j=0                             #     transfiere los datos del texto a la matriz       #
            for data in line.split("\t") do #    para ser luego utilizada para crear los grafos    #
                matriz[i,j] += data.to_i    #                                                      #
                j +=1                       #------------------------------------------------------#
            end                             
            i +=1                           
        end                                 
        return matriz
    end

    def crear_grafo(matriz)
        numeroVertices=get_num_vertices(thefile)
        aristas = []
        vertices = []
        numeroVertices.times do |n| #n sera el indice que recorrera hasta numeroVertices veces
            if (65 + n <= 90)
                name = (65 + n).chr # .chr transforma un numero a un caracter
            else
                name = ""
                ((65 + n) / 26).times do |n|
                    name +=  ((65 + n) / 26).chr #genera una cadena con un valor similar a excel => AA, AB, AC, etc| si y solo si se excede de los 25 caracteres disponibles
                end
            end
            #El codigo para generar el name del vertice es parte del codigo de Spipe   
            vertices.push(Vertice.new(n + 1, name)) #inserta dentro del array vertices un nuevo vertice
        end

        matriz.each_with_index {|val,index1,index2| # las variables val,index1,index2 son parte indices de la matriz y recorrera la matriz dato por dato
            if val == 1
                aristas.push(Arista.new(vertices[index1], vertices[index2])) # si el valor es 1 se tomaran como vertices inicial y final los que tengan la posicion index1,index2 dentro del array vertices
            end
        }
        graf = Grafo.new(vertices,aristas) # se crea el grafo con la lista de vertices y aristas
        return graf        
    end

    def crear_grafoDFS(grafo,verticeInicio)
        vertices =grafo.get_vertices #obtiene los vertices del grafo para reutilizar
        aristas = grafo.DFS(verticeInicio) # las aristas se obtienen de la funcion DFS del objeto grafo
        graforesultante = Grafo.new(vertices,aristas) # el grafo tendra los mismos vertices
        return graforesultante
    end

end
