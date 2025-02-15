import cocineros.*

class Receta {
    var property ingredientes = #{}
    const property dificultad


    method tipoComida(cocinero) {
        return self.tipoComidaSegunNivel(cocinero)
    }

    method tipoComidaSegunNivel(cocinero) {
        return cocinero.nivel().calidad(self, cocinero)
    }

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
        return (self.dificultad() - otraReceta.dificultad()).abs() < 1 
    }

    method esRecetaSimilar(otraReceta) {
        return self.tieneLosMismosIngredientes(otraReceta) || self.tieneDificultadSimilar(otraReceta)
    }

    method experienciaNormal() {
        return self.cantidadIngredientes() * self.dificultad()
    }

    method experiencia(cocinero) {
        return self.tipoComida(cocinero).experienciaReceta(self)
    }

    method tieneMenosIngredientesQue(unaCantidad) {
        return self.cantidadIngredientes() < unaCantidad
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

class Superior {
    const property plus // inicializo para poder usar, se determina al momento de preparacion

    method experienciaReceta(unaReceta) {
        return unaReceta.experienciaNormal() + plus
    }
}

// PUNTO 4
class RecetaGourmet inherits Receta {
    override method experiencia(cocinero) {
        return super(cocinero) * 2
    }

    override method esDificil() = true
}
