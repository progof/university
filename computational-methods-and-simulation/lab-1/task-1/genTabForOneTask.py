# import pandas as pd

# # Dane float
# float_data = {
#     "n": list(range(100)),
#     "x_float": [
#         0.0099999998, 0.0397000015, 0.1540717334, 0.5450726151, 1.2889780998, 0.1715188026,
#         0.5978190899, 1.3191133738, 0.0562732220, 0.2155928612, 0.7229306102, 1.3238364458,
#         0.0377169847, 0.1466002166, 0.5219259858, 1.2704837322, 0.2395482063, 0.7860428095,
#         1.2905813456, 0.1655247211, 0.5799036026, 1.3107497692, 0.0888042450, 0.3315584064,
#         0.9964407086, 1.0070805550, 0.9856885076, 1.0280085802, 0.9416294098, 1.1065198183,
#         0.7529209256, 1.3110139370, 0.0877830982, 0.3280147910, 0.9892780781, 1.0210989714,
#         0.9564665556, 1.0813814402, 0.8173682690, 1.2652003765, 0.2586054802, 0.8337915540,
#         1.2495411634, 0.3141053319, 0.9604348540, 1.0744340420, 0.8345106244, 1.2488185167,
#         0.3166309595, 0.9657583237, 1.0649658442, 0.8574066162, 1.2241880894, 0.4008429050,
#         1.1213464737, 0.7131321430, 1.3268561363, 0.0257829428, 0.1011374891, 0.3738635778,
#         1.0761322975, 0.8303470612, 1.2529594898, 0.3021155000, 0.9346406460, 1.1179032326,
#         0.7224900126, 1.3239846230, 0.0371326208, 0.1443939805, 0.5150270462, 1.2643496990,
#         0.2616583109, 0.8412380219, 1.2419078350, 0.3406261206, 1.0144259930, 0.9705237150,
#         1.0563460588, 0.8777832389, 1.1996226311, 0.4812071323, 1.2301476002, 0.3808010221,
#         1.0881758928, 0.8003232479, 1.2797410488, 0.2057527304, 0.6960083246, 1.3307505846,
#         0.0103108883, 0.0409246087, 0.1586739719, 0.5591635704, 1.2986626625, 0.1350765228,
#         0.4855690897, 1.2349442244, 0.3645151854, 1.0594468117
#     ]
# }

# # Dane double
# double_data = {
#     "x_double": [
#         0.010000000000000, 0.039700000000000, 0.154071730000000, 0.545072626044421, 1.288978001188801, 
#         0.171519142109176, 0.597820120107099, 1.319113792413797, 0.056271577646257, 0.215586839232630, 
#         0.722914301179573, 1.323841944168441, 0.037695297254732, 0.146518382713559, 0.521670621435246, 
#         1.270261773935077, 0.240352172778243, 0.788101190235304, 1.289094302790308, 0.171084846701943, 
#         0.596529312494691, 1.318575587982598, 0.058377608259431, 0.223286597599448, 0.743575676395179, 
#         1.315588346001072, 0.070035295602779, 0.265426354520610, 0.850351969060138, 1.232112462387190, 
#         0.374146489639287, 1.076629171428944, 0.829125567400452, 1.254154650050444, 0.297906941472321, 
#         0.925382128557105, 1.132532262669786, 0.682241072715310, 1.332605646962029, 0.002909156902851, 
#         0.011611238029749, 0.046040489573244, 0.177802778252544, 0.616369629147206, 1.325743957383631, 
#         0.030184707916891, 0.118005481891479, 0.430246046296597, 1.165649204124828, 0.586382615268778, 
#         1.313996746606757, 0.076224636147602, 0.287467959122905, 0.901958353924756, 1.167246799055058, 
#         0.581591926507394, 1.311620199093830, 0.085438156362505, 0.319853589762148, 0.972495402397394, 
#         1.052739686537368, 0.886176203317085, 1.188780023291890, 0.515526261833961, 1.264803067414351, 
#         0.260031871635150, 0.837277763742362, 1.246008893997217, 0.326421084228366, 0.986032164226998, 
#         1.027350370237460, 0.943055131268702, 1.104161583238122, 0.759127927255740, 1.307686079204172, 
#         0.100615671583550, 0.372092146229572, 1.073010889061101, 0.837986452113321, 1.245281926676870, 
#         0.328946475983308, 0.991168551747720, 1.017428913069861, 0.964230872827887, 1.067699962968262, 
#         0.850850219105765, 1.231562590366075, 0.376011119496710, 1.079891392031332, 0.821069312375225, 
#         1.261812802327926, 0.270736564955744, 0.863051397010868, 1.217632446396239, 0.422643462034285, 
#         1.154691360136162, 0.618829029025349, 1.326468014608027, 0.027319877097624, 0.107040381336610
#     ]
# }

# # Stworzenie DataFrame
# df = pd.DataFrame(float_data)
# df["x_double"] = double_data["x_double"]

# # Zapis do pliku Excel
# file_path = "./float_double_data.xlsx"
# df.to_excel(file_path, index=False)

# file_path


import pandas as pd

# Dane do tabeli
data = {
    "n": list(range(50)),
    "Reprezentacja float": [
        0.0099999998, 0.0397000015, 0.1540717334, 0.5450726151, 1.2889780998,
        0.1715188026, 0.5978190899, 1.3191133738, 0.0562732220, 0.2155928612,
        0.7229306102, 1.3238364458, 0.0377169847, 0.1466002166, 0.5219259858,
        1.2704837322, 0.2395482063, 0.7860428095, 1.2905813456, 0.1655247211,
        0.5799036026, 1.3107497692, 0.0888042450, 0.3315584064, 0.9964407086,
        1.0070805550, 0.9856885076, 1.0280085802, 0.9416294098, 1.1065198183,
        0.7529209256, 1.3110139370, 0.0877830982, 0.3280147910, 0.9892780781,
        1.0210989714, 0.9564665556, 1.0813814402, 0.8173682690, 1.2652003765,
        0.2586054802, 0.8337915540, 1.2495411634, 0.3141053319, 0.9604348540,
        1.0744340420, 0.8345106244, 1.2488185167, 0.3166309595, 0.9657583237
    ],
    "Reprezentacja double": [
        0.010000000000000, 0.039700000000000, 0.154071730000000, 0.545072626044421, 1.288978001188801,
        0.171519142109176, 0.597820120107099, 1.319113792413797, 0.056271577646257, 0.215586839232630,
        0.722914301179573, 1.323841944168441, 0.037695297254732, 0.146518382713559, 0.521670621435246,
        1.270261773935077, 0.240352172778243, 0.788101190235304, 1.289094302790308, 0.171084846701943,
        0.596529312494691, 1.318575587982598, 0.058377608259431, 0.223286597599448, 0.743575676395179,
        1.315588346001072, 0.070035295602779, 0.265426354520610, 0.850351969060138, 1.232112462387190,
        0.374146489639287, 1.076629171428944, 0.829125567400452, 1.254154650050444, 0.297906941472321,
        0.925382128557105, 1.132532262669786, 0.682241072715310, 1.332605646962029, 0.002909156902851,
        0.011611238029749, 0.046040489573244, 0.177802778252544, 0.616369629147206, 1.325743957383631,
        0.030184707916891, 0.118005481891479, 0.430246046296597, 1.165649204124828, 0.586382615268778
    ]
}

# Tworzenie DataFrame
df = pd.DataFrame(data)

# Zapis do pliku Excel
file_path = "./float_double_new_data.xlsx"
df.to_excel(file_path, index=False)

file_path

