Message-ID: <45A162C8.8020502@gmx.net>
Date: Sun, 07 Jan 2007 22:14:48 +0100
From: elektra <onelektra@gmx.net>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] B.A.T.M.A.N. =?UTF-8?B?bMOkdWZ0IGpldHp0IGF1Y2g=?=
	=?UTF-8?B?IHBlcm1hbmVudCBhdWYgZGVyIFp3aW5nbGktTm9yZG9zdCAtIDEwNS4xMzAuMS4=?=
	=?UTF-8?B?Njc=?=
References: <200701071300.05634.lindner_marek@yahoo.de>
	<45A15E14.2080800@gmx.net>
In-Reply-To: <45A15E14.2080800@gmx.net>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

Hallo Lui -

habe Ich das richtig verstanden - BATMAN wählt von 3 direkten 
Linkstrecken ohne Zwischenhop die schlechtere? Kannst Du mal da Daten 
drüberjagen und schauen wie sich das mit der Geschwindigkeit verhält? 
Einfach mal n wget von der 105er und der 104er Adresse aus /dev/zero 
vielleicht?

cu elektra
>>
>> * Beim WLAN-Routing wählt BATMAN tendenziell den (schlechern?) direkten
>>  (1-Hop) Weg. Z.B. zwischen Emmaus und m99 über #_3 (105.192.66/.83) 
>> statt
>>  #_4 (105.192.99/.84) oder #_5 (105.192.133/.85)
>>
>> OLSR sieht das so auf 104.192.99.192 (=GW & 'Sternpunkt' für _3, _4 
>> und _5):
>> Nachbarn:
>> IP              Hyst.    LQ    lost    total    NLQ    ETX
>> 104.192.192.33    0.00    0.23    77    100    0.00    0.00
>> 104.192.192.66    0.00    0.42    58    100    0.48    4.98 # <- _3 | 
>> => von Batman gewählt.
>> 104.192.192.99    0.00    0.94    6    100    0.57    1.87 # <- _4 | 
>> typische ETX-Differenz
>> 104.192.192.133    0.00    0.93    7    100    0.66    1.63 # <- _5 | 
>> im Bereich +/-0,2 ...
>> 104.192.192.166    0.00    0.50    50    100    0.00    0.00
>>
>> ...das kann aber natürlich am OLSR-induzierten Traffic liegen.
>>
>> * top meint:
>> Load bei ~1.50 (+/- 0.30)
>> CPU typisch bei 22.0(+/- 5%)
>>
>> [Nachtrag (nach 11h Laufzeit):]
>> top/%MEM ist (_1 bis _8): 5.0/6.5/12.1(!)/6.6/6.7/4.8/3.0(!)/5.6
>> _7 (3.0) - mit -p Option gestartet
>> _3 (12.1) - OLSR routet ja via _4/_5 (s.o.), so ist das ein Kandidat,
>>             der (s.o.) häufiger komplett umroutet, weil der 
>> OLSR-induzierte
>>  Payload via _4/_5 schwankt...?
>>
>> Bei den anderen ist das ein schleichender Prozess... - ach ja, alles 
>> mit -r 2
>> Da dröppelt also noch irgend eine Speicher-Muffe...
>>
>> * Ins Log (nur _7) wird nix geschrieben...
>>
>> Ich würde ja mal einen Batman-Only Test fahren wollen...
>> Evtl. frage ich mal auf der 36er Liste nach Widerspruch und mache 
>> *ein* Paket
>>  aus freifunk-batman mit batmand, testtools, etc., dessen Startscript 
>> den
>>  olsrd mal abdreht ;-)
>>
>> Grüße
>> Lui
>>
>> -------------------------------------------------------
>>
>> _______________________________________________
>> B.A.T.M.A.N mailing list
>> B.A.T.M.A.N@open-mesh.net
>> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>>
>>   
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>

