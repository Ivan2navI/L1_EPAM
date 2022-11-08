# ===============================================================================
# =============================       PART 3        =============================
# =============================================================================== 
# 17. Create a database. Use the use command to connect to a new database (If it 
#     doesn't exist, Mongo will create it when you write to it).
# 18. Create a collection. Use db.createCollection to create a collection. I'll 
#     leave the subject up to you. Run show dbs and show collections to view 
#     your database and collections.
# 19. Create some documents. Insert a couple of documents into your collection. 
#     I'll leave the subject matter up to you, perhaps cars or hats.
# 20. Use find() to list documents out.
# ===============================================================================
# http://snakeproject.ru/rubric/article.php?art=mongodb_manual
# ===============================================================================


# 17. Create a database. Use the use command to connect to a new database (If it 
#     doesn't exist, Mongo will create it when you write to it).

use MongoDB_L1
      'already on db MongoDB_L1'
show databases;
      admin    40.00 KiB
      config  108.00 KiB
      local    72.00 KiB
# ===============================================================================


# 18. Create a collection. Use db.createCollection to create a collection. I'll 
#     leave the subject up to you. Run show dbs and show collections to view 
#     your database and collections.
# 19. Create some documents. Insert a couple of documents into your collection. 
#     I'll leave the subject matter up to you, perhaps cars or hats.

db.createCollection("AirLines");
      { ok: 1 },
db.AirLines.insertMany([
      {Company: "SkyUp Airlines", Registration: "UR-SQD", Aircraft: "B737", Tech_details: {"Aircraft_type": "Boeing 737-73V", "Age_years": 20}, tags: ['SkyUP', '737']},
      {Company: "SkyUp Airlines", Registration: "UR-SQE", Aircraft: "B737", Tech_details: {"Aircraft_type": "Boeing 737-75C", "Age_years": 19}, tags: ['SkyUP', '737']},
      {Company: "SkyUp Airlines", Registration: "UR-SQA", Aircraft: "B738", Tech_details: {"Aircraft_type": "Boeing 737-8H6", "Age_years": 9}, tags: ['SkyUP', '738']},
      {Company: "SkyUp Airlines", Registration: "UR-SQB", Aircraft: "B738", Tech_details: {"Aircraft_type": "Boeing 737-8H6", "Age_years": 8}, tags: ['SkyUP', '737']},
      {Company: "SkyUp Airlines", Registration: "UR-SQC", Aircraft: "B738", Tech_details: {"Aircraft_type": "Boeing 737-8H6", "Age_years": 9}, tags: ['SkyUP', '738']},
      {Company: "SkyUp Airlines", Registration: "UR-SQF", Aircraft: "B738", Tech_details: {"Aircraft_type": "Boeing 737-8H6", "Age_years": 9}, tags: ['SkyUP', '738']},
      {Company: "SkyUp Airlines", Registration: "UR-SQH", Aircraft: "B738", Tech_details: {"Aircraft_type": "Boeing 737-86Q", "Age_years": 18}, tags: ['SkyUP', '738']},
      {Company: "SkyUp Airlines", Registration: "UR-SQM", Aircraft: "B738", Tech_details: {"Aircraft_type": "Boeing 737-8KN", "Age_years": 11}, tags: ['SkyUP', '738']},
      {Company: "SkyUp Airlines", Registration: "UR-SQO", Aircraft: "B738", Tech_details: {"Aircraft_type": "Boeing 737-82R", "Age_years": 9}, tags: ['SkyUP', '738']},
      {Company: "SkyUp Airlines", Registration: "UR-SQP", Aircraft: "B738", Tech_details: {"Aircraft_type": "Boeing 737-8BK", "Age_years": 16}, tags: ['SkyUP', '738']},
      {Company: "Ukraine International Airlines", Registration: "UR-PSI", Aircraft: "B739", Tech_details: {"Aircraft_type": "Boeing 737-9KV(ER)", "Age_years": 9}, tags: ['UIA', '739']},
      {Company: "Ukraine International Airlines", Registration: "UR-PSJ", Aircraft: "B739", Tech_details: {"Aircraft_type": "Boeing 737-9KV(ER)", "Age_years": 9}, tags: ['UIA', '739']},
      {Company: "Ukraine International Airlines", Registration: "UR-PSK", Aircraft: "B739", Tech_details: {"Aircraft_type": "Boeing 737-94X(ER)", "Age_years": 13}, tags: ['UIA', '739']},
      {Company: "Ukraine International Airlines", Registration: "UR-PSL", Aircraft: "B739", Tech_details: {"Aircraft_type": "Boeing 737-94X(ER)", "Age_years": 13}, tags: ['UIA', '739']},
      {Company: "Ukraine International Airlines", Registration: "UR-GEA", Aircraft: "B767", Tech_details: {"Aircraft_type": "Boeing 767-322(ER)", "Age_years": 31}, tags: ['UIA', '763']},
      {Company: "Ukraine International Airlines", Registration: "UR-GED", Aircraft: "B767", Tech_details: {"Aircraft_type": "Boeing 767-33A(ER)", "Age_years": 24}, tags: ['UIA', '763']},
      {Company: "Ukraine International Airlines", Registration: "UR-EMA", Aircraft: "E190", Tech_details: {"Aircraft_type": "Embraer E190STD", "Age_years": 11}, tags: ['UIA', '190']},
      {Company: "Ukraine International Airlines", Registration: "UR-EMB", Aircraft: "E190", Tech_details: {"Aircraft_type": "Embraer E190STD", "Age_years": 10}, tags: ['UIA', '190']},
      {Company: "Ukraine International Airlines", Registration: "UR-EMC", Aircraft: "E190", Tech_details: {"Aircraft_type": "Embraer E190LR", "Age_years": 9}, tags: ['UIA', '190']},
      {Company: "Ukraine International Airlines", Registration: "UR-EMD", Aircraft: "E190", Tech_details: {"Aircraft_type": "Embraer E190LR", "Age_years": 9}, tags: ['UIA', '190']},
      {Company: "Ukraine International Airlines", Registration: "UR-EME", Aircraft: "E190", Tech_details: {"Aircraft_type": "Embraer E190LR", "Age_years": 9}, tags: ['UIA', '190']}
])
     
