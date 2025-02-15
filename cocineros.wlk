import recetas.*

class Cocinero {
    var property preparaciones = #{}

    var property nivel = principiante

    //PUNTO 3
    method prepararComida(unaReceta) {
        if(self.puedePreparar(unaReceta)) {
            preparaciones.add(unaReceta)
            self.evaluarNivel()
        }
    }

    method puedePreparar(unaReceta) {
        return nivel.puedePreparar(unaReceta, self)
    }

    method recetasSimilares(unaReceta) {
        return preparaciones.filter({receta => receta.esRecetaSimilar(unaReceta)})
    }

    method tieneRecetaSimilar(otraReceta) {
        return preparaciones.any({receta => receta.esRecetaSimilar(otraReceta)})
    }

    //PUNTO 1
    method experienciaCocinero() {
        return preparaciones.sum({receta => receta.experiencia(self)})
    }

    //PUNTO 2 (logica en cada nivel)
    method evaluarNivel() {
        nivel = nivel.evaluarNivel(self)
    }

    method comidasDificiles() {
        return preparaciones.filter({receta => receta.esDificil()})
    }

    method preparoMasComidasDificilesQue(unaCantidad) {
        return self.comidasDificiles().size() > unaCantidad
    }

    method experienciaAdquirida(unaReceta) {
        return self.recetasSimilares(unaReceta).sum({receta => receta.experiencia(self)})
    }
    method perfecciono(unaReceta) {
        return self.experienciaAdquirida(unaReceta) * 3 > unaReceta.experiencia(self)
    }

    method recetaMasExitosa(recetas) {
        return recetas.max({receta => receta.experiencia(self)})
    }
}

// defino los niveles

object principiante {
    method puedePreparar(unaReceta, unCocinero) {
        return !unaReceta.esDificil()
    }

    method calidad(unaReceta, unCocinero) {
        if(unaReceta.tieneMenosIngredientesQue(4)) {
            return normal
        } else {
            return pobre
        }
    }

    //PUNTO 2
    method evaluarNivel(unCocinero) {
        if(unCocinero.experienciaCocinero() > 100) {
            return experimentado
        } else {
            return self
        }
    }
}

object experimentado {
    method puedePreparar(unaReceta, unCocinero) {
        return unCocinero.tieneRecetaSimilar(unaReceta)
    }

    method calidad(unaReceta, unCocinero) {
        if(unCocinero.perfecciono(unaReceta)) {
            return new Superior(plus = unCocinero.recetasSimilares(unaReceta))
        } else {
            return normal
        }
    }

    //PUNTO 2
    method evaluarNivel(unCocinero) {
        if(unCocinero.preparoMasComidasDificilesQue(4)) {
            return chef
        } else {
            return self
        }
    }
}

object chef {
    method puedePreparar(unaReceta, unCocinero) = true

    //PUNTO 2
    method evaluarNivel(unCocinero) {return self}
     // no puede avanzar mas que chef

    method calidad(unaReceta, unCocinero) {
        if(unCocinero.perfecciono(unaReceta)) {
            return new Superior(plus = unCocinero.recetasSimilares(unaReceta))
        } else {
            return normal
        }
    }
}
