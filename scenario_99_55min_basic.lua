-- Name: 55min Mission 
-- Description: Different version of the basic scenario. Which intended to play for a longer period of time. There are several stations to defend.
--- This scenario is designed to be ran on conventions. As you can run a 4 player crew in 55 minutes through a game with minimal experience.
-- Type: Convention
-- Variation[Advanced]: Gived the players a stronger Atlantis instead of the Phobos. Which is more difficult to control, but has more firepower and defense. Increases enemy strengh as well.

gametimeleft = 55 * 60 -- Maximum game time in seconds.
timewarning = 10 * 60 -- Used for checking when to give a warning, and to update it so the warning happens once.

ship_names = {
    "SS Epsilon",
    "Binary Sunset",
    "USS Roddenberry",
    "Earthship Sagan",
    "Explorer",
    "ISV Phantom",
    "Keelhaul",
    "Peacekeeper",
    "WarMonger",
    "Death Bringer",
    "Executor",
    "Excaliber",
    "Voyager",
    "Khan's Wrath",
    "Kronos' Savior",
    "HMS Captor",
    "Imperial Stature",
    "ESS Hellfire",
    "Helen's Fury",
    "Venus' Light",
    "Blackbeard's Way",
    "ISV Monitor",
    "Argent",
    "Echo One",
    "Earth's Might",
    "ESS Tomahawk",
    "Sabretooth",
    "Hiro-maru",
    "USS Nimoy",
    "Earthship Tyson",
    "Destiny's Tear",
    "HMS SuperNova",
    "Alma del Terra",
    "DreadHeart",
    "Devil's Maw",
    "Cougar's Claw",
    "Blood-oath",
    "Imperial Fist",
    "HMS Promise",
    "ESS Catalyst",
    "Hercules Ascendant",
    "Heavens Mercy",
    "HMS Adams",
    "Explorer",
    "Discovery",
    "Stratosphere",
    "USS Kelly",
    "HMS Honour",
    "Devilfish",
    "Minnow",
    "Earthship Nye",
    "Starcruiser Solo",
    "Starcruiser Reynolds",
    "Starcruiser Hunt",
    "Starcruiser Lipinski",
    "Starcruiser Tylor",
    "Starcruiser Kato",
    "Starcruiser Picard",
    "Starcruiser Janeway",
    "Starcruiser Archer",
    "Starcruiser Sisko",
    "Starcruiser Kirk",
    "Aluminum Falcon",
    "SS Essess",
    "Jenny",
    "HMS Kay"
}

planet_names = {
    "Seti Beta 3",
    "Thundercore",
    "Spinning Planet 12",
    "New Africa",
    "Terra Nova",
    "Tatunica",
    "Torvolds 5",
    "Stallman 3",
    "Raymond 4",
    "X-2",
    "This Land",
    "Protege",
    "Grabthar"
}

moon_names = {
    "New Luna",
    "Grainger",
    "Foobar 2",
    "Hunk of Rock 3",
    "Paradisio",
    "Karn",
    "Beta Minor",
    "Bad Moon Rising",
    "Crumble",
    "Green Cheese",
    "E-I-E-I Io"
}



require("utils.lua")
-- For this scenario, utils.lua provides:
--   vectorFromAngle(angle, length)
--      Returns a relative vector (x, y coordinates)
--   setCirclePos(obj, x, y, angle, distance)
--      Returns the object with its position set to the resulting coordinates.