{ acknowledged: true,
      insertedIds: 
       { '0': ObjectId("636ad5ea745a5bff4d791f7c"),
         '1': ObjectId("636ad5ea745a5bff4d791f7d"),
         '2': ObjectId("636ad5ea745a5bff4d791f7e"),
         '3': ObjectId("636ad5ea745a5bff4d791f7f"),
         '4': ObjectId("636ad5ea745a5bff4d791f80"),
         '5': ObjectId("636ad5ea745a5bff4d791f81"),
         '6': ObjectId("636ad5ea745a5bff4d791f82"),
         '7': ObjectId("636ad5ea745a5bff4d791f83"),
         '8': ObjectId("636ad5ea745a5bff4d791f84"),
         '9': ObjectId("636ad5ea745a5bff4d791f85"),
         '10': ObjectId("636ad5ea745a5bff4d791f86"),
         '11': ObjectId("636ad5ea745a5bff4d791f87"),
         '12': ObjectId("636ad5ea745a5bff4d791f88"),
         '13': ObjectId("636ad5ea745a5bff4d791f89"),
         '14': ObjectId("636ad5ea745a5bff4d791f8a"),
         '15': ObjectId("636ad5ea745a5bff4d791f8b"),
         '16': ObjectId("636ad5ea745a5bff4d791f8c"),
         '17': ObjectId("636ad5ea745a5bff4d791f8d"),
         '18': ObjectId("636ad5ea745a5bff4d791f8e"),
         '19': ObjectId("636ad5ea745a5bff4d791f8f"),
         '20': ObjectId("636ad5ea745a5bff4d791f90") } }
     

db.createCollection("Airports");
      { ok: 1 }
