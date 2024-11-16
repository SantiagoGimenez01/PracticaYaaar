import items.*

class Pirata{
    const items = []
    var ebriedad
    var dinero

    method dinero() = dinero
    method tieneDiezItems() = items.size() > 10
    method contieneItemsNecesarios(itemBuscado) = items.find({itemPirata => itemPirata == itemBuscado})
    method gastar(monedas){
        dinero -= monedas
    }
}

class Barco{
    var misionAsignada
    const tripulantes = []
    const capacidad

    method cambiarMision(nueva){
        misionAsignada = nueva
        self.echarTripulantes(nueva)
    }

    method reclutar(pirata){
        if(self.tieneLugar()){
            tripulantes.add(pirata)
        }else{
            self.error("No hay suficiente lugar en el barco")
        }
    }

    method tieneLugar() = capacidad > tripulantes.size()

    method puedeFormarParte(pirata) = self.tieneLugar() && misionAsignada.esUtil(pirata)

    method echarTripulantes(nuevaMision) = tripulantes.filter({tripulante => nuevaMision.esUtil(tripulante)})
    
    method esTemible() = misionAsignada.puedeSerRealizadaPor(self) && tripulantes.count({pirata => misionAsignada.esUtil(pirata)}) >= 5

    method itemMasRaro() 
}

class Mision{

    method esUtil(pirata)
    method puedeSerRealizadaPor(barco)
}

class BusquedaDelTesoro inherits Mision{
    const property itemsReq = [brujula, mapa, grogXD]
    override method esUtil(pirata) = pirata.contieneItemsNecesarios(itemsReq) && pirata.dinero() <= 5
    override method puedeSerRealizadaPor(barco) = barco.tripulantes().any({tripulante => tripulante.items().contains(llaveDeCofre)})
}

class ConvertirseEnLeyenda inherits Mision{
    const itemObligatorio

    override method esUtil(pirata) = pirata.tieneDiezItems() && pirata.contieneItemsNecesarios(itemObligatorio)
    override method puedeSerRealizadaPor(barco) = true
}

class Saqueo inherits Mision{
    const victima
    var property monedasReq

    override method esUtil(pirata) = pirata.dinero() < self.monedasReq() && pirata.seAnimaASaquearA(victima)
    override method puedeSerRealizadaPor(barco) = victima.esVulnerableA(barco)
}