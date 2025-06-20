-- Global to local
local random = math.random
local insert = table.insert
local require = require
local ipairs = ipairs
local VEHICLE = VEHICLE
local utils = utils
local entities = entities
local ENTITY = ENTITY

local features = require "features"
local vector3 = require "vector3"
local vehicles = require "vehicle"
local switch = require "switch"
local enum = require "enums"
local settings = require("default").settings

local MaxHeight = .15
local Width = .02
local fuelConsumption = {}
fuelConsumption.blips = {}
fuelConsumption.tankVolume = {}
fuelConsumption.gasStations = {
	vector3(-724, -935, 20),
	vector3(-71, -1762, 30),
	vector3(265, -1261, 30),
	vector3(819, -1027, 27),
	vector3(-2097, -320, 13),
	vector3(1212, 2657, 38),
	vector3(2683, 3264, 55),
	vector3(-2555, 2334, 33),
	vector3(180, 6603, 32),
	vector3(2581, 362, 108),
	vector3(1702, 6418, 33),
	vector3(-1799, 803, 139),
	vector3(-90, 6415, 31),
	vector3(264, 2609, 45),
	vector3(50, 2776, 58),
	vector3(2537, 2593, 38),
	vector3(1182, -330, 69),
	vector3(-526, -1212, 18),
	vector3(1209, -1402, 35),
	vector3(2005, 3775, 32),
	vector3(621, 269, 103),
	vector3(-1434, -274, 46),
	-- vector3(1687, 4929, 42)
}