db.Airports.insertMany([
	{Airport: "Tbilisi", Arrivals_Time: "23:55", FLIGHT_FROM: "Minsk (MSQ)", AIRLINE: "Belavia", AIRCRAFT: "B738 (EW-455PA)", STATUS: "Estimated 23:44"},
	{Airport: "Tbilisi", Arrivals_Time: "00:10", FLIGHT_FROM: "Istanbul (IST)", AIRLINE: "Turkish Airlines", AIRCRAFT: "B738 (TC-JVI)", STATUS: "Estimated 00:06"},
	{Airport: "Tbilisi", Arrivals_Time: "00:15", FLIGHT_FROM: "Dubai (DXB)", AIRLINE: "flydubai", AIRCRAFT: "B738 (A6-FEV)", STATUS: "Estimated 00:14"},
	{Airport: "Tbilisi", Arrivals_Time: "00:50", FLIGHT_FROM: "Munich (MUC)", AIRLINE: "Lufthansa", AIRCRAFT: "A321 (D-AIDM)", STATUS: "Landed 10:33"},
	{Airport: "Tbilisi", Arrivals_Time: "01:15", FLIGHT_FROM: "Istanbul (IST)", AIRLINE: "Turkish Airlines", AIRCRAFT: "A21N (TC-LTH)", STATUS: "Estimated 00:53"},
	{Airport: "Tbilisi", Arrivals_Time: "01:35", FLIGHT_FROM: "Warsaw (WAW)", AIRLINE: "LOT", AIRCRAFT: "B738 (SP-LWD)", STATUS: "Estimated 01:50"},
	{Airport: "Tbilisi", Arrivals_Time: "05:06", FLIGHT_FROM: "Istanbul (IST)", AIRLINE: "MNG Airlines", AIRCRAFT: "A333 (TC-MCN)", STATUS: "Scheduled"},
	{Airport: "Tbilisi", Arrivals_Time: "06:15", FLIGHT_FROM: "Tehran (IKA)", AIRLINE: "Iran Aseman Airlines", AIRCRAFT: "734", STATUS: "Scheduled"},
	{Airport: "Tbilisi", Departures_Time: "00:30", FLIGHT_TO: "Istanbul (SAW)", AIRLINE: "Pegasus", AIRCRAFT: "A21N (TC-RBB)", STATUS: "Estimated dep. 00:30"},
	{Airport: "Tbilisi", Departures_Time: "01:00", FLIGHT_TO: "Istanbul (IST)", AIRLINE: "Turkish Airlines", AIRCRAFT: "B738 (TC-JVI)", STATUS: "Scheduled"},
	{Airport: "Tbilisi", Departures_Time: "01:05", FLIGHT_TO: "Minsk (MSQ)", AIRLINE: "Belavia", AIRCRAFT: "738", STATUS: "Scheduled"},
	{Airport: "Tbilisi", Departures_Time: "01:15", FLIGHT_TO: "Dubai (DXB)", AIRLINE: "FlyDubai", AIRCRAFT: "73H", STATUS: "Scheduled"},
	{Airport: "Tbilisi", Departures_Time: "01:50", FLIGHT_TO: "Munich (MUC)", AIRLINE: "Lufthansa", AIRCRAFT: "A21N (D-AIEM)", STATUS: "Estimated dep. 02:10"},
	{Airport: "Tbilisi", Departures_Time: "02:05", FLIGHT_TO: "Istanbul (IST)", AIRLINE: "Turkish Airlines", AIRCRAFT: "A21N (TC-LTH)", STATUS: "Scheduled"},
	{Airport: "Tbilisi", Departures_Time: "02:35", FLIGHT_TO: "Warsaw (WAW)", AIRLINE: "LOT", AIRCRAFT: "B738 (SP-LWD)", STATUS: "Scheduled"},
	{Airport: "Tbilisi", Departures_Time: "03:05", FLIGHT_TO: "Tel Aviv (TLV)", AIRLINE: "Georgian Airways", AIRCRAFT: "737", STATUS: "Scheduled"}
])
{ acknowledged: true,
  insertedIds: 
   { '0': ObjectId("636ad6c1745a5bff4d791f91"),
     '1': ObjectId("636ad6c1745a5bff4d791f92"),
     '2': ObjectId("636ad6c1745a5bff4d791f93"),
     '3': ObjectId("636ad6c1745a5bff4d791f94"),
     '4': ObjectId("636ad6c1745a5bff4d791f95"),
     '5': ObjectId("636ad6c1745a5bff4d791f96"),
     '6': ObjectId("636ad6c1745a5bff4d791f97"),
     '7': ObjectId("636ad6c1745a5bff4d791f98"),
     '8': ObjectId("636ad6c1745a5bff4d791f99"),
     '9': ObjectId("636ad6c1745a5bff4d791f9a"),
     '10': ObjectId("636ad6c1745a5bff4d791f9b"),
     '11': ObjectId("636ad6c1745a5bff4d791f9c"),
     '12': ObjectId("636ad6c1745a5bff4d791f9d"),
     '13': ObjectId("636ad6c1745a5bff4d791f9e"),
     '14': ObjectId("636ad6c1745a5bff4d791f9f"),
     '15': ObjectId("636ad6c1745a5bff4d791fa0") } }

show collections;
     AirLines
     Airports

show databases;
     MongoDB_L1   80.00 KiB
     admin        40.00 KiB
     config      108.00 KiB
     local        72.00 KiB
# ===============================================================================


# 20. Use find() to list documents out.

# ===============================================================================
