Message-ID: <45A27A1A.3030608@gmx.net>
Date: Mon, 08 Jan 2007 18:06:34 +0100
From: elektra <onelektra@gmx.net>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] IP Aggregation
References: <200701081401.39454.lindner_marek@yahoo.de>
In-Reply-To: <200701081401.39454.lindner_marek@yahoo.de>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
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

Hi Marek -
> Die Vorteil liegt auf der Hand: Weniger batman Pakete und weniger=20
> Routeneintr=E4ge.
>  =20
der Nachteil ist erh=F6hte Komplexizit=E4t der Sache. Der Vorschlag geht in=
=20
die Richtung Methoden aus Linkstate Protokollen zu =FCbernehmen.=20
Prinzipiell spricht nichts dagegen.

Ich w=FCrde vorschlagen alle notwendigen Schritte zu machen, so dass der=20
Code tendenziell die bestm=F6glichen Entscheidungen beim Routing trifft.=20
Wenn Uns Linkstate-Komponenten dabei helfen (ETX-Werte zu=20
Single-Hop-Nachbarn) k=F6nnen wir gerne darauf zur=FCckgreifen. Bislang seh=
e=20
Ich die Notwendigkeit jedoch nicht. Wenn der Code dann beim Routing sein=20
Bestes gibt k=F6nnen wir schauen wie wir ihn in Richtung Skalierbarkeit=20
optimieren.

Was die Abst=FCrze angeht kann Ich die Aussage von Lui nur best=E4tigen -  =

wir haben ein Memory-Leak. Der Speicherverbrauch stieg auf der Zwingli=20
mit etwa 0.2% des Gesamtspeichers pro Stunde. Ich habe den Daemon=20
daraufhin wieder abgeschaltet, da Ich ungern die Zwingli lahmlegen=20
m=F6chte - ein Neustart geht leider nicht remote. Auf dem WRT in der=20
Wagenburg l=E4uft der Daemon seit Tagen durch - der Speicherverbauch=20
betr=E4gt konstant 2,7 %.

Ziemlich omin=F6s das Ganze...

Was haltet Ihr davon auf der Liste in English zu schreiben? Bislang ist=20
Deutsch ok - aber wir bauen damit potentiell eine Barriere auf.

cu elektra