-- Add an enemy wave.
-- enemyList: A table containing enemy ship objects.
-- type: A number; at each integer, determines a different wave of ships to add
--       to the enemyList. Any number is valid, but only 0.99-9.0 are meaningful.
-- a: The spawned wave's heading relative to the players' spawn point.
-- d: The spawned wave's distance from the players' spawn point.
function addWave(enemyList,type,a,d)
	if type < 1.0 then
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('Stalker Q7'):setRotation(a + 180):orderRoaming(), 0, 0, a, d))
	elseif type < 2.0 then
		leader = setCirclePos(CpuShip():setTemplate('Phobos T3'):setRotation(a + 180):orderRoaming(), 0, 0, a + random(-1, 1), d + random(-100, 100))
		table.insert(enemyList, leader)
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('MT52 Hornet'):setRotation(a + 180):orderFlyFormation(leader,-400, 0), 0, 0, a + random(-1, 1), d + random(-100, 100)))
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('MT52 Hornet'):setRotation(a + 180):orderFlyFormation(leader, 400, 0), 0, 0, a + random(-1, 1), d + random(-100, 100)))
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('MT52 Hornet'):setRotation(a + 180):orderFlyFormation(leader,-400, 400), 0, 0, a + random(-1, 1), d + random(-100, 100)))
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('MT52 Hornet'):setRotation(a + 180):orderFlyFormation(leader, 400, 400), 0, 0, a + random(-1, 1), d + random(-100, 100)))
	elseif type < 3.0 then
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('Adder MK5'):setRotation(a + 180):orderRoaming(), 0, 0, a + random(-5, 5), d + random(-100, 100)))
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('Adder MK5'):setRotation(a + 180):orderRoaming(), 0, 0, a + random(-5, 5), d + random(-100, 100)))
	elseif type < 4.0 then
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('Phobos T3'):setRotation(a + 180):orderRoaming(), 0, 0, a + random(-5, 5), d + random(-100, 100)))
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('Phobos T3'):setRotation(a + 180):orderRoaming(), 0, 0, a + random(-5, 5), d + random(-100, 100)))
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('Phobos T3'):setRotation(a + 180):orderRoaming(), 0, 0, a + random(-5, 5), d + random(-100, 100)))
	elseif type < 5.0 then
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('Atlantis X23'):setRotation(a + 180):orderRoaming(), 0, 0, a + random(-5, 5), d + random(-100, 100)))
	elseif type < 6.0 then
		leader = setCirclePos(CpuShip():setTemplate('Piranha F12'):setRotation(a + 180):orderRoaming(), 0, 0, a + random(-5, 5), d + random(-100, 100))
		table.insert(enemyList, leader)
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('MT52 Hornet'):setRotation(a + 180):orderFlyFormation(leader,-1500, 400), 0, 0, a + random(-1, 1), d + random(-100, 100)))
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('MT52 Hornet'):setRotation(a + 180):orderFlyFormation(leader, 1500, 400), 0, 0, a + random(-1, 1), d + random(-100, 100)))
	elseif type < 7.0 then
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('Phobos T3'):setRotation(a + 180):orderRoaming(), 0, 0, a + random(-5, 5), d + random(-100, 100)))
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('Phobos T3'):setRotation(a + 180):orderRoaming(), 0, 0, a + random(-5, 5), d + random(-100, 100)))
	elseif type < 8.0 then
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('Nirvana R5'):setRotation(a + 180):orderRoaming(), 0, 0, a + random(-5, 5), d + random(-100, 100)))
	elseif type < 9.0 then
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('MU52 Hornet'):setRotation(a + 180):orderRoaming(), 0, 0, a + random(-5, 5), d + random(-100, 100)))
	else
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('WX-Lindworm'):setRotation(a + 180):orderRoaming(), 0, 0, a + random(-5, 5), d + random(-100, 100)))
		table.insert(enemyList, setCirclePos(CpuShip():setTemplate('WX-Lindworm'):setRotation(a + 180):orderRoaming(), 0, 0, a + random(-5, 5), d + random(-100, 100)))
	end
end



-- Returns a semi-random heading.
-- cnt: A counter, generally between 1 and the number of enemy groups.
-- enemy_group_count: A number of enemy groups, generally set by the scenario type.
function getWaveAngle(cnt,enemy_group_count)
	return cnt * 360/enemy_group_count + random(-60, 60)
end

-- Returns a semi-random distance.
-- cnt: A counter, generally between 1 and the number of enemy groups.
-- enemy_group_count: A number of enemy groups, generally set by the scenario type.
function getWaveDistance(cnt, enemy_group_count)
	return random(25000 + cnt * 1000, 30000 + cnt * 3000)
end

