class Pirata{
    const items = []
    var property ebriedad
    var dinero

    method dinero() = dinero
    method cantidadDeItems() = items.size()
    method tieneItem(item) = items.contains(item)
    method gastar(monedas){
        dinero -= monedas
    }
    method estaPasadoDeGrog() = self.ebriedad() > 90 && self.tieneItem("grogXD")
    method seAnimaASaquear(victima) = victima.puedeSerSaqueadaPor(self)
}

