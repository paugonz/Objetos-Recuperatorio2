import cocineros.*

class Receta {
    var property ingredientes = #{}
    const property dificultad

    var property tipoComida  //pobre, normal, superior

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

    method experiencia() {
        return tipoComida.experienciaReceta(self)
    }

}

//Calidad comida
object normal {
    method experienciaReceta(unaReceta) {
        return unaReceta.experienciaNormal()
    }
}
object pobre {
    var property experienciaMaxima = 100 //inicializo para poder usar

    method experienciaReceta(unaReceta) {
        return unaReceta.experienciaNormal().min(experienciaMaxima)
    }
}

object superior {
    var property plus = 0 // inicializo para poder usar, se determina al momento de preparacion

    method experienciaReceta(unaReceta) {
        return unaReceta.experienciaNormal() + plus
    }
}

