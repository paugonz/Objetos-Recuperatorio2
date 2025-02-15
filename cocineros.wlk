class Cocinero {
    var property preparaciones = #{}

    var property nivel = principiante

    method prepararExitosamente(unaReceta) {
        if(self.puedePreparar(unaReceta)) {
            preparaciones.add(unaReceta)
        }
    }

    method puedePreparar(unaReceta) {
        return nivel.puedePreparar(unaReceta)
    }

    method tieneRecetaSimilar(otraReceta) {
        return preparaciones.any({receta => receta.esRecetaSimilar(otraReceta)})
    }

    method experiencia() {
        
    }
}

object principiante {
    method puedePreparar(unaReceta, unCocinero) {
        return !unaReceta.esDificil()
    }

}

object experimentado {
    method puedePreparar(unaReceta, unCocinero) {
        return unCocinero.tieneRecetaSimilar(unaReceta)
    }
}

object chef {
    method puedePreparar(unaReceta, unCocinero) = true
}