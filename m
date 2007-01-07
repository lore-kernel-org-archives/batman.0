Message-ID: <45A15E14.2080800@gmx.net>
Date: Sun, 07 Jan 2007 21:54:44 +0100
From: elektra <onelektra@gmx.net>
MIME-Version: 1.0
References: <200701071300.05634.lindner_marek@yahoo.de>
In-Reply-To: <200701071300.05634.lindner_marek@yahoo.de>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] B.A.T.M.A.N.
 =?utf-8?q?l=C3=A4uft_jetzt_auch_permanent_auf_der_Zw?=
 =?utf-8?q?ingli-Nordost_-_105=2E130=2E1=2E67?=
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

Hat als Missing-Link zwischen der Wagenburg und der Jessener Strasse 
gefehlt. Funktioniert prima. Damit haben wir einen weiteren 6 
Megabit-Gateway. So langsam fangen die Routingtabellen an imposant 
auszusehen. Muss nur noch Hørst & Horst noch dazu animieren ihre alten 
batmand aufzurüsten. Der Link zur Emmaus ist allerdings ziemlich fragil.

Mit dem Webinterface ist es ein wahres Vergügen die Sache einzurichten.  
Konsequenterweise wäre es toll, wenn man auf der Batman-Statusseite die 
Anzahl der erfolgreich eingegangenen Orginatornachrichten angezeigt 
bekäme  - das interessiert natürlich am meisten wenn Batman läuft. Hmm. 
Wie könnte man das machen? Den Output von -d 1 nehmen? Und dann noch 
eine Liste der Gateways? Oder sollten wir olsrd Daten auf einem 
bestimmten Port ausgeben.

Ich  weiss nicht warum der Daemon nicht mehr crasht. Nicht dass Ich das 
jetzt vermissen würde. Marek, hast Du ausser mehr Debugging-Krams noch 
etwas anderes verändert?

Tolle Sache so eine Mailingliste. Zeit, die zu announcieren.

cu elektra


