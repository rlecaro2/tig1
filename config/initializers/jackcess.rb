Rjb::load("lib/nicolito.jar")
JACKCESS = Rjb::import("com.nicolito.Jackcess")
J_HELPER = JACKCESS.new("db/access/precios.mdb","BD precios")

Metwit.client_id = "129380086"
Metwit.client_secret = "3NiL2XxeFnH2Dzk-pcwMrFgZuNwUljiVGDnQ-GXE"
Metwit.get_access_token