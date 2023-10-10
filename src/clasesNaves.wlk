class Nave {
	var velocidad = 0
	var direccion = 0
	var combustible = 0
	
	method velocidad() = velocidad
	method direccion() = direccion
	
	method acelerar(cuanto){
		velocidad = 100000.min(velocidad + cuanto)
	}
	method desacelerar(cuanto){
		velocidad = 0.max(velocidad - cuanto)
	}
	method ponerseParaleloAlSol(){
		direccion = 0
	}
	method acercarseUnPocoAlSol(){
		
	}
	method irHaciaElSol(){
		
	}
	method cargarCombustible(cantidad){
		combustible += cantidad
	}
	method descargarCombustible(cantidad){
		combustible = 0.max(combustible - cantidad)
	}
	
	method prepararViaje(){
		self.cargarCombustible(30000)
		self.acelerar(5000)
		self.accionAdicional()
	}
	method accionAdicional()
	
	method estaTranquila() = combustible >= 4000 and velocidad < 12000
	
	method recibirAmenaza(){
		self.escapar()
		self.avisar()
	}
	method escapar()
	method avisar()
	
	method relajo(){
		return self.estaTranquila() and self.pocaActividad()
	}
	method pocaActividad()
}

class Baliza inherits Nave {
	var color 
	var cambioColorBaliza = false
	method color()=color
	method cambiarColorDeBaliza(colorNuevo){
		color = colorNuevo
		cambioColorBaliza = true
	}
	override method accionAdicional(){
		self.cambiarColorDeBaliza("verde")
		self.ponerseParaleloAlSol()
	}
	override method estaTranquila(){
		return super() and color != "rojo"
	}
	override method escapar(){
		self.irHaciaElSol()
	}
	override method avisar(){
		self.cambiarColorDeBaliza("rojo")
	}
	override method pocaActividad(){
		return not cambioColorBaliza 
	}
}

class Pasajero inherits Nave{
	var pasajeros
	var comida
	var bebida
	var descargadas = 0
	method pasajeros() = pasajeros
	method comida() = comida
	method bebida() = bebida
	
	method cargarComida(cantidad){
		comida += cantidad
	}
	method cargarBebida(cantidad){
		bebida += cantidad
	}
	method descargarComida(cantidad){
		comida = 0.max(comida - cantidad)
		descargadas += cantidad
	}
	method descargarBebida(cantidad){
		bebida = 0.max(bebida - cantidad)
	}
	override  method accionAdicional(){
		self.cargarComida(pasajeros * 4)
		self.cargarBebida(pasajeros * 6)
		self.acercarseUnPocoAlSol()
	}
	override method escapar(){
		self.acelerar(velocidad)
	}
	override method avisar(){
		self.descargarComida(pasajeros)
		self.descargarBebida(pasajeros * 2)
	}
	override method pocaActividad(){
		return descargadas < 50
	}
}

class Hospital inherits Pasajero{
	var property quirofanosPreparados = false
	
	override method estaTranquila(){
		return super() and not quirofanosPreparados
	}
	override method recibirAmenaza(){
		super()
		quirofanosPreparados = true
	}
}

class Combate inherits Nave{
	var visible = true
	var misilesDesplegados = false
	const mensajes = [] 
	
	method mensajes() = mensajes
	method ponerseVisible(){
		visible = true
	}
	method ponerseInvisible(){
		visible = false
	}
	method estaInvisible() = not visible
	method desplegarMisiles(){
		misilesDesplegados = true
	}
	method replegarMisiles(){
		misilesDesplegados = false
	}
	method misilesDesplegados() = misilesDesplegados
	method emitirMensaje(mensaje){
		mensajes.add(mensaje)
	}
	method mensajesEmitidos(){
		return mensajes.size()
	}
	method primerMensajeEmitido(){
		if(mensajes.isEmpty())
			self.error("Ta vacio mi rey")
		return mensajes.last()
	}
	method esEscueta(){
		return mensajes.all({m => m.size() <= 30})
	}
	method esEscueta1(){
		return not mensajes.any({m => m.size() > 30})
	}
	method emitioMensaje(mensaje){
		return mensajes.contains(mensaje)
	}
	override method accionAdicional(){
		self.ponerseVisible()
		self.replegarMisiles()
		self.acelerar(15000)
		self.emitirMensaje("Saliendo en mision")
		self.acelerar(15000)
	}
	override method estaTranquila(){
		return super() and not misilesDesplegados 
	}
	override method escapar(){
		self.acercarseUnPocoAlSol()
		self.acercarseUnPocoAlSol()
	}
	override method avisar(){
		self.emitirMensaje("Amenaza recibida")
	}
	override method pocaActividad(){
		return self.esEscueta()
	}
}

class Sigilosa inherits Combate{
	override method estaTranquila(){
		return super() and visible
	}
	override method recibirAmenaza(){
		super()
		self.desplegarMisiles()
		self.ponerseInvisible()
	}
}

















































