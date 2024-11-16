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

    method puedeSerSaqueadaPor(pirata) = pirata.estaPasadoDeGrog()

    method itemMasRaro() 
}


class CiudadCostera{
    method puedeSerSaqueadaPor(pirata) = pirata.ebriedad() > 50
}