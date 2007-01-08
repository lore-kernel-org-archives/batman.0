Date: Mon, 8 Jan 2007 14:15:44 +0100 (MET)
From: Marek Lindner <lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200701081401.39454.lindner_marek@yahoo.de>
Content-Transfer-Encoding: quoted-printable
Subject: [B.A.T.M.A.N.] IP Aggregation
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

die folgende Idee ist auf dem Kongress in diversen Diskussionen entstanden =
und=20
bei weitem noch nicht ausgereift. Mich w=FCrde eure Meinung dazu interessie=
ren.=20

Bisher rebroadcastet jeder batman Knoten alle batman Pakete (wir ignorieren=
=20
die Ausnahmen jetzt mal). K=F6nnen wir einen geschickten Algorithmus=20
entwickeln / anwenden, der es uns gestattet an Stelle des Rebroadcasts der =

Nachbar-Nachrichten HNA informationen in unserem Paket mitzusenden ?

So k=F6nnte das funktioneren: Mein batman Knoten merkt, dass er 3 one Hop=20
Nachbarn hat, welche keine anderen Nachbarn hinter sich haben. Daher nehme =

ich diese Nachbarn als HNA auf. Meine anderen Nachbarn erhalten nun das Pak=
et=20
und k=F6nnen feststellen, dass meine IP und die IPs meine Nachbarn ziemlich=
=20
dicht beieinander sind und stopfen uns alle in eine HNA Nachricht.

Die Vorteil liegt auf der Hand: Weniger batman Pakete und weniger=20
Routeneintr=E4ge.

Wir m=FCssten das aber so geschickt machen, dass wir nicht unsere eigene=20
Statistik f=E4lschen. Wenn ich zu meinem aggregierten Nachbarn 50% packet l=
oss=20
habe, ihn aber in jeder meine OGMs erw=E4hne, k=F6nnte der Eindruck entsteh=
en,=20
dass der Link recht gut ist ?!

Was meint ihr ?

Gru=DF,
Marek

