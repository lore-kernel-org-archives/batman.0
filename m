Return-Path: <ruben@vfn-nrw.de>
From: Ruben Kelevra <ruben@vfn-nrw.de>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (1.0)
Message-Id: <C3123DAF-BBD2-4477-81B6-B3F57169DE3C@vfn-nrw.de>
Date: Fri, 18 Dec 2015 00:02:33 +0100
References: <CAKrZ8yfKQi8qBzmC7BrEA6Sfug9JB4hb5q_M6p20Ay-V35-F4A@mail.gmail.com>
In-Reply-To: <CAKrZ8yfKQi8qBzmC7BrEA6Sfug9JB4hb5q_M6p20Ay-V35-F4A@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] Super high package loss and weak connection
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

VDid you double-check for hardware-issues? Might be a compatibility issue wi=
th you wifi hardware.

What are you link values between each peers? (batctl o where row 1 is equal r=
ow 2)

Which wifi-mode do you use? Did you tried 802.11s instead of adhoc or vice v=
ersa?

Did you tried batman L2 pings instead of icmp-ones?

Best regards

Ruben

> Am 17.12.2015 um 21:52 schrieb no name <keinepostnurmuell@gmail.com>:
>=20
> Hello there
>=20
> Hallo (deutsche Version unten)
>=20
>=20
> I have  a simple batman setup that does behave odd:
>=20
>=20
> Raspberry b+, jessie, batman-adv2015.2 witha single LOGILINK WL0084B
> USB wifi stick attached
>=20
>=20
> I have 5 rasperries that can see each other via wifi (one of them is a
> gw(BASE2), one of them (SHELF_1) is not directly reachable by the gw,
> because they are in a line from one room to another and has to be
> reached via one single hop in between)
>=20
>=20
> digraph {
>=20
> {
>                "BASE_2"
>        }
>        "BASE_2" -> "SHELF_3 @ ra" [label=3D"1.689"]
>        "BASE_2" -> "SHELF_5 @ Bar" [label=3D"1.689"]
>        "BASE_2" -> "SHELF_2 @ CD Regal" [label=3D"2.161"]
>        "BASE_2" -> "SHELF_4 @ Toaster" [label=3D"2.161"]
>        "BASE_2" -> "SHELF_1 @ Chris" [label=3D"2.040"]
>        subgraph "cluster_SHELF_3 @ ra" {
>                "SHELF_3 @ ra"
>        }
>        "SHELF_3 @ ra" -> "SHELF_5 @ Bar" [label=3D"1.192"]
>        "SHELF_3 @ ra" -> "SHELF_4 @ Toaster" [label=3D"1.328"]
>        "SHELF_3 @ ra" -> "BASE_2" [label=3D"2.277"]
>        subgraph "cluster_SHELF_4 @ Toaster" {
>                "SHELF_4 @ Toaster"
>        }
>        "SHELF_4 @ Toaster" -> "SHELF_3 @ ra" [label=3D"1.037"]
>        "SHELF_4 @ Toaster" -> "SHELF_2 @ CD Regal" [label=3D"1.483"]
>        "SHELF_4 @ Toaster" -> "SHELF_5 @ Bar" [label=3D"1.175"]
>        "SHELF_4 @ Toaster" -> "SHELF_1 @ Chris" [label=3D"1.371"]
>        "SHELF_4 @ Toaster" -> "BASE_2" [label=3D"3.446"]
>        subgraph "cluster_SHELF_1 @ Chris" {
>                "SHELF_1 @ Chris"
>        }
>        "SHELF_1 @ Chris" -> "SHELF_3 @ ra" [label=3D"1.170"]
>        "SHELF_1 @ Chris" -> "SHELF_5 @ Bar" [label=3D"1.020"]
>        subgraph "cluster_SHELF_5 @ Bar" {
>                "SHELF_5 @ Bar"
>        }
>        "SHELF_5 @ Bar" -> "SHELF_3 @ ra" [label=3D"1.045"]
>        "SHELF_5 @ Bar" -> "SHELF_2 @ CD Regal" [label=3D"1.393"]
>        "SHELF_5 @ Bar" -> "SHELF_4 @ Toaster" [label=3D"1.203"]
>        "SHELF_5 @ Bar" -> "SHELF_1 @ Chris" [label=3D"1.226"]
>        "SHELF_5 @ Bar" -> "BASE_2" [label=3D"2.898"]
>=20
> =EF=BB=BF}
>=20
> The problem is, when pinging ANY of the clients from the base (or any
> client from any other client) I always have a package loss of roughly
> 50% with a ping reply time up to 10ms sometimes (BASE2 -> SHELF_1, the
> closer ones are faster). To make things worse, the connection is so
> weak, even a ssh login may bring it down.
>=20
>=20
> I tried quite a few different settings and already updated to the new
> version and used multiple USB sticks - the result always stays the
> same. Now I am out of ideas and I would appreciate some new ideas.
>=20
> =EF=BB=BF
>=20
>=20
> GERMAN:
>=20
>=20
> Ich habe hier 5 Raspberries die sich gegenseitig sehen k=C3=B6nnen (einer
> ist eine BASIS (BASE2), einer davon (SHELF_1) kann von der Basis nicht
> direkt gesehen werden, weil sie von einem raum zum n=C3=A4chsten immer
> gr=C3=B6=C3=9Fere Distanzen =C3=BCberwinden m=C3=BCssen).
>=20
>=20
> Das Problem ist nun, dass wenn ich irgend einen client von der Basis
> aus pinge, oder irgend einen client von einem anderen client pinge,
> dass ich rund 50% package loss mit bis zu 10ms antwortzeit habe. Die
> die sich n=C3=A4her sind funktionieren besser (2ms) die weiter weg sind
> schlechter. Ich kann nicht mal mit einer ssh konsole von BASE2 auf
> SHELF_1 so dass ich da sinnvoll was eingeben kann.
>=20
>=20
> Ich habe schon einige verschiedene Optionen durchprobiert, wie
> Beispielsweise Update von 2015.0 auf 2015.2, sogar zwei USB Sticks pro
> Raspberry PI, aber das Problem bleibt. Nun w=C3=BCrde ich um Input bitten,=

> mir sind die Ideen ausgegangen.
>=20
>=20
> Danke
>=20
> Thanks a lot!
>=20
> Richard
