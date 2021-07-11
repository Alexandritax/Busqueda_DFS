require_relative "Lectura"
require "matrix"

class Matrix #esta clase representa a todas las matrizes
    def []=(i, j, x)
      @rows[i][j] = x
    end

    def pretty_print #imprime de forma bonita la matriz
        arr = @rows
        width = arr.flatten.max.to_s.size + 1 #espacios entre los valores
        puts arr.map { |a| a.map { |i| i.to_s.rjust(width) }.join } #imprime la matriz
    end #es parte del codigo de Spipe para imprimir matrices
end

def print_aristas(aristas) #imprime los vertices que componen las aristas de un grafo
    i=0
    for arista in aristas do
        verticeInicio = arista.get_verticeInicio #---------------------------------------
        verticeFin = arista.get_verticeFin       #
        valorini = verticeInicio.get_valor       # Esto obtiene datos de las aristas
        valorfin = verticeFin.get_valor          # y vertices y los mete en variables
        nameini = verticeInicio.get_name         #
        namefin = verticeFin.get_name            #---------------------------------------
        puts "(#{i}) 'Arista #{i+1}' desde el vertice #{nameini}-#{valorini} hasta el vertice #{namefin}-#{valorfin} existe."
        #imprime las aristas
        i += 1
    end
end
$matriz #contiene la matriz de adyacencia
continue = 0
while continue == 0 do #permite multiples usos del programa
    puts "(0) usar el archivo Matriz_texto.txt\n(1) usar otro archivo\n"
    opt = gets.chomp.to_i #usuario ingresa numero
    if opt == 0 then
        $matriz = Lectura.new("Matriz_texto.txt") #Crea el objeto lectura que utiliza el archivo de texto
    else
        puts "El archivo de texto debe estar dentro de la carpeta Proyecto\n"
        puts "Ingrese el nombre del archivo (no olvidar la extension .txt): "
        archivo = gets.chomp #el usuario ingresa el nombre del archivo de texto
        $matriz = Lectura.new(archivo)
    end
    mat = $matriz.generate_matriz #Genera la matriz de adyacencia desde el texto
    #mat.each_with_index {|val,index1,index2| puts "#{val} => #{index1}-#{index2}"}
    puts "*"*100
=begin
mat.each_with_index {|val,index1,index2|
    if val==1
        puts "#{index1}-#{index2}"
    end
}
=end
    graf = $matriz.crear_grafo(mat) #Crea el grafo desde el archivo
    vertices = graf.get_vertices #obtiene la lista de vertices del grafo
    numVertices = vertices.length #obtiene el numero de vertices del grafo
    puts "Vertices en el grafo:\n"
    for vertice in vertices do
        valor = vertice.get_valor
        name = vertice.get_name
        puts "(#{valor-1}) Vertice #{name}-#{valor}"
    end
    puts "ingrese el numero por donde se iniciara la busqueda por profundidad: "
    indexV = gets.chomp.to_i #usuario ingresa numero
    while indexV > numVertices-1 do #si se ingresa un numero de vertice mayor a la cantidad de vertices
        puts "Error: Numero de vertices excedido.\nIntente otra vez: "
        intedxV = gets.chomp.to_i #vuelve a preguntar por un numero
    end
    puts "*"*100
    aristas = graf.get_aristas #obtiene la lista de aristas del grafo
    puts "Arista del grafo original:\n"
    print_aristas(aristas)
    puts "*"*100
    grafoDFS = $matriz.crear_grafoDFS(graf,vertices[indexV]) #genera el grafo resultante de la busqueda DFS
    aristasDFS = grafoDFS.get_aristas #obtiene las aristas del grafoDFS
    puts "Aristas del arbol de la busqueda DFS:\n"  
    print_aristas(aristasDFS)
    puts "*"*100
    matrizDFS = grafoDFS.generate_matriz #genera la matriz del objeto grafoDFS
    puts "Matriz de adyacencia del grafo DFS:\n\n"
    matrizDFS.pretty_print
    grafoDFS.reset #resetea las variables globales de la clase grafo
    puts "\n Va a hacer otra busqueda?: "
    puts "(0) Si\n(1) No"
    continue = gets.chomp.to_i #usuario ingresa un numero por si quiere seguir o no
    system("clear") || system("cls") #limpia la interfaz
end