function spawnship ()
    if getScenarioVariation() == "Advanced" then
        player = PlayerSpaceship():setFaction("Human Navy"):setTemplate("Atlantis")
    else
        player = PlayerSpaceship():setFaction("Human Navy"):setTemplate("Phobos M3P")
    end
    player:setPosition(random(-2000, 2000), random(-2000, 2000)):setCallSign(ship_names[math.random(1,#ship_names)])
    player:setJumpDrive(true)
    player:setWarpDrive(true)
end


function init()
        -- Create planet & moon
        Planet():setPosition(random(-45000, 45000), random(-45000, 45000)):setPlanetRadius(3000):setDistanceFromMovementPlane(-2000):setPlanetSurfaceTexture("planets/planet-1.png"):setPlanetCloudTexture("planets/clouds-1.png"):setPlanetAtmosphereTexture("planets/atmosphere.png"):setPlanetAtmosphereColor(0.2,0.2,1.0):setCallSign(planet_names[math.random(1,#planet_names)])
        Planet():setPosition(random(-45000, 45000), random(-45000, 45000)):setPlanetRadius(1000):setDistanceFromMovementPlane(-2000):setPlanetSurfaceTexture("planets/moon-1.png"):setCallSign(moon_names[math.random(1,#moon_names)])
        

	enemyList = {}
	friendlyList = {}
	stationList = {}
	
	-- Moved ship spawning into own function. So can use again in-case ship is destroyed before time is over
	spawnship()
	
	-- Randomly distribute 4 allied stations throughout the region.
	n = 0
	station_1 = SpaceStation():setTemplate('Small Station'):setRotation(random(0, 360)):setFaction("Human Navy")
	table.insert(stationList, station_1)
	table.insert(friendlyList, setCirclePos(station_1, 0, 0, n * 360 / 3 + random(-30, 30), random(10000, 22000)))
	n = 1
	table.insert(stationList, station_2)
	station_2 = SpaceStation():setTemplate('Medium Station'):setRotation(random(0, 360)):setFaction("Human Navy")
	table.insert(friendlyList, setCirclePos(station_2, 0, 0, n * 360 / 3 + random(-30, 30), random(10000, 22000)))
	n = 2
	table.insert(stationList, station_3)
	station_3 = SpaceStation():setTemplate('Large Station'):setRotation(random(0, 360)):setFaction("Human Navy")
	table.insert(friendlyList, setCirclePos(station_3, 0, 0, n * 360 / 3 + random(-30, 30), random(10000, 22000)))
	n = 3
	station_4 = SpaceStation():setTemplate('Small Station'):setRotation(random(0, 360)):setFaction("Human Navy")
	table.insert(stationList, station_4)
	table.insert(friendlyList, setCirclePos(station_4, 0, 0, n * 360 / 3 + random(-30, 30), random(10000, 22000)))
	
	-- Start the players with 300 reputation.
	friendlyList[1]:addReputationPoints(300.0)

	-- Randomly scatter nebulae near the players' spawn point.
	local x, y = friendlyList[1]:getPosition()
	setCirclePos(Nebula(), x, y, random(0, 360), 12000)

	for n=1, 5 do
		setCirclePos(Nebula(), 0, 0, random(0, 360), random(23000, 45000))
	end

	-- Let the GM declare the Humans (players) victorious.
	addGMFunction("Win", function()
		victory("Human Navy");
	end)

	-- Let the GM declare the Humans (players) defeated.
	addGMFunction("Defeat", function()
		victory("Kraylor");
	end)

	-- Let the GM declare the Humans (players) defeated.
	addGMFunction("Extra wave", function()
		addWave(enemyList, random(0, 10), random(0, 360), random(25000, 30000))
	end)
	
	addGMFunction("Add player energy", function()
		player:setEnergy(250)
	end)

	-- Set the number of enemy waves based on the scenario variation.
	if getScenarioVariation() == "Advanced" then
		enemy_group_count = 6
	else
		enemy_group_count = 3
	end

	-- If not in the Empty variation, spawn the corresponding number of random
	-- enemy waves at distributed random headings and semi-random distances
	-- relative to the players' spawn point.
	if enemy_group_count > 0 then
		for cnt=1,enemy_group_count do
			a = getWaveAngle(cnt, enemy_group_count)
			d = getWaveDistance(cnt, enemy_group_count)
			type = random(0, 10)
			addWave(enemyList, type, a, d)
		end
	end

	-- Spawn 1-4 random asteroid belts.
	for cnt=1,random(1, 4) do
		a = random(0, 360)
		a2 = random(0, 360)
		d = random(3000, 40000)
		x, y = vectorFromAngle(a, d)

		for acnt=1,50 do
			dx1, dy1 = vectorFromAngle(a2, random(-1000, 1000))
			dx2, dy2 = vectorFromAngle(a2 + 90, random(-20000, 20000))
			Asteroid():setPosition(x + dx1 + dx2, y + dy1 + dy2):setSize(random(100, 500))
		end

		for acnt=1,100 do
			dx1, dy1 = vectorFromAngle(a2, random(-1500, 1500))
			dx2, dy2 = vectorFromAngle(a2 + 90, random(-20000, 20000))
			VisualAsteroid():setPosition(x + dx1 + dx2, y + dy1 + dy2)
		end
	end

	-- Spawn 0-1 random mine fields.
	for cnt=1,random(0, 1) do
		a = random(0, 360)
		a2 = random(0, 360)
		d = random(20000, 40000)
		x, y = vectorFromAngle(a, d)

		for nx=-1,1 do
			for ny=-5,5 do
				if random(0, 100) < 90 then
					dx1, dy1 = vectorFromAngle(a2, (nx * 1000) + random(-100, 100))
					dx2, dy2 = vectorFromAngle(a2 + 90, (ny * 1000) + random(-100, 100))
					Mine():setPosition(x + dx1 + dx2, y + dy1 + dy2)
				end
			end
		end
	end

    --Create a bunch of neutral stations
	for n=1, 4 do
		setCirclePos(SpaceStation():setTemplate("Small Station"):setFaction("Independent"), 0, 0, random(0, 360), random(15000, 30000))
	end
	-- Spawn random neutral transports.
	Script():run("util_random_transports.lua")
    
    friendlyList[1]:sendCommsMessage(player, string.format([[%s, please inform your Captain and crew that you have a total of %d minutes for this mission.
The mission started at the arrival of this message.
Your objective is to fend off the incomming Kraylor attack.
Good Luck.]], player:getCallSign(), gametimeleft / 60))  
end

function update(delta)
    --Calculate the game time left, and act on it.
    gametimeleft = gametimeleft - delta
    if gametimeleft < 0 then
        victory("Kraylor")
    end
    if gametimeleft < timewarning then
        if timewarning <= 1 * 60 then --Less then 1 minutes left.
            friendlyList[1]:sendCommsMessage(player, string.format([[%s, you have 1 minute remaining.]], player:getCallSign(), timewarning / 60))  
            timewarning = timewarning - 2 * 60
        elseif timewarning <= 5 * 60 then --Less then 5 minutes left. Warn every 2 minutes instead of every 5.
            friendlyList[1]:sendCommsMessage(player, string.format([[%s, you have %d minutes remaining.]], player:getCallSign(), timewarning / 60))  
            timewarning = timewarning - 2 * 60
        else
            friendlyList[1]:sendCommsMessage(player, string.format([[%s, you have %d minutes remaining of mission time.]], player:getCallSign(), timewarning / 60))  
            timewarning = timewarning - 5 * 60
        end
    end
	enemy_count = 0
	friendly_count = 0

	-- Count all surviving enemies and allies.
	for _, enemy in ipairs(enemyList) do
		if enemy:isValid() then
			enemy_count = enemy_count + 1
		end
	end

	for _, friendly in ipairs(friendlyList) do
		if friendly:isValid() then
			friendly_count = friendly_count + 1
		end
	end

	
	--Spawn enemies if game time left is greater than 4 minutes
	if enemy_count == 0 and gametimeleft > 4 * 60 then
		-- We will need to spawn enemies instead of a victory
		addWave(enemyList, random(0, 10), random(0, 360), random(25000, 30000))
	end
	
	-- Note that players can win even if they destroy the enemies by blowing themselves up
	-- Declare victory for the Humans (players) once all enemies are destroyed when end of game is less than 4 minutes.
	if enemy_count == 0 and gametimeleft <= 4 * 60 then
		 victory("Human Navy")
	end
	

	-- Check to see if player ship still exists and time is greater than 1 minute
	if not player:isValid() and gametimeleft >= 1 * 60 then
	        -- Spawn a new playership
		spawnship()
		player:commandSetShields(true):commandSetSystemPowerRequest("warp",0):commandSetSystemPowerRequest("jump_drive",0)
		friendlyList[1]:sendCommsMessage(player, string.format([[%s, you have %d minutes remaining of mission time.]], player:getCallSign(), timewarning / 60))  
	end
	
	-- If player ship is destroyed and timeleft is less than 1 minute then call defeat.
	if not player:isValid() and gametimeleft <= 1 * 60 then
		victory("Kraylor")
	end
	
	
	if friendly_count >= 1 then
		-- As the battle continues, award reputation based on
		-- the players' progress and number of surviving allies.
		for _, friendly in ipairs(friendlyList) do
			if friendly:isValid() then
				friendly:addReputationPoints(delta * friendly_count * 0.1)
			end
		end
	end
end
