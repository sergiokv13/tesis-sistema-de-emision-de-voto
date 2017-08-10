class Estado < ApplicationRecord

	def self.cambiar_estado(nuevo_estado)
		estado = Estado.find(1)
		estado.estado = nuevo_estado
		estado.save
	end

	def self.get_estado()
		return Estado.find(1).estado
	end

	def self.set_id_en_linea(id,id2)
		estado = Estado.find(1)
		estado.id_en_linea = id
		estado.user_id = id2
		estado.save
	end
end