fuelConsumption.gas_pumps = {
	vector3(1246.4423,-1481.9998,33.878845),
	vector3(1246.219,-1488.9025,33.878845),
	vector3(1204.1953,-1401.0337,34.38496),
	vector3(1207.0681,-1398.1609,34.38496),
	vector3(1212.9373,-1404.03,34.38496),
	vector3(1194.5398,-1391.4414,34.40035),
	vector3(1210.0647,-1406.9031,34.38496),
	vector3(1194.5398,-1397.5852,34.39602),
	vector3(818.9861,-1026.2478,25.435555),
	vector3(818.9861,-1030.9414,25.435555),
	vector3(810.699,-1026.2478,25.435555),
	vector3(810.699,-1030.9414,25.435555),
	vector3(827.29333,-1026.2478,25.635113),
	vector3(827.29333,-1030.9414,25.635113),
	vector3(1186.391,-338.23325,68.356384),
	vector3(1178.9633,-339.54306,68.3656),
	vector3(1184.8871,-329.7048,68.30954),
	vector3(1177.4598,-331.01437,68.318726),
	vector3(1183.1293,-320.99655,68.35069),
	vector3(1175.7015,-322.30612,68.35878),
	vector3(-69.538055,-2530.206,5.150002),
	vector3(-63.46463,-2534.4585,5.150002),
	vector3(-60.770172,-2536.2349,5.190331),
	vector3(-72.52707,-2528.016,5.190331),
	vector3(1202.4124,-2946.1519,4.933693),
	vector3(300.9284,-2953.959,5.11306),
	vector3(273.8386,-1268.6396,28.2906),
	vector3(273.8386,-1261.2983,28.286133),
	vector3(273.8386,-1253.4614,28.291832),
	vector3(265.0627,-1253.4614,28.289986),
	vector3(265.0627,-1261.2983,28.29272),
	vector3(265.0627,-1268.6396,28.291122),
	vector3(256.43338,-1253.4614,28.286732),
	vector3(256.43338,-1261.2983,28.29153),
	vector3(256.43338,-1268.6396,28.291168),
	vector3(-314.92197,-1463.0386,29.72625),
	vector3(-309.85153,-1471.7983,29.723412),
	vector3(-322.33322,-1467.3176,29.720665),
	vector3(-317.26285,-1476.0918,29.725029),
	vector3(-329.81955,-1471.6396,29.729012),
	vector3(-324.7491,-1480.4141,29.728859),
	vector3(-334.59158,-1455.456,29.5374),
	vector3(169.29726,-1562.267,28.329025),
	vector3(176.02077,-1555.9115,28.32838),
	vector3(181.80672,-1561.9698,28.329025),
	vector3(174.98015,-1568.4442,28.329025),
	vector3(-80.17232,-1762.1438,28.7989),
	vector3(-77.59275,-1755.0569,28.80795),
	vector3(-72.0343,-1765.106,28.528473),
	vector3(-69.45482,-1758.0188,28.541801),
	vector3(-63.61374,-1767.9377,28.261608),
	vector3(-61.034252,-1760.8506,28.30056),
	vector3(-1435.5074,-284.6864,45.402596),
	vector3(-1429.0759,-279.15186,45.402596),
	vector3(-1438.072,-268.6978,45.403587),
	vector3(-1444.5035,-274.23236,45.403587),
	vector3(-732.6458,-939.32166,18.21167),
	vector3(-732.6458,-932.51624,18.21167),
	vector3(-724.0074,-932.51624,18.21167),
	vector3(-724.0074,-939.32166,18.21167),
	vector3(-715.43744,-932.51624,18.21167),
	vector3(-715.43744,-939.32166,18.21167),
	vector3(-727.3123,-906.8928,18.048965),
	vector3(-532.2853,-1212.7188,17.325386),
	vector3(-529.5171,-1213.9626,17.325386),
	vector3(-524.92676,-1216.1521,17.325386),
	vector3(-522.235,-1217.4221,17.325161),
	vector3(-528.5758,-1204.8013,17.325386),
	vector3(-525.8076,-1206.0449,17.325386),
	vector3(-521.2173,-1208.2344,17.325386),
	vector3(-518.52563,-1209.5044,17.325161),
	vector3(-546.8771,-1221.6467,17.307388),
	vector3(-549.9054,-1228.1411,17.307388),
	vector3(-1628.736,-799.87256,9.201332),
	vector3(-2088.0867,-321.03525,12.160918),
	vector3(-2087.2153,-312.81848,12.160918),
	vector3(-2096.0964,-311.9069,12.160918),
	vector3(-2096.8145,-320.1179,12.160918),
	vector3(-2104.5352,-311.01984,12.160918),
	vector3(-2105.3967,-319.2159,12.160918),
	vector3(-2078.153,-298.2357,12.28628),
	vector3(-2081.4358,-297.89066,12.232613),
	vector3(-2088.7556,-327.3988,12.160918),
	vector3(-2097.4834,-326.4815,12.160918),
	vector3(-2106.0657,-325.57947,12.160918),
	vector3(-764.88586,-1434.486,4.035404),
	vector3(-705.2833,-1464.9779,4.024448),
	vector3(-2551.3962,2327.1155,32.246918),
	vector3(-2558.0215,2326.7043,32.256134),
	vector3(-2552.6072,2334.4675,32.25415),
	vector3(-2558.4846,2334.1338,32.25547),
	vector3(-2552.3984,2341.8916,32.216003),
	vector3(-2558.7725,2341.4878,32.22522),
	vector3(-1795.9344,811.9636,137.69022),
	vector3(-1790.8387,806.40295,137.69513),
	vector3(-1802.319,806.1129,137.6517),
	vector3(-1797.224,800.5526,137.65482),
	vector3(-1808.7191,799.9514,137.68541),
	vector3(-1803.6237,794.39075,137.68983),
	vector3(612.43225,263.83575,102.269516),
	vector3(612.421,273.95715,102.269516),
	vector3(620.9901,263.83594,102.269516),
	vector3(620.9861,273.9698,102.269516),
	vector3(629.6345,263.8357,102.269516),
	vector3(629.6306,273.96985,102.269516),
	vector3(625.6753,247.43433,102.0612),
	vector3(2539.7944,2594.8079,36.95572),
	vector3(2543.1816,2640.578,37.112915),
	vector3(2581.1736,364.38474,107.65001),
	vector3(2580.934,358.88507,107.65078),
	vector3(2588.406,358.55957,107.65083),
	vector3(2588.6458,364.0592,107.6505),
	vector3(2573.5447,359.20697,107.65115),
	vector3(2573.7842,364.70667,107.650566),
	vector3(2555.3262,347.47028,107.65403),
	vector3(172.33336,6603.6357,31.0625),
	vector3(173.16548,6598.917,31.074646),
	vector3(179.67465,6604.9307,31.0625),
	vector3(180.43814,6600.198,31.074646),
	vector3(186.97092,6606.218,31.0625),
	vector3(187.7344,6601.4854,31.074646),
	vector3(156.14325,6629.073,30.80008),
	vector3(154.46286,6630.7646,30.788544),
	vector3(156.80345,6628.4033,30.854492),
	vector3(-91.02049,6391.5957,30.6792),
	vector3(-91.29045,6422.537,30.643494),
	vector3(-97.06087,6416.7666,30.643494),
	vector3(1684.5912,4931.6553,41.227165),
	vector3(1690.0948,4927.802,41.227695),
	vector3(1697.6842,4918.798,41.106518),
	vector3(1701.7244,6416.483,31.76001),
	vector3(1697.7566,6418.344,31.76001),
	vector3(1705.737,6414.6,31.76001),
	vector3(2691.4639,3267.8198,54.27576),
	vector3(2693.6719,3271.7192,54.27576),
	vector3(2678.513,3262.337,54.39086),
	vector3(2680.9023,3266.4077,54.39086),
	vector3(1786.0798,3329.8535,40.411945),
	vector3(1785.0325,3331.476,40.343834),
	vector3(2009.2544,3776.7734,31.398464),
	vector3(2001.5469,3772.2017,31.398464),
	vector3(2006.2051,3774.9565,31.398464),
	vector3(2003.9138,3773.476,31.398464),
	vector3(264.97632,2607.1777,43.98323),
	vector3(263.08258,2606.7947,43.98323),
	vector3(1017.8661,2654.7488,38.739845),
	vector3(1035.4424,2667.904,38.70319),
	vector3(1035.4425,2674.4358,38.703194),
	vector3(1043.2194,2674.4456,38.703392),
	vector3(1043.2196,2667.9138,38.703453),
	vector3(1233.2144,2729.0984,37.029488),
	vector3(1209.5815,2658.3516,36.89955),
	vector3(1208.5098,2659.428,36.898148),
	vector3(1205.8998,2662.0486,36.896744),
	vector3(50.305706,2778.5347,57.0414),
	vector3(48.913097,2779.5854,57.0414),
	vector3(62.5907,2788.6772,56.924362)
}