Marek Lindner schrieb:
> Hi,
>
> bin jetzt auch auf der Liste. Hier mal die aktuellen News ...  :-)
> Spricht was dagegen die anderen batman Aktivisten einzuladen auf die Liste zu 
> kommen ? Oder die Liste von der Webseite zu verlinken ?
>
> Gruß,
> Marek
>
> PS: Finde super, dass es diese Liste nun gibt - gute Arbeit !  
>
>
> ----------  Weitergeleitete Nachricht  ----------
>
> Subject: RE: Version 0.1.1.x?
> Date: Freitag, 5. Januar 2007 18:37
> From: "Ludger Schmudde" <Lui@schmudde.com>
> To: "'Marek Lindner'" <lindner-marek@diderot.phidelu>
>
> Holla,
>
>   
>>> ...wollte Emma gerade updaten - Du hattest (AFAIR) von '0.1.1a(lpha)'
>>> gesprochen - liegt noch 'n ...b(eta)? which is 'nu what?
>>>       
>> jo - nimm die beta. Habs noch ein bisschen verbessert.  :-)
>>     
>
> ...da hat sich ja über meine Weihnachtspause schön was getan ;-)
>
> 4+8 Router (8+16 IFs):
> ----------------------
> * LAN-Packetloss (wenn überhaupt) nahe 1/100... das waren bei den
>  Netzspielreien der letzten Tage *ohne Batman* eher 3-10 von 100...?
>  (zwischenzeitlich gab es aber mal /bursts/ bis zu 10%...??? Evtl. durch
>  meine intensiven http-requests verursacht, oder irgendwer hat nochmal
>  gespielt...?) * Das LAN-Routing schaut quasi handoptimiert aus ;-)
>
> Beispiel: _6.PharusEmmaus
> WLAN-IP:        LAN-IP:         2007.01.05-18:17:20
> 105.192.192.166 105.192.192.86
> _______________ _______________ __________________________
> 105.0.0.0       0.0.0.0         ---.0.0.0       U    eth1
> 105.130.30.1    0.0.0.0         ---.---.---.--- UH   eth1
> 105.192.192.1   105.192.192.81  ---.---.---.--- UGH  eth1
> 105.192.192.133 105.192.192.85  ---.---.---.--- UGH  eth1
> 105.192.192.225 105.192.192.88  ---.---.---.--- UGH  eth1
> 105.192.192.33  105.192.192.82  ---.---.---.--- UGH  eth1
> 105.192.192.66  105.192.192.83  ---.---.---.--- UGH  eth1
> 105.192.192.80  0.0.0.0         ---.---.---.240 U    br0
> 105.192.192.81  0.0.0.0         ---.---.---.--- UH   br0
> 105.192.192.82  0.0.0.0         ---.---.---.--- UH   eth1
> 105.192.192.83  0.0.0.0         ---.---.---.--- UH   br0
> 105.192.192.84  0.0.0.0         ---.---.---.--- UH   br0
> 105.192.192.85  0.0.0.0         ---.---.---.--- UH   eth1
> 105.192.192.87  0.0.0.0         ---.---.---.--- UH   eth1
> 105.192.192.88  0.0.0.0         ---.---.---.--- UH   br0
> 105.192.192.99  105.192.192.84  ---.---.---.--- UGH  eth1
> 105.192.99.103  105.192.192.133 ---.---.---.--- UGH  eth1
> 105.192.99.150  105.192.192.133 ---.---.---.--- UGH  eth1
> 105.192.99.192  105.192.192.85  ---.---.---.--- UGH  eth1
> 105.192.99.50   105.192.99.192  ---.---.---.--- UGH  eth1
> 105.192.99.60   105.192.192.83  ---.---.---.--- UGH  eth1
> 105.192.99.62   105.192.192.83  ---.---.---.--- UGH  eth1
>
> Frage: die IF-Spalte (letzte) macht wenig Sinn. Hat das Einfluß? Welchen?
> (eigendlich sollte da überall br0 stehen, außer bei den ersten beiden
>  Einträgen)
>
> * Beim WLAN-Routing wählt BATMAN tendenziell den (schlechern?) direkten
>  (1-Hop) Weg. Z.B. zwischen Emmaus und m99 über #_3 (105.192.66/.83) statt
>  #_4 (105.192.99/.84) oder #_5 (105.192.133/.85)
>
> OLSR sieht das so auf 104.192.99.192 (=GW & 'Sternpunkt' für _3, _4 und _5):
> Nachbarn:
> IP          	Hyst.	LQ	lost	total	NLQ	ETX
> 104.192.192.33	0.00	0.23	77	100	0.00	0.00
> 104.192.192.66	0.00	0.42	58	100	0.48	4.98 # <- _3 | => von Batman gewählt.
> 104.192.192.99	0.00	0.94	6	100	0.57	1.87 # <- _4 | typische ETX-Differenz
> 104.192.192.133	0.00	0.93	7	100	0.66	1.63 # <- _5 | im Bereich +/-0,2 ...
> 104.192.192.166	0.00	0.50	50	100	0.00	0.00
>
> ...das kann aber natürlich am OLSR-induzierten Traffic liegen.
>
> * top meint:
> Load bei ~1.50 (+/- 0.30)
> CPU typisch bei 22.0(+/- 5%)
>
> [Nachtrag (nach 11h Laufzeit):]
> top/%MEM ist (_1 bis _8): 5.0/6.5/12.1(!)/6.6/6.7/4.8/3.0(!)/5.6
> _7 (3.0) - mit -p Option gestartet
> _3 (12.1) - OLSR routet ja via _4/_5 (s.o.), so ist das ein Kandidat,
>             der (s.o.) häufiger komplett umroutet, weil der OLSR-induzierte
>  Payload via _4/_5 schwankt...?
>
> Bei den anderen ist das ein schleichender Prozess... - ach ja, alles mit -r 2
> Da dröppelt also noch irgend eine Speicher-Muffe...
>
> * Ins Log (nur _7) wird nix geschrieben...
>
> Ich würde ja mal einen Batman-Only Test fahren wollen...
> Evtl. frage ich mal auf der 36er Liste nach Widerspruch und mache *ein* Paket
>  aus freifunk-batman mit batmand, testtools, etc., dessen Startscript den
>  olsrd mal abdreht ;-)
>
> Grüße
> Lui
>
> -------------------------------------------------------
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>
>   

