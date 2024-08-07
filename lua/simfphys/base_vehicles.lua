local V = {
	Name = "Driveable Couch",
	Model = "models/props_c17/FurnitureCouch002a.mdl",
	Class = "gmod_sent_vehicle_fphysics_base",
	Category = "Base",
	SpawnAngleOffset = 90,

	Members = {
		Mass = 500,

		CustomWheels = true,
		CustomSuspensionTravel = 10,

		CustomWheelModel = "models/props_phx/wheels/magnetic_small_base.mdl",
		
		CustomWheelPosFL = Vector(12,22,-15),
		CustomWheelPosFR = Vector(12,-22,-15),
		CustomWheelPosRL = Vector(-12,22,-15),
		CustomWheelPosRR = Vector(-12,-22,-15),
		CustomWheelAngleOffset = Angle(90,0,0),
		
		CustomMassCenter = Vector(0,0,0),
		
		CustomSteerAngle = 35,
		
		SeatOffset = Vector(-3,-13.5,21),
		SeatPitch = 15,
		SeatYaw = 90,
		
		PassengerSeats = {
			{
				pos = Vector(0,-14,-12),
				ang = Angle(0,-90,0)
			}
		},
		
		FrontHeight = 7,
		FrontConstant = 12000,
		FrontDamping = 400,
		FrontRelativeDamping = 50,
		
		RearHeight = 7,
		RearConstant = 12000,
		RearDamping = 400,
		RearRelativeDamping = 50,
		
		FastSteeringAngle = 10,
		SteeringFadeFastSpeed = 120,
		
		TurnSpeed = 8,
		
		MaxGrip = 20,
		Efficiency = 1,
		GripOffset = 0,
		BrakePower = 5,
		BulletProofTires = true,
		
		IdleRPM = 600,
		LimitRPM = 10000,
		PeakTorque = 40,
		PowerbandStart = 650,
		PowerbandEnd = 700,
		Turbocharged = false,
		Supercharged = false,
		DoNotStall = true,
		
		FuelType = FUELTYPE_ELECTRIC,
		FuelTankSize = 80,
		
		PowerBias = 0,
		
		EngineSoundPreset = 0,
		
		Sound_Idle = "",
		Sound_IdlePitch = 0,
		
		Sound_Mid = "vehicles/apc/apc_idle1.wav",
		Sound_MidPitch = 1,
		Sound_MidVolume = 1,
		Sound_MidFadeOutRPMpercent = 100,
		Sound_MidFadeOutRate = 1,
		
		Sound_High = "",
		
		Sound_Throttle = "",
		
		snd_horn = "simulated_vehicles/horn_0.wav",
		
		DifferentialGear = 0.7,
		Gears = {-0.1,0,0.1},

		Dash = { pos = Vector(24, 14, 8), ang = Angle(-0.0, -90.0, 79.6) },
	}
}
list.Set( "simfphys_vehicles", "sim_fphys_couch", V )