local DefaultFuel = switch()
	:case(2196012677, function()
        return 60
	end)
	:case(931280609, function()
	    return 100
	end)
	:case(628003514, function()
	    return 100
	end)
	:case(1537277726, function()
	    return 100
	end)
	:case(1239571361, function()
	    return 100
	end)
	:case(3101054893, function()
	    return 60
	end)
	:case(2487343317, function()
	    return 50
	end)
	:case(2767531027, function()
	    return 60
	end)
	:case(2485144969, function()
	    return 50
	end)
	:case(3486135912, function()
	    return 80
	end)
	:case(142944341, function()
	    return 80
	end)
	:case(1878062887, function()
	    return 80
	end)
	:case(634118882, function()
	    return 80
	end)
	:case(470404958, function()
	    return 80
	end)
	:case(666166960, function()
	    return 80
	end)
	:case(359875117, function()
	    return 80
	end)
	:case(2006918058, function()
	    return 80
	end)
	:case(3505073125, function()
	    return 80
	end)
	:case(683047626, function()
	    return 70
	end)
	:case(662793086, function()
	    return 80
	end)
	:case(2465530446, function()
	    return 80
	end)
	:case(83136452, function()
	    return 80
	end)
	:case(3126015148, function()
	    return 80
	end)
	:case(1203490606, function()
	    return 80
	end)
	:case(3862958888, function()
	    return 80
	end)
	:case(784565758, function()
	    return 60
	end)
	:case(80636076, function()
	    return 60
	end)
	:case(3379262425, function()
	    return 60
	end)
	:case(3606777648, function()
	    return 60
	end)
	:case(2919906639, function()
	    return 60
	end)
	:case(3001042683, function()
	    return 60
	end)
	:case(37348240, function()
	    return 45
	end)
	:case(600450546, function()
	    return 45
	end)
	:case(3627815886, function()
	    return 45
	end)
	:case(3705788919, function()
	    return 45
	end)
	:case(159274291, function()
	    return 60
	end)
	:case(3306466016, function()
	    return 60
	end)
	:case(223240013, function()
	    return 60
	end)
	:case(1011753235, function()
	    return 60
	end)
	:case(1483171323, function()
	    return 60
	end)
	:case(2634021974, function()
	    return 60
	end)
	:case(1841130506, function()
	    return 60
	end)
	:case(2031587082, function()
	    return 60
	end)
	:case(903794909, function()
	    return 60
	end)
	:case(3903371924, function()
	    return 60
	end)
	:case(3249425686, function()
	    return 60
	end)
	:case(2272483501, function()
	    return 60
	end)
	:case(1561920505, function()
	    return 60
	end)
	:case(661493923, function()
	    return 60
	end)
	:case(2568944644, function()
	    return 60
	end)
	:case(1141395928, function()
	    return 60
	end)
	:case(108773431, function()
	    return 60
	end)
	:case(2566281822, function()
	    return 60
	end)
	:case(1755697647, function()
	    return 60
	end)
	:case(686471183, function()
	    return 60
	end)
	:case(3205927392, function()
	    return 60
	end)
	:case(1304459735, function()
	    return 60
	end)
	:case(4086055493, function()
	    return 60
	end)
	:case(3460613305, function()
	    return 60
	end)
	:case(482197771, function()
	    return 60
	end)
	:case(3847255899, function()
	    return 60
	end)
	:case(1416466158, function()
	    return 60
	end)
	:case(867799010, function()
	    return 60
	end)
	:case(3620039993, function()
	    return 10
	end)
	:case(3884762073, function()
	    return 60
	end)
	:case(1104234922, function()
	    return 60
	end)
	:case(2537130571, function()
	    return 60
	end)
	:case(1886268224, function()
	    return 60
	end)
	:case(1074745671, function()
	    return 60
	end)
	:case(1741861769, function()
	    return 60
	end)
	:case(987469656, function()
	    return 60
	end)
	:case(1887331236, function()
	    return 60
	end)
	:case(2754593701, function()
	    return 60
	end)
	:case(3437611258, function()
	    return 80
	end)
	:case(2802050217, function()
	    return 80
	end)
	:case(1456336509, function()
	    return 60
	end)
	:case(540101442, function()
	    return 60
	end)
	:case(3188846534, function()
	    return 60
	end)
	:case(2816263004, function()
	    return 60
	end)
	:case(3379732821, function()
	    return 60
	end)
	:case(2983812512, function()
	    return 60
	end)
	:case(2465164804, function()
	    return 60
	end)
	:case(408192225, function()
	    return 60
	end)
	:case(6774487, function()
	    return 10
	end)
	:case(916547552, function()
	    return 10
	end)
	:case(301304410, function()
	    return 10
	end)
	:case(1126868326, function()
	    return 45
	end)
	:case(3945366167, function()
	    return 80
	end)
	:case(2166734073, function()
	    return 10
	end)
	:case(4246935337, function()
	    return 10
	end)
	:case(3025077634, function()
	    return 10
	end)
	:case(3854198872, function()
	    return 10
	end)
	:case(2704629607, function()
	    return 10
	end)
	:case(2859047862, function()
	    return 70
	end)
	:case(2815302597, function()
	    return 45
	end)
	:case(668439077, function()
	    return 120
	end)
	:case(2600885406, function()
	    return 120
	end)
	:case(2252616474, function()
	    return 120
	end)
	:case(2139203625, function()
	    return 80
	end)
	:case(2403970600, function()
	    return 80
	end)
	:case(2038858402, function()
	    return 80
	end)
	:case(3057713523, function()
	    return 80
	end)
	:case(2633113103, function()
	    return 45
	end)
	:case(534258863, function()
	    return 45
	end)
	:case(1897744184, function()
	    return 45
	end)
	:case(2434067162, function()
	    return 80
	end)
	:case(2071877360, function()
	    return 80
	end)
	:case(2370534026, function()
	    return 80
	end)
	:case(92612664, function()
	    return 70
	end)
	:case(1233534620, function()
	    return 80
	end)
	:case(2044532910, function()
	    return 80
	end)
	:case(3449006043, function()
	    return 80
	end)
	:case(1721676810, function()
	    return 80
	end)
	:case(840387324, function()
	    return 80
	end)
	:case(3579220348, function()
	    return 80
	end)
	:case(433954513, function()
	    return 80
	end)
	:case(408825843, function()
	    return 45
	end)
	:case(4008920556, function()
	    return 80
	end)
	:case(3087195462, function()
	    return 80
	end)
	:case(2249373259, function()
	    return 80
	end)
	:case(3105951696, function()
	    return 80
	end)
	:case(989381445, function()
	    return 80
	end)
	:case(2198148358, function()
	    return 80
	end)
	:case(1180875963, function()
	    return 80
	end)
	:case(1356124575, function()
	    return 80
	end)
	:case(740289177, function()
	    return 45
	end)
	:case(298565713, function()
	    return 10
	end)
	:case(1284356689, function()
	    return 80
	end)
	:case(1886712733, function()
	    return 100
	end)
	:case(3288047904, function()
	    return 120
	end)
	:case(2164484578, function()
	    return 70
	end)
	:case(1353720154, function()
	    return 80
	end)
	:case(2186977100, function()
	    return 80
	end)
	:case(3410276810, function()
	    return 40
	end)
	:case(1783355638, function()
	    return 30
	end)
	:case(356391690, function()
	    return 100
	end)
	:case(3695398481, function()
	    return 70
	end)
	:case(734217681, function()
	    return 70
	end)
	:case(4278019151, function()
	    return 70
	end)
	:case(2072156101, function()
	    return 70
	end)
	:case(1739845664, function()
	    return 70
	end)
	:case(2307837162, function()
	    return 75
	end)
	:case(4061868990, function()
	    return 75
	end)
	:case(121658888, function()
	    return 75
	end)
	:case(444171386, function()
	    return 75
	end)
	:case(682434785, function()
	    return 75
	end)
	:case(2948279460, function()
	    return 60
	end)
	:case(3387490166, function()
	    return 60
	end)
	:case(2551651283, function()
	    return 60
	end)
	:case(893081117, function()
	    return 60
	end)
	:case(1132262048, function()
	    return 60
	end)
	:case(1876516712, function()
	    return 70
	end)
	:case(2549763894, function()
	    return 60
	end)
	:case(296357396, function()
	    return 60
	end)
	:case(2588363614, function()
	    return 250
	end)
	:case(1033245328, function()
	    return 10
	end)
	:case(276773164, function()
	    return 10
	end)
	:case(509498602, function()
	    return 10
	end)
	:case(867467158, function()
	    return 10
	end)
	:case(3314393930, function()
	    return 10
	end)
	:case(861409633, function()
	    return 10
	end)
	:case(1336872304, function()
	    return 250
	end)
	:case(1861786828, function()
	    return 10
	end)
	:case(3251507587, function()
	    return 2
	end)
	:case(4018222598, function()
	    return 2
	end)
	:case(3806844075, function()
	    return 2
	end)
	:case(3264692260, function()
	    return 2
	end)
	:case(3678636260, function()
	    return 2
	end)
	:case(3983945033, function()
	    return 2
	end)
	:case(231083307, function()
	    return 10
	end)
	:case(437538602, function()
	    return 10
	end)
	:case(400514754, function()
	    return 2
	end)
	:case(771711535, function()
	    return 250
	end)
	:case(3228633070, function()
	    return 250
	end)
	:case(4012021193, function()
	    return 2
	end)
	:case(1070967343, function()
	    return 10
	end)
	:case(908897389, function()
	    return 10
	end)
	:case(290013743, function()
	    return 10
	end)
	:case(1448677353, function()
	    return 10
	end)
	:case(2194326579, function()
	    return 2
	end)
	:case(1181327175, function()
	    return 100
	end)
	:case(837858166, function()
	    return 100
	end)
	:case(295054921, function()
	    return 100
	end)
	:case(788747387, function()
	    return 100
	end)
	:case(745926877, function()
	    return 100
	end)
	:case(4244420235, function()
	    return 100
	end)
	:case(1621617168, function()
	    return 100
	end)
	:case(1394036463, function()
	    return 100
	end)
	:case(2025593404, function()
	    return 100
	end)
	:case(744705981, function()
	    return 100
	end)
	:case(1949211328, function()
	    return 100
	end)
	:case(2310691317, function()
	    return 100
	end)
	:case(4252008158, function()
	    return 100
	end)
	:case(2634305738, function()
	    return 100
	end)
	:case(353883353, function()
	    return 100
	end)
	:case(4212341271, function()
	    return 100
	end)
	:case(3568198617, function()
	    return 100
	end)
	:case(1229411063, function()
	    return 100
	end)
	:case(1593933419, function()
	    return 100
	end)
	:case(1044954915, function()
	    return 100
	end)
	:case(710198397, function()
	    return 100
	end)
	:case(2623428164, function()
	    return 100
	end)
	:case(3955379698, function()
	    return 100
	end)
	:case(1075432268, function()
	    return 100
	end)
	:case(2694714877, function()
	    return 100
	end)
	:case(1543134283, function()
	    return 100
	end)
	:case(2449479409, function()
	    return 100
	end)
	:case(4143991942, function()
	    return 100
	end)
	:case(3681241380, function()
	    return 100
	end)
	:case(3987008919, function()
	    return 100
	end)
	:case(1283517198, function()
	    return 120
	end)
	:case(3581397346, function()
	    return 120
	end)
	:case(2222034228, function()
	    return 120
	end)
	:case(345756458, function()
	    return 120
	end)
	:case(3196165219, function()
	    return 70
	end)
	:case(1941029835, function()
	    return 70
	end)
	:case(1171614426, function()
	    return 70
	end)
	:case(2287941233, function()
	    return 120
	end)
	:case(456714581, function()
	    return 60
	end)
	:case(562680400, function()
	    return 80
	end)
	:case(3471458123, function()
	    return 120
	end)
	:case(630371791, function()
	    return 120
	end)
	:case(4081974053, function()
	    return 60
	end)
	:case(4262731174, function()
	    return 100
	end)
	:case(2859440138, function()
	    return 100
	end)
	:case(3040635986, function()
	    return 100
	end)
	:case(782665360, function()
	    return 100
	end)
	:case(3147997943, function()
	    return 100
	end)
	:case(1542143200, function()
	    return 100
	end)
	:case(3715219435, function()
	    return 100
	end)
	:case(1489874736, function()
	    return 100
	end)
	:case(2014313426, function()
	    return 120
	end)
	:case(2053223216, function()
	    return 80
	end)
	:case(850991848, function()
	    return 70
	end)
	:case(3493417227, function()
	    return 80
	end)
	:case(679453769, function()
	    return 80
	end)
	:case(1909700336, function()
	    return 80
	end)
	:case(2112052861, function()
	    return 80
	end)
	:case(1653666139, function()
	    return 80
	end)
	:case(2306538597, function()
	    return 80
	end)

