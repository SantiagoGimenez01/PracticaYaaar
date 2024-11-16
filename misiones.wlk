class Mision{

    method esUtil(pirata)
    method puedeSerRealizadaPor(barco) = barco.tieneSuficienteTripulacion()
}

class BusquedaDelTesoro inherits Mision{
    const property itemsReq = ["brujula", "mapa", "grogXD"]
    override method esUtil(pirata) = self.tieneItemNecesario(pirata) && pirata.dinero() <= 5
    method tieneItemNecesario(pirata) = itemsReq.any({item => pirata.tieneItem(item)})
    override method puedeSerRealizadaPor(barco) = super(barco) && barco.tripulantes().any({tripulante => tripulante.items().contains("llaveDeCofre")})
}

class ConvertirseEnLeyenda inherits Mision{
    const itemObligatorio

    override method esUtil(pirata) = pirata.cantidadDeItems() >= 10 && pirata.tieneItem(itemObligatorio)
    override method puedeSerRealizadaPor(barco) = true
}

class Saqueo inherits Mision{
    const victima

    override method esUtil(pirata) = pirata.dinero() < self.monedasReq() && pirata.seAnimaASaquearA(victima)
    override method puedeSerRealizadaPor(barco) = super(barco) && victima.esVulnerableA(barco)
    method monedasReq() = monedasMaxEnSaqueo.monedas()
}

object monedasMaxEnSaqueo{
    var property monedas = 0
}