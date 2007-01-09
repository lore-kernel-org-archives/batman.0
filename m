Date: Tue, 9 Jan 2007 15:15:42 +0100 (MET)
From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] IP Aggregation
References: <200701081401.39454.lindner_marek@yahoo.de>
	<45A27A1A.3030608@gmx.net>
In-Reply-To: <45A27A1A.3030608@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200701091453.27005.lindner_marek@yahoo.de>
Content-Transfer-Encoding: quoted-printable
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


Hi,

> Ich w=FCrde vorschlagen alle notwendigen Schritte zu machen, so dass der
> Code tendenziell die bestm=F6glichen Entscheidungen beim Routing trifft.
> Wenn Uns Linkstate-Komponenten dabei helfen (ETX-Werte zu
> Single-Hop-Nachbarn) k=F6nnen wir gerne darauf zur=FCckgreifen. Bislang s=
ehe
> Ich die Notwendigkeit jedoch nicht. Wenn der Code dann beim Routing sein
> Bestes gibt k=F6nnen wir schauen wie wir ihn in Richtung Skalierbarkeit
> optimieren.

sch=F6n. Wollte das nicht sofort einbauen, aber solche Ideen brauchen ein=20
bisschen Zeit.  ;-)


> Was die Abst=FCrze angeht kann Ich die Aussage von Lui nur best=E4tigen -
> wir haben ein Memory-Leak. Der Speicherverbrauch stieg auf der Zwingli
> mit etwa 0.2% des Gesamtspeichers pro Stunde. Ich habe den Daemon
> daraufhin wieder abgeschaltet, da Ich ungern die Zwingli lahmlegen
> m=F6chte - ein Neustart geht leider nicht remote. Auf dem WRT in der
> Wagenburg l=E4uft der Daemon seit Tagen durch - der Speicherverbauch
> betr=E4gt konstant 2,7 %.
> Ziemlich omin=F6s das Ganze...

In der Tat eigenartig. Gibt es irgendwelche bekannten Unterschiede wie:=20
Startparameter, Nachbarkonstellation, etc ?

Um den Memory Leaks auf die Schliche zu kommen habe ich unseren internen=20
MemoryChecker so umgebaut, dass er nun etwas brauchbares Auspuckt. An den=20
Problemorten einfach mit Debuglevel > 0 starten, eine Weile laufen lassen u=
nd=20
den Speicherverbrauch beobachten. Wenn dieser ansteigt, muss batman beendet=
=20
werden und dann sollte ein solcher Output erscheinen:

Memory leak detected, malloc tag =3D 7
Memory leak detected, malloc tag =3D 7
Memory leak detected, malloc tag =3D 7
Memory leak detected, malloc tag =3D 7
Memory leak detected, malloc tag =3D 6
Memory leak detected, malloc tag =3D 2
Memory leak detected, malloc tag =3D 1

Schickt mir den dann einfach.
Es ist durchaus denkbar, dass ihr diesen Output *nicht* seht. Der=20
MemoryChecker kann nur "richtige" MemoryLeaks finden (benutzer Speicher, de=
r=20
nicht freigegeben wurde). M=F6glicherweise handelt es sich aber um "logisch=
e"=20
MemoryLeaks (es wird immer mehr und mehr Speicher angefordet, beim Beenden =

aber alles wieder freigegeben). Letzteres w=E4re im Output nat=FCrlich nich=
t=20
sichtbar.

Gru=DF,
Marek