local IsElectric = switch() -- 1st param is default capacity, 2nd param is default consumption rate, 3rd param is throttle consumption multiplier
	:case(utils.joaat("Airtug"), function()
		return 600, .0005, 1
	end)
	:case(utils.joaat("caddy"), function()
		return 600, .0005, 1
	end)
	:case(utils.joaat("Caddy2"), function()
		return 600, .0005, 1
	end)
	:case(utils.joaat("caddy3"), function()
		return 600, .0005, 1
	end)
	:case(utils.joaat("cyclone"), function()
		return 600, .0005, 1
	end)
	:case(utils.joaat("imorgon"), function()
		return 600, .0005, 1
	end)
	:case(utils.joaat("iwagen"), function()
		return 600, .0005, 1
	end)
	:case(utils.joaat("khamelion"), function()
		return 600, .0005, 1
	end)
	:case(utils.joaat("minitank"), function()
		return 600, .0005, 1
	end)
	:case(utils.joaat("neon"), function()
		return 600, .0005, 1
	end)
	:case(utils.joaat("raiden"), function()
		return 600, .0005, 1
	end)
	:case(utils.joaat("rcbandito"), function()
		return 600, .0005, 1
	end)
	:case(utils.joaat("surge"), function()
		return 600, .0005, 1
	end)
	:case(utils.joaat("tezeract"), function()
		return 600, .0005, 1
	end)
	:case(utils.joaat("voltic"), function()
		return 600, .0005, 1
	end)
	:case(utils.joaat("voltic2"), function()
		return 600, .0005, 1
	end)

