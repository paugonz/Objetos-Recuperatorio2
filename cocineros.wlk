import recetas.*

class Cocinero {
    var property preparaciones = #{}

    var property nivel = principiante

    method prepararExitosamente(unaReceta) {
        if(self.puedePreparar(unaReceta)) {
            preparaciones.add(unaReceta)
        }
    }

    method puedePreparar(unaReceta) {
        return nivel.puedePreparar(unaReceta, self)
    }

    method tieneRecetaSimilar(otraReceta) {
        return preparaciones.any({receta => receta.esRecetaSimilar(otraReceta)})
    }

    method experienciaCocinero() {
        return preparaciones.sum({receta => receta.experiencia()})
    }

    method superarNivel() {
        nivel = nivel.serSuperado(self)
    }

    method comidasDificiles() {
        return preparaciones.filter({receta => receta.esDificil()})
    }

    method preparoMasComidasDificilesQue(unaCantidad) {
        return self.comidasDificiles().size() > unaCantidad
    }
}

// defino los niveles

object principiante {
    method puedePreparar(unaReceta, unCocinero) {
        return !unaReceta.esDificil()
    }

    method serSuperado(unCocinero) {
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

    method serSuperado(unCocinero) {
        if(unCocinero.preparoMasComidasDificilesQue(4)) {
            return chef
        } else {
            return self
        }
    }
}

object chef {
    method puedePreparar(unaReceta, unCocinero) = true

    method serSuperado(unCocinero) {return self} // no puede avanzar mas que chef
}
