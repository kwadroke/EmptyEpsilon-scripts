-- Name: Basic+ Timed
-- Description: Siege mission for Conventions.

-- Based off of scenario_00_basic.lua
-- Modified by Kwadroke
-- updated 2015-09-16

--Timer Info  
maxgametimeminutes = 25  --total game time, in minutes (You can modify this to shorten or lengthen time)

maxgametime = maxgametimeminutes * 60 * 1.0 -- recalc for minutes to seconds
currenttime = 0.0  -- Setting mission time to zero, will count up to maxgametime in update()
timewarning = 0 -- Used for checking if warning has already been given, don't send again.

-- End Timer Info


function vectorFromAngle(angle, length)
	return math.cos(angle / 180 * math.pi) * length, math.sin(angle / 180 * math.pi) * length
end
function setCirclePos(obj, x, y, angle, distance)
	dx, dy = vectorFromAngle(angle, distance)
	return obj:setPosition(x + dx, y + dy)
end



function init()
	enemyList = {}
	friendlyList = {}

-- Random Ship name list chooser
playerCallSign = TheEpsilon  -- Setting this to a known value, incase the Random Ship name chooser breaks

ShipNames = {
"SS Epsilon",
"Ironic Gentleman",
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
"Jenny"
}

math.randomseed(math.random(1,1701)) --choose random seed from random number (better randomization each time script is run)