local IsPlane = switch()
	:case(utils.joaat("alkonost"), function()
        return 2000, .01, 4
	end)
	:case(utils.joaat("alphaz1"), function()
        return 2000, .01, 4
	end)
	:case(utils.joaat("avenger"), function()
        return 2000, .01, 4
	end)
	:case(utils.joaat("avenger2"), function()
        return 2000, .01, 4
	end)
	:case(utils.joaat("besra"), function()
        return 2000, .01, 4
	end)
	:case(utils.joaat("BLIMP"), function()
        return 2000, .01, 4
	end)
	:case(utils.joaat("BLIMP2"), function()
        return 2000, .01, 4
	end)
	:case(utils.joaat("blimp3"), function()
        return 2000, .01, 4
	end)
	:case(utils.joaat("bombushka"), function()
        return 2000, .01, 4
	end)
	:case(utils.joaat("cargoplane"), function()
        return 2000, .01, 4
	end)
	:case(utils.joaat("cuban800"), function()
        return 2000, .01, 4
	end)
	:case(utils.joaat("dodo"), function()
        return 2000, .01, 4
	end)
	:case(utils.joaat("duster"), function()
        return 2000, .01, 4
	end)
	:case(utils.joaat("howard"), function()
        return 2000, .01, 4
	end)
	:case(utils.joaat("hydra"), function()
        return 2000, .01, 4
	end)
	:case(utils.joaat("jet"), function()
        return 2000, .01, 4
	end)
	:case(utils.joaat("Lazer"), function()
        return 2000, .01, 4
	end)
	:case(utils.joaat("luxor"), function()
        return 2000, .01, 4
	end)
	:case(utils.joaat("luxor2"), function()
        return 2000, .01, 4
	end)
	:case(utils.joaat("mammatus"), function()
        return 2000, .01, 4
	end)
	:case(utils.joaat("microlight"), function()
        return 2000, .01, 4
	end)
	:case(utils.joaat("Miljet"), function()
        return 2000, .01, 4
	end)
	:case(utils.joaat("mogul"), function()
        return 2000, .01, 4
	end)
	:case(utils.joaat("molotok"), function()
        return 2000, .01, 4
	end)
	:case(utils.joaat("nimbus"), function()
        return 2000, .01, 4
	end)
	:case(utils.joaat("nokota"), function()
        return 2000, .01, 4
	end)
	:case(utils.joaat("pyro"), function()
        return 2000, .01, 4
	end)
	:case(utils.joaat("rogue"), function()
        return 2000, .01, 4
	end)
	:case(utils.joaat("seabreeze"), function()
        return 2000, .01, 4
	end)
	:case(utils.joaat("Shamal"), function()
        return 2000, .01, 4
	end)
	:case(utils.joaat("starling"), function()
        return 2000, .01, 4
	end)
	:case(utils.joaat("strikeforce"), function()
        return 2000, .01, 4
	end)
	:case(utils.joaat("Stunt"), function()
        return 2000, .01, 4
	end)
	:case(utils.joaat("titan"), function()
        return 2000, .01, 4
	end)
	:case(utils.joaat("tula"), function()
        return 2000, .01, 4
	end)
	:case(utils.joaat("velum"), function()
        return 2000, .01, 4
	end)
	:case(utils.joaat("velum2"), function()
        return 2000, .01, 4
	end)
	:case(utils.joaat("vestra"), function()
        return 2000, .01, 4
	end)
	:case(utils.joaat("volatol"), function()
        return 2000, .01, 4
	end)

