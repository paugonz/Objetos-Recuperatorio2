//PUNTO 5
object academia {
    var property estudiantes = #{}
    var property recetario = #{}

    method entrenarAEstudiantes() {
        estudiantes.forEach({estudiante => estudiante.prepararComida(estudiante.recetaMasExitosa(recetario))})
    }  

}
