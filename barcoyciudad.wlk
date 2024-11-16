class Barco{
    var misionAsignada
    const tripulantes = #{}
    const capacidad

    method cambiarMision(nueva){
        misionAsignada = nueva
        self.echarTripulantes(nueva)
    }

    method reclutar(pirata){
        if(self.puedeFormarParte(pirata)){
            tripulantes.add(pirata)
        }else{
            self.error("No hay suficiente lugar en el barco")
        }
    }

    method tieneLugar() = capacidad > self.cantidadDeTripulantes()

    method tieneSuficienteTripulacion() = self.cantidadDeTripulantes() >= capacidad * 0.9

    method puedeFormarParte(pirata) = self.tieneLugar() && misionAsignada.esUtil(pirata)

    method echarTripulantes(nuevaMision){
        tripulantes.removeAllSuchThat({tripulante => !misionAsignada.esUtil(tripulante)})
    }
    
    method esTemible() = misionAsignada.puedeSerRealizadaPor(self) && tripulantes.count({pirata => misionAsignada.esUtil(pirata)}) >= 5

    method puedeSerSaqueadaPor(pirata) = pirata.estaPasadoDeGrog()

    method cantidadDeTripulantes() = tripulantes.size()

    method tripulacionPasadaDeGrog() = tripulantes.all({tripulante => tripulante.estaPasadoDeGrog()})

    method esVulnerableA(barco) = self.cantidadDeTripulantes() <= barco.cantidadDeTripulantes() * 0.5

    method itemsBarco() = tripulantes.flatMap({tripulante => tripulante.items()})
    method tripulantesQuetienen(item) = tripulantes.count({tripulante => tripulante.tieneItem(item)})
    method itemMasRaro() = self.itemsBarco().min({item => self.tripulantesQuetienen(item)})

    method elMasEbrio() = tripulantes.max({tripulante => tripulante.ebriedad()})

    method anclarEn(ciudad){
        tripulantes.filter({tripulante => tripulante.puedeGastar(ciudad.precio())}).forEach({tripulante => tripulante.comprarGrog(ciudad.precio())})
        tripulantes.remove(self.elMasEbrio())
        ciudad.habitantes(ciudad.habitantes() + 1)
    }
}


class CiudadCostera{
    var property habitantes
    const property precio = 10
 
    method puedeSerSaqueadaPor(pirata) = pirata.ebriedad() > 50
    method esVulnerableA(barco) = barco.cantidadDeTripulantes() >= self.habitantes() * 0.4 || barco.tripulacionPasadaDeGrog()
}