local CapacityClass = switch()
	:case(0, function() -- Compacts
		return 800, .0008, 1
	end)
	:case(1, function() -- Sedans
		return 900, .0008, 1
	end)
	:case(2, function() -- SUVs
		return 1050, .0009, 1
	end)
	:case(3, function() -- Coupes
		return 800, .0008, 1
	end)
	:case(4, function() -- Muscle
		return 1000, .001, 1
	end)
	:case(5, function() -- Sports Classics
		return 800, .0015, 1
	end)
	:case(6, function() -- Sports
		return 800, .0014, 2
	end)
	:case(7, function() -- Super
		return 1000, .0013, 2
	end)
	:case(8, function() -- Motorcycles
		return 500, .002, 1
	end)
	:case(9, function() -- Off-Road
		return 1000, .0022, 1
	end)
	:case(10, function() -- Industrial
		return 2200, .0035, 1
	end)
	:case(11, function() -- Utility
		return 1000, .004, 1
	end)
	:case(12, function() -- Vans
		return 1000, .0016, 1
	end)
	:case(14, function() -- Boats
		return 1000, .002, 2
	end)
	:case(15, function() -- Helicopters
		return 1000, .003, 2
	end)
	:case(16, function() -- Planes
		return 5500, .01, 6
	end)
	:case(17, function() -- Service
		return 1000, .0025, 1
	end)
	:case(18, function() -- Emergency
		return 1000, .001, 1
	end)
	:case(19, function() -- Military
		return 1000, .004, 4
	end)
	:case(20, function() -- Commercial
		return 1000, .0019, 1
	end)
	:case(22, function() -- Open Wheel
		return 1500, .0022, 3
	end)
	:default(function()
		return 1000, .001, 1
	end)

