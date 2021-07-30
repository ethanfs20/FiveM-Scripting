Config = {
	-- █▀ █▀▀ █▀█ █░█ █▀▀ █▀█
	-- ▄█ ██▄ █▀▄ ▀▄▀ ██▄ █▀▄
	server = {
		servername = 'Project X',
		serverip = '172.104.11.199:30120',
		serverprefix = '[PJX] '
	},
	-- █▀▄ █ █▀ █▀▀ █▀█ █▀█ █▀▄
	-- █▄▀ █ ▄█ █▄▄ █▄█ █▀▄ █▄▀
	discord = {
		serverlink = 'https://discord.gg/CPxWHD8WM6', -- An invite link to your Discord server.
		guildid = '795560579145269248', -- This is the id of your server.

		bottoken = 'ODAxODE3MzY4NDcyNTg0MTkz.YAmMnQ.NfFksHwy8LgWFQFpAnNWZ3nrVNw', -- Bot token. Find this in your developer portal.
		appid = '801817368472584193', -- this is the appid of the bot. You can find this in the developer portal.

		wait = 2500, -- How often do you want to update the Discord RP status (In MS)

		assetbig = 'test', -- Find this in your developer portal.
		bigtext = 'Project X', -- Find this in your developer portal.

		WebhookName = 'Project X'
		WebhookAvatar = 'https://jalallinux.ir/favicon.png',

		tweetwebhook = 'https://discord.com/api/webhooks/865234050125922345/F8EBNLsSOmvOtxvayJIpl0_rnMTBOgcMltru-DQqPS7qocTZZUccqpB4HF-guhUijejC',
		xpwebhook = 'https://discord.com/api/webhooks/865275529259384882/MueYZtYE7UCXVC8t3bQITZdOLcajurnP5C1XgqeNh5qagTjxG_2poYHEW6s_CnZlvVBn',
	},
	Buttons = {
		{index = 0, name = 'Discord', url = 'https://discord.gg/CPxWHD8WM6'},
		{index = 1, name = 'Join Server', url = 'fivem://connect/66.175.210.213:30120'}
	},
	CommonStrings = {
		nonearplayer = 'No players is near you!',
		noperms = 'You are not authorized to perfom this action! If you believe this is an error, contact a moderator.',
		nopermsvehs = 'You are not authorized to drive this vehicle! If you believe this is an error, contact a moderator.',
		noplayerspec = 'No player was specified!',
		terminated = 'You have have been terminated. Report to a department administrator immediately.',
		notonduty = 'You are not on-duty!',
		source0 = 'Console cannot execute this command!',
		novehnear = 'No vehicle is near you!',
		invalidplayer = 'The player specified could not be found. Try again using their sID.'
	},
	CommandUsage = {
		addxp = 'Usage: /addxp [sID] [amount].',
		removexp = 'Usage: /removexp [sID] [amount].',
		mute = 'Usage: /removexp [sID | all].'
	},
	XPSYSTEM = {
		xplooptime = 600000,
		xploop = 500
	},
	blips = {
		-- Create new entries to add new blips on the map. https://docs.fivem.net/docs/game-references/blips/
		{x = 193.9785, y = -3167.5754, z = 5.79206, c = 1, s = 442, name = 'Elysian Island Club'},
		{x = -318.859039, y = 6074.433105, z = 30.614943, c = 1, s = 313, name = 'Ammunation'},
		{x = 1704.671997, y = 3748.880615, z = 33.286053, c = 1, s = 313, name = 'Ammunation'},
		{x = -1108.600830, y = 2685.694092, z = 18.177374, c = 1, s = 313, name = 'Ammunation'},
		{x = -3155.888672, y = 1073.844482, z = 20.188726, c = 1, s = 313, name = 'Ammunation'},
		{x = 2571.371826, y = 313.879608, z = 107.970573, c = 1, s = 313, name = 'Ammunation'},
		{x = 235.666794, y = -42.263149, z = 69.221313, c = 1, s = 313, name = 'Ammunation'},
		{x = -1328.592896, y = -387.114410, z = 36.126881, c = 1, s = 313, name = 'Ammunation'},
		{x = -665.232727, y = -952.522522, z = 20.866556, c = 1, s = 313, name = 'Ammunation'},
		{x = 844.439026, y = -1009.422424, z = 27.511728, c = 1, s = 313, name = 'Ammunation'},
		{x = 17.377790, y = -1122.183105, z = 28.469843, c = 1, s = 313, name = 'Ammunation'},
		{x = 814.442017, y = -2130.448486, z = 28.867798, c = 1, s = 313, name = 'Ammunation'}
	},
	RoleList = {
		-- █▀ ▀█▀ ▄▀█ █▀▀ █▀▀
		-- ▄█ ░█░ █▀█ █▀░ █▀░
	
		{801836050682216490, 'group.founder'},
		{807867310702198784, 'group.admin'},
		{795761844202635324, 'group.moderator'},
		-- █▄▄ █▀▀ █▀ █▀█ ░░▄▀ █░░ █▀ █▀ █▀▄
		-- █▄█ █▄▄ ▄█ █▄█ ▄▀░░ █▄▄ ▄█ ▄█ █▄▀
	
		{807831725635534919, 'group.sheriff'},
		{807831784774697012, 'group.undersheriff'},
		{807831794669584415, 'group.colonel'},
		{807831797181317140, 'group.major'},
		{807831798884335628, 'group.captain'},
		{807831801141657632, 'group.lieutenant'},
		{807831803041021953, 'group.sergeantfirstclass'},
		{807831804966207539, 'group.staffsergeant'},
		{807831807311478784, 'group.sergeant'},
		{807831963268415508, 'group.corporal'},
		{807831966110973962, 'group.seniordeputy'},
		{807831969500626965, 'group.deputythree'},
		{807831972680433734, 'group.deputytwo'},
		{807831975497826344, 'group.deputyone'},
		{807831980027936778, 'group.probationarydeputy'},
		-- █▀ ▄▀█ █░█ █▀█
		-- ▄█ █▀█ █▀█ █▀▀
	
		{807863308371492904, 'group.commissioner'},
		{808094605227720755, 'group.deputycommissioner'},
		{808147184062955530, 'group.commander'},
		{808147184636919809, 'group.major'},
		{808147185337237514, 'group.captain'},
		{808147185945280543, 'group.Lieutenant'},
		{808147186541920316, 'group.mastersergeant'},
		{808147187296895026, 'group.staffsergeant'},
		{808147187715801100, 'group.seniorsergeant'},
		{808147188998995988, 'group.sergeant'},
		{808147189888057364, 'group.seniorcorporal'},
		{808147190165667840, 'group.corporal'},
		{808147190996402197, 'group.mastertrooper'},
		{808147191339417640, 'group.seniortrooper'},
		{808147192090198076, 'group.trooperfirstclass'},
		{808147192208031785, 'group.trooper'},
		{808147193269715005, 'group.probationarytrooper'},
		{808147194640465950, 'group.highwayrecruit'},
		-- █▀▀ █ █▀█ █▀▀ ░░▄▀ █▀▀ █▀▄▀█ █▀
		-- █▀░ █ █▀▄ ██▄ ▄▀░░ ██▄ █░▀░█ ▄█
	
		-- █▀▀ █░░ █▀█ █▄▄ ▄▀█ █░░
		-- █▄█ █▄▄ █▄█ █▄█ █▀█ █▄▄
		{804798550030548993, 'group.emergencyservices'}
	},
	weapons = {
		['weapon_dagger'] = 'Dagger',
		['weapon_bottle'] = 'Broken Bottle',
		['weapon_crowbar'] = 'Crowbar',
		['weapon_flashlight'] = 'Flashlight',
		['weapon_golfclub'] = 'Golfclub',
		['weapon_hammer'] = 'Hammer',
		['weapon_hatchet'] = 'Hatchet',
		['weapon_knuckle'] = 'Knuckles',
		['weapon_knife'] = 'Knife',
		['weapon_machete'] = 'Machete',
		['weapon_switchblade'] = 'Switchblade',
		['weapon_nightstick'] = 'Nightstick',
		['weapon_wrench'] = 'Wrench',
		['weapon_battleaxe'] = 'Battleaxe',
		['weapon_poolcue'] = 'Poolcue',
		['weapon_stone_hatchet'] = 'Stone Hatchet',
		['weapon_pistol'] = 'Pistol',
		['weapon_pistol_mk2'] = 'Pistol Mk2',
		['weapon_combatpistol'] = 'Combat Pistol',
		['weapon_appistol'] = 'AP Pistol',
		['weapon_stungun'] = 'Stungun',
		['weapon_pistol50'] = 'Pistol .50',
		['weapon_snspistol'] = 'SNS Pistol',
		['weapon_snspistol_mk2'] = 'SNS Pistol Mk2',
		['weapon_heavypistol'] = 'Heavy Pistol',
		['weapon_vintagepistol'] = 'Vintage Pistol',
		['weapon_marksmanpistol'] = 'Marksman Pistol',
		['weapon_revolver'] = 'Revolver',
		['weapon_revolver_mk2'] = 'Revolver Mk2',
		['weapon_doubleaction'] = 'Double Action Revolver',
		['weapon_raypistol'] = 'Ray Pistol',
		['weapon_ceramicpistol'] = 'Ceramic Pistol',
		['weapon_navyrevolver'] = 'Navy Revolver',
		['weapon_gadgetpistol'] = 'Gadget Pistol',
		['weapon_microsmg'] = 'Micro SMG',
		['weapon_smg'] = 'SMG',
		['weapon_smg_mk2'] = 'SMG Mk2',
		['weapon_assaultsmg'] = 'Assualt SMG',
		['weapon_combatpdw'] = 'Combat PDW',
		['weapon_machinepistol'] = 'Machine Pistol',
		['weapon_minismg'] = 'Mini SMG',
		['weapon_raycarbine'] = 'Ray Carbine',
		['weapon_pumpshotgun'] = 'Pump Shotgun',
		['weapon_combatshotgun'] = 'Combat Shotgun',
		['weapon_assaultrifle'] = 'Assault Rifle',
		['weapon_assaultrifle_mk2'] = 'Assault Rifle Mk2',
		['weapon_carbinerifle'] = 'Carbine Rifle',
		['weapon_carbinerifle_mk2'] = 'Carbine Rifle Mk2',
		['weapon_advancedrifle'] = 'Advanced Rifle',
		['weapon_specialcarbine'] = 'Special Carbine',
		['weapon_specialcarbine_mk2'] = 'Special Carbine Mk2',
		['weapon_bullpuprifle'] = 'Bullpup Rifle',
		['weapon_bullpuprifle_mk2'] = 'Bullpup Rifle Mk2',
		['weapon_compactrifle'] = 'Compact Rifle',
		['weapon_militaryrifle'] = 'Military Rifle',
		['weapon_mg'] = 'MG',
		['weapon_heavysniper'] = 'Heavy Sniper',
		['weapon_heavysniper_mk2'] = 'Heavy Sniper Mk2',
		['weapon_marksmanrifle'] = 'Marksman Rifle',
		['weapon_marksmanrifle_mk2'] = 'Marksman Rifle Mk2',
		['weapon_rpg'] = 'RPG',
		['weapon_grenadelauncher'] = 'Grenade Launcher',
		['weapon_grenadelauncher_smoke'] = 'Smoke Grenade Launcher',
		['weapon_minigun'] = 'Minigun',
		['weapon_firework'] = 'Firework Launcher',
		['weapon_railgun'] = 'Railgun',
		['weapon_hominglauncher'] = 'Homing Launcher',
		['weapon_compactlauncher'] = 'Compact Launcher',
		['weapon_rayminigun'] = 'Ray Minigun',
		['weapon_grenade'] = 'Grenade',
		['weapon_bzgas'] = 'BZ Gas',
		['weapon_molotov'] = 'Molotov',
		['weapon_stickybomb'] = 'Stickybomb',
		['weapon_proxmine'] = 'Proxymine',
		['weapon_snowball'] = 'Snowball',
		['weapon_pipebomb'] = 'Pipebomb',
		['weapon_ball'] = 'Ball',
		['weapon_smokegrenade'] = 'Smoke Grenade',
		['weapon_flare'] = 'Flare',
		['weapon_petrolcan'] = 'Petrol Can',
		['gadget_parachute'] = 'Parachute',
		['weapon_fireextinguisher'] = 'Fire Extinguisher',
		['weapon_hazardcan'] = 'Hazard Can'
	},
	ranks = {
		-- rank | xp amount
		[1] = 1000,
		[2] = 5000,
	}
}