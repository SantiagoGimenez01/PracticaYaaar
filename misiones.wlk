class Mision{

    method esUtil(pirata)
    method puedeSerRealizadaPor(barco)
}

class BusquedaDelTesoro inherits Mision{
    const property itemsReq = ["brujula", "mapa", "grogXD"]
    override method esUtil(pirata) = self.tieneItemNecesario(pirata) && pirata.dinero() <= 5
    method tieneItemNecesario(pirata) = itemsReq.any({item => pirata.tieneItem(item)})
    override method puedeSerRealizadaPor(barco) = barco.tripulantes().any({tripulante => tripulante.items().contains("llaveDeCofre")})
}

class ConvertirseEnLeyenda inherits Mision{
    const itemObligatorio

    override method esUtil(pirata) = pirata.cantidadDeItems() >= 10 && pirata.tieneItem(itemObligatorio)
    override method puedeSerRealizadaPor(barco) = true
}

class Saqueo inherits Mision{
    const victima
    var property monedasReq

    override method esUtil(pirata) = pirata.dinero() < self.monedasReq() && pirata.seAnimaASaquearA(victima)
    override method puedeSerRealizadaPor(barco) = victima.esVulnerableA(barco)
}