--- @param add bool
function fuelConsumption.AddBlips(add)
	if add then
		for _, v in ipairs(fuelConsumption.gasStations)
		do
			local found_blip = features.get_blip_from_coord(vector3(v.x, v.y, v.z), enum.blip_sprite.weapon_jerrycan)
			if found_blip and HUD.GET_BLIP_SPRITE(found_blip) == enum.blip_sprite.weapon_jerrycan then
				insert(fuelConsumption.blips, found_blip)
			else
				local blip = HUD.ADD_BLIP_FOR_COORD(v.x, v.y, v.z)
				HUD.SET_BLIP_SPRITE(blip, enum.blip_sprite.weapon_jerrycan)
				HUD.SET_BLIP_AS_SHORT_RANGE(blip, true)
				HUD.SET_BLIP_NAME_FROM_TEXT_FILE(blip, "HUP_BLIP3")
				insert(fuelConsumption.blips, blip)
			end
		end
	else
		for _, v in ipairs(fuelConsumption.blips) do
			features.remove_blip(v)
		end
	end
end

--- @param pos vector3
--- @return vector3
function fuelConsumption.GetClosestGasStation(pos)
	local coord
	local distance
	for _, v in ipairs(fuelConsumption.gasStations)
	do
		local dist = v:sqrlen(pos)
		if not distance or (distance and distance > dist) then
			distance = dist
			coord = v
		end
	end
	return coord
end

--- @param vehicle Vehicle
--- @return int
--- @return float
--- @return int
function fuelConsumption.GetMaxCapacity(vehicle)
	local model = ENTITY.GET_ENTITY_MODEL(vehicle)
	if VEHICLE.IS_THIS_MODEL_A_TRAIN(model) == 1 or VEHICLE.IS_THIS_MODEL_A_BICYCLE(model) == 1 then return end
	-- temp disabled
	if VEHICLE.IS_THIS_MODEL_A_BOAT(model) == 1 or VEHICLE.IS_THIS_MODEL_A_JETSKI(model) == 1 or VEHICLE.IS_THIS_MODEL_A_PLANE(model) == 1 or VEHICLE.IS_THIS_MODEL_A_HELI(model) == 1 then return end

	local capacity, rate, throttle = IsElectric(model)
	local capacity2, rate2, throttle2 = IsPlane(model)
	if capacity then
		return capacity, rate, throttle
	elseif capacity2 then
		return capacity2, rate2, throttle2
	else
		return CapacityClass(VEHICLE.GET_VEHICLE_CLASS(vehicle))
	end
end