playerCallSign = ShipNames[math.random(1,#ShipNames)] --Randomly Select ship from List
print("Shipname: ".. playerCallSign) --Debugging
--End Random name chooser
 

  player = PlayerSpaceship():setFaction("Human Navy"):setShipTemplate("Player Cruiser"):setWarpDrive(1):setJumpDrive(1)
  player:setPosition(22400, 18200):setCallSign(playerCallSign)
  
  
  
	n = 0
	table.insert(friendlyList, setCirclePos(SpaceStation():setTemplate('Small Station'):setFaction("Human Navy"), 0, 0, n * 360 / 3 + random(-30, 30), random(10000, 22000)))
  lastunderattack1=false
	n = 1
	table.insert(friendlyList, setCirclePos(SpaceStation():setTemplate('Medium Station'):setFaction("Human Navy"), 0, 0, n * 360 / 3 + random(-30, 30), random(10000, 22000)))
  lastunderattack2=false
	n = 2
	table.insert(friendlyList, setCirclePos(SpaceStation():setTemplate('Large Station'):setFaction("Human Navy"), 0, 0, n * 360 / 3 + random(-30, 30), random(10000, 22000)))
  lastunderattack3=false
	friendlyList[1]:addReputationPoints(300.0)

	local x, y = friendlyList[1]:getPosition()
	setCirclePos(Nebula(), x, y, random(0, 360), 6000)

	for n=1, 5 do
		setCirclePos(Nebula(), 0, 0, random(0, 360), random(20000, 45000))
	end
	
	enemy_group_count = 5
	for cnt=1,enemy_group_count do
		a = cnt * 360/enemy_group_count + random(-60, 60)
		d = random(35000, 55000)
		type = random(0, 10)
		if type < 1.0 then
			table.insert(enemyList, setCirclePos(CpuShip():setShipTemplate('Strikeship'):setRotation(a + 180):orderRoaming(), 0, 0, a, d))
		elseif type < 2.0 then
			leader = setCirclePos(CpuShip():setShipTemplate('Cruiser'):setRotation(a + 180):orderRoaming(), 0, 0, a + random(-1, 1), d + random(-100, 100))
			table.insert(enemyList, leader)
			table.insert(enemyList, setCirclePos(CpuShip():setShipTemplate('Fighter'):setRotation(a + 180):orderFlyFormation(leader,-400, 0), 0, 0, a + random(-1, 1), d + random(-100, 100)))
			table.insert(enemyList, setCirclePos(CpuShip():setShipTemplate('Fighter'):setRotation(a + 180):orderFlyFormation(leader, 400, 0), 0, 0, a + random(-1, 1), d + random(-100, 100)))
			table.insert(enemyList, setCirclePos(CpuShip():setShipTemplate('Fighter'):setRotation(a + 180):orderFlyFormation(leader,-400, 400), 0, 0, a + random(-1, 1), d + random(-100, 100)))
			table.insert(enemyList, setCirclePos(CpuShip():setShipTemplate('Fighter'):setRotation(a + 180):orderFlyFormation(leader, 400, 400), 0, 0, a + random(-1, 1), d + random(-100, 100)))
		elseif type < 3.0 then
			table.insert(enemyList, setCirclePos(CpuShip():setShipTemplate('Adv. Gunship'):setRotation(a + 180):orderRoaming(), 0, 0, a + random(-5, 5), d + random(-100, 100)))
			table.insert(enemyList, setCirclePos(CpuShip():setShipTemplate('Adv. Gunship'):setRotation(a + 180):orderRoaming(), 0, 0, a + random(-5, 5), d + random(-100, 100)))
		elseif type < 4.0 then
			table.insert(enemyList, setCirclePos(CpuShip():setShipTemplate('Cruiser'):setRotation(a + 180):orderRoaming(), 0, 0, a + random(-5, 5), d + random(-100, 100)))
			table.insert(enemyList, setCirclePos(CpuShip():setShipTemplate('Cruiser'):setRotation(a + 180):orderRoaming(), 0, 0, a + random(-5, 5), d + random(-100, 100)))
			table.insert(enemyList, setCirclePos(CpuShip():setShipTemplate('Cruiser'):setRotation(a + 180):orderRoaming(), 0, 0, a + random(-5, 5), d + random(-100, 100)))
		elseif type < 5.0 then
			table.insert(enemyList, setCirclePos(CpuShip():setShipTemplate('Dreadnought'):setRotation(a + 180):orderRoaming(), 0, 0, a + random(-5, 5), d + random(-100, 100)))
		elseif type < 6.0 then
			leader = setCirclePos(CpuShip():setShipTemplate('Missile Cruiser'):setRotation(a + 180):orderRoaming(), 0, 0, a + random(-5, 5), d + random(-100, 100))
			table.insert(enemyList, leader)
			table.insert(enemyList, setCirclePos(CpuShip():setShipTemplate('Fighter'):setRotation(a + 180):orderFlyFormation(leader,-1500, 400), 0, 0, a + random(-1, 1), d + random(-100, 100)))
			table.insert(enemyList, setCirclePos(CpuShip():setShipTemplate('Fighter'):setRotation(a + 180):orderFlyFormation(leader, 1500, 400), 0, 0, a + random(-1, 1), d + random(-100, 100)))
		elseif type < 7.0 then
			table.insert(enemyList, setCirclePos(CpuShip():setShipTemplate('Cruiser'):setRotation(a + 180):orderRoaming(), 0, 0, a + random(-5, 5), d + random(-100, 100)))
			table.insert(enemyList, setCirclePos(CpuShip():setShipTemplate('Cruiser'):setRotation(a + 180):orderRoaming(), 0, 0, a + random(-5, 5), d + random(-100, 100)))
		elseif type < 8.0 then
			table.insert(enemyList, setCirclePos(CpuShip():setShipTemplate('Cruiser'):setRotation(a + 180):orderRoaming(), 0, 0, a + random(-5, 5), d + random(-100, 100)))
		elseif type < 9.0 then
			table.insert(enemyList, setCirclePos(CpuShip():setShipTemplate('Fighter'):setRotation(a + 180):orderRoaming(), 0, 0, a + random(-5, 5), d + random(-100, 100)))
		else
			table.insert(enemyList, setCirclePos(CpuShip():setShipTemplate('Adv. Striker'):setRotation(a + 180):orderRoaming(), 0, 0, a + random(-5, 5), d + random(-100, 100)))
			table.insert(enemyList, setCirclePos(CpuShip():setShipTemplate('Adv. Striker'):setRotation(a + 180):orderRoaming(), 0, 0, a + random(-5, 5), d + random(-100, 100)))
		end
	end
  
	for cnt=1,random(2, 5) do
		a = random(0, 360)
		a2 = random(0, 360)
		d = random(3000, 40000)
		x, y = vectorFromAngle(a, d)
		for acnt=1,50 do
			dx1, dy1 = vectorFromAngle(a2, random(-1000, 1000))
			dx2, dy2 = vectorFromAngle(a2 + 90, random(-20000, 20000))
			Asteroid():setPosition(x + dx1 + dx2, y + dy1 + dy2)
		end
		for acnt=1,100 do
			dx1, dy1 = vectorFromAngle(a2, random(-1500, 1500))
			dx2, dy2 = vectorFromAngle(a2 + 90, random(-20000, 20000))
			VisualAsteroid():setPosition(x + dx1 + dx2, y + dy1 + dy2)
		end
	end

	for cnt=1,random(0, 3) do
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

	a = random(0, 360)
	d = random(10000, 45000)
	x, y = vectorFromAngle(a, d)
	BlackHole():setPosition(x, y)
  
	Script():run("util_random_transports.lua")
  
  -- Neutral Station used for monitoring time and sending messages
  neutral_station = SpaceStation():setTemplate("Small Station"):setFaction("Independent")
  --randomly placing this in 1 of possible 4 corners (making it harder to guess). We want this station far enough away that it's hard to get to. Will probably take all energy to get there, and time might be up by then.
  rdmval={-1,1}
  rdm1=159999 * (rdmval[math.random(1,#rdmval)])
  rdm2=159999 * (rdmval[math.random(1,#rdmval)])
  neutral_station:setPosition(rdm1, rdm2):setCallSign("TemporalMonitoring-1") 
  print("Neutral Station is located in ".. neutral_station:getSectorName() .." -  ".. rdm1 .." | ".. rdm2) --Debug only
  
  -- Send starting Message from friendly station
  Message = playerCallSign ..", please inform your Captain and crew that you have a total of ".. maxgametimeminutes .." minutes of mission time. The mission started at the arrival of this message. Station TemporalMonitoring-1 will warn you 5 minutes and 1 minute before your time is up. We have uploaded mission details to your Science Database. Good Luck."
  friendlyList[1]:sendCommsMessage(player, Message) 
  
  missiontimeleft=ScienceDatabase():setName("Mission")
  missionentry=missiontimeleft:addEntry("Details")
  missionentry:setLongDescription("Enemy Kraylor vessels are out to destroy all of our Stations. You must keep them safe.\n\nDestroy the enemy ships before the last of our Stations in this section of space are lost.")
  missionentrytime=missiontimeleft:addEntry("Mission Length")
  missionentrytime:setLongDescription("Total time to complete mission: ".. maxgametimeminutes .." minutes.")
  missionentryship=missiontimeleft:addEntry("Your ship")
  missionentryship:setLongDescription("Your ship is named: ".. playerCallSign .."\nIt has been specially equiped with both a Warp and a Jump Drive for this mission.")
end


function update(delta)
	enemy_count = 0
	friendly_count = 0
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
  
  -- Enemy attacking stations messages
  enemyrangewarning=5000
  underattackmessage= "Mayday! Mayday! \n".. playerCallSign ..", we are under attack! Please assist!"
  
  if ( friendlyList[1]:areEnemiesInRange(enemyrangewarning) == true and lastunderattack1 == false ) then
    friendlyList[1]:sendCommsMessage(player, underattackmessage)
    lastunderattack1=true
  elseif   ( friendlyList[1]:areEnemiesInRange(enemyrangewarning) == false and lastunderattack1 == true ) then
    lastunderattack1=false
  else 
    lastunderattack1=friendlyList[1]:areEnemiesInRange(enemyrangewarning) 
  end
  
  if ( friendlyList[2]:areEnemiesInRange(enemyrangewarning) == true and lastunderattack2 == false ) then
    friendlyList[2]:sendCommsMessage(player, underattackmessage)
    lastunderattack2=true
  elseif   ( friendlyList[2]:areEnemiesInRange(enemyrangewarning) == false and lastunderattack2 == true ) then
    lastunderattack2=false
  else 
    lastunderattack2=friendlyList[2]:areEnemiesInRange(enemyrangewarning) 
  end
  
  if ( friendlyList[3]:areEnemiesInRange(enemyrangewarning) == true and lastunderattack3 == false ) then
    friendlyList[3]:sendCommsMessage(player, underattackmessage)
    lastunderattack3=true
  elseif   ( friendlyList[3]:areEnemiesInRange(enemyrangewarning) == false and lastunderattack3 == true ) then
    lastunderattack3=false
  else 
    lastunderattack3=friendlyList[3]:areEnemiesInRange(enemyrangewarning) 
  end
  --End Enemy attacking stations messages
  
  -- Timer
  currenttime=currenttime + delta
  --print(currenttime)  -- for Debugging
  
  missiontime=(maxgametime - (currenttime / 60))
  --print(missiontime) -- for Debugging

  
  
  
  if (currenttime >= (maxgametime - (60 * 5)) and timewarning == 0 ) then -- 5 minutes left (300 seconds)
    timewarning = 1
    Message = playerCallSign ..", you have 5 minutes remaining of mission time."
    print(Message)
    globalMessage(Message)
    neutral_station:sendCommsMessage(player, Message)
    ScienceDatabase:addEntry("Mission Time Left")
    
  elseif ( currenttime >= (maxgametime - 60) and timewarning == 1 ) then -- 1 minute left (60 seconds)
    timewarning = 2
    Message = playerCallSign ..", you have 1 minute remaining. This is your last chance to complete your mission."
    print(Message)
    neutral_station:sendCommsMessage(player, Message)
  elseif currenttime >= maxgametime then -- Time's up
    print("Time's up")
    victory("Kraylor");
  end
  -- End Timer
  
	if enemy_count == 0 then
		victory("Human Navy");	--Victory for the humans (eg; players). Note that this can happen if the players kill themselves (and then blow up the enemies)
	end

	if friendly_count == 0 then
		victory("Kraylor");	--Victory for the Kraylor (== defeat for the players)
	else
		friendlyList[1]:addReputationPoints(delta * friendly_count * 0.1)
	end
end