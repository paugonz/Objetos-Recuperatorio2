class Receta {
    var property ingredientes = #{}
    const property dificultad

    var tipoComida  //pobre, normal, superior

    method cantidadIngredientes() {
        return ingredientes.size()
    }

    method esDificil() {
        return (dificultad > 5) || (self.cantidadIngredientes() > 10)
    }

    method tieneLosMismosIngredientes(otraReceta) {
        return self.ingredientes() == otraReceta.ingredientes()
    }

    method tieneDificultadSimilar(otraReceta) {
        return (self.dificultad() - otraReceta.dificultad()) < 1 
    }

    method esRecetaSimilar(otraReceta) {
        return self.tieneLosMismosIngredientes(otraReceta) || self.tieneDificultadSimilar(otraReceta)
    }

    method experienciaNormal() {
        return self.cantidadIngredientes() * self.dificultad()
    }
}

//Calidad comida
object normal {
    method experienciaReceta(unaReceta) {
        return unaReceta.experienciaNormal()
    }
}
object pobre {
    var property experienciaMaxima = 100 //

    method experienciaReceta(unaReceta) {
        return 
    }
}


const salsa = new Receta(ingredientes = #{"tomate", "carne", "sal"}, dificultad = 10, tipoComida = "normal")
const salsa2 = new Receta(ingredientes = #{"carne", "sal", "tomate"}, dificultad = 9, tipoComida = "normal")
const salsa3 = new Receta(ingredientes = #{"carne", "sal", "tomate", "agua"}, dificultad = 8, tipoComida = "normal")