function fuelConsumption.DoTick()
	local veh = vehicles.get_player_vehicle()
	if veh == 0 then return end
	if not fuelConsumption.tankVolume[veh] then
		local cap, rate, throttle = fuelConsumption.GetMaxCapacity(veh)
		if not cap then return end
		local model = ENTITY.GET_ENTITY_MODEL(veh)
		local fuel = IsElectric(model) and 65 or vehicles.fuel_get(veh)
		local default = DefaultFuel(model) or 65
		fuelConsumption.tankVolume[veh] = {
			capacity = cap,
			rate = rate,
			throttle = throttle,
			default = default,
			fill = (fuel / default * cap)
		}
		return
	end
	if VEHICLE._IS_VEHICLE_ROCKET_BOOST_ACTIVE(veh) == 1 then
		local minus = (fuelConsumption.tankVolume[veh].fill - .5)
		fuelConsumption.tankVolume[veh].fill = minus > 0 and minus or 0
	end
	local class = VEHICLE.GET_VEHICLE_CLASS(veh)
	local model = ENTITY.GET_ENTITY_MODEL(veh)

	if VEHICLE.GET_IS_VEHICLE_ENGINE_RUNNING(veh) == 1 and vehicles.get_throttle(veh) ~= 0 then
		local loss = 100
		local engine = VEHICLE.GET_VEHICLE_MOD(veh, 11) + 1
		loss = loss - (5 * engine)
		if VEHICLE.IS_TOGGLE_MOD_ON(veh, 18) == 1 then
			loss = loss - 20
		end
		local is_starting = (vehicles.gear_get(veh) == 1 and ENTITY.GET_ENTITY_SPEED(veh) ~= 0) and 0.01 or 0
		local minus = fuelConsumption.tankVolume[veh].fill - ((vehicles.get_throttle(veh) > 0 and vehicles.get_throttle(veh) or -vehicles.get_throttle(veh)) * fuelConsumption.tankVolume[veh].throttle / loss) - is_starting
		fuelConsumption.tankVolume[veh].fill = minus > 0 and minus or 0
		--system.log('debug', tostring(- ((vehicles.get_throttle(veh) > 0 and vehicles.get_throttle(veh) or -vehicles.get_throttle(veh)) * fuelConsumption.tankVolume[veh].throttle / loss) - is_starting))
	elseif ((vehicles.get_throttle(veh) == 0 and ENTITY.GET_ENTITY_SPEED(veh) == 0) or class == 15 or class == 16) and VEHICLE.GET_IS_VEHICLE_ENGINE_RUNNING(veh) == 1 then
		local minus = (fuelConsumption.tankVolume[veh].fill - fuelConsumption.tankVolume[veh].rate)
		fuelConsumption.tankVolume[veh].fill = minus > 0 and minus or 0
		--system.log('debug', tostring(-fuelConsumption.tankVolume[veh].rate))
	elseif IsElectric(model) and vehicles.get_throttle(veh) == 0 then
		local plus = fuelConsumption.tankVolume[veh].fill + 0.0003
		fuelConsumption.tankVolume[veh].fill = plus > fuelConsumption.tankVolume[veh].capacity and fuelConsumption.tankVolume[veh].capacity or plus
	end

	if IsElectric(model) and fuelConsumption.tankVolume[veh].fill == 0 then
		entities.request_control(veh, function()
			VEHICLE.SET_VEHICLE_ENGINE_ON(veh, false, true, true)
		end)
	end
	if not IsElectric(model) then
		vehicles.fuel_set(veh, (fuelConsumption.tankVolume[veh].fill / fuelConsumption.tankVolume[veh].capacity) * fuelConsumption.tankVolume[veh].default)
	end
end

--- @param veh Vehicle
--- @return float
function fuelConsumption.GetFuel(veh)
	if not fuelConsumption.tankVolume[veh] then return end
	return fuelConsumption.tankVolume[veh].fill / fuelConsumption.tankVolume[veh].capacity
end

--- @param veh Vehicle
--- @return bool
function fuelConsumption.IsElectric(veh)
	return IsElectric(ENTITY.GET_ENTITY_MODEL(veh)) ~= nil
end

--- @param percentage float
function fuelConsumption.Draw(percentage)
	local res = features.get_screen_resolution()
	local outline_x = 1 / res.x
	local outline_y = 1 / res.y
	GRAPHICS.DRAW_RECT(.20 - Width / 2 + outline_x * settings.Vehicle["FuelOffsetX"], .99 - MaxHeight / 2 + outline_y * settings.Vehicle["FuelOffsetY"], Width + outline_x * 2, MaxHeight + outline_y * 2, 0, 0, 0, 100, false) -- Background
	local color
	if percentage == 1 then
		color = {r = 0, g = 196, b = 0}
	elseif percentage > .45 then
		color = {r = 255, g = 255, b = 0}
	elseif percentage <= .45 and percentage > .15 then
		color = {r = 255, g = 128, b = 0}
	else
		color = {r = 196, g = 0, b = 0}
	end
	GRAPHICS.DRAW_RECT(.20 - Width / 2 + outline_x * settings.Vehicle["FuelOffsetX"], .99 - MaxHeight * percentage / 2 + outline_y * settings.Vehicle["FuelOffsetY"], Width, MaxHeight * percentage, color.r, color.g, color.b, 255, false)
end

return fuelConsumption