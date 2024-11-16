class Pirata{
    const property items = []
    var property ebriedad
    var dinero

    method dinero() = dinero
    method cantidadDeItems() = items.size()
    method tieneItem(item) = items.contains(item)
    method puedeGastar(monedas) = dinero >= monedas
    method gastar(monedas){
        if(self.puedeGastar(monedas)){
            dinero -= monedas
        }else{
            self.error("El pirata no tiene suficiente dinero")
        }
    }
    method estaPasadoDeGrog() = self.ebriedad() > 90 && self.tieneItem("grogXD")
    method seAnimaASaquear(victima) = victima.puedeSerSaqueadaPor(self)
    method comprarGrog(precio){
            self.gastar(precio)
            ebriedad += 5
    }
}

class Espias inherits Pirata{
    override method estaPasadoDeGrog() = false
    override method seAnimaASaquear(victima) = super(victima) && self.tieneItem("permisoDeLaCorona")
}

