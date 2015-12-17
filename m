Return-Path: <keinepostnurmuell@gmail.com>
MIME-Version: 1.0
Date: Thu, 17 Dec 2015 21:52:19 +0100
Message-ID: <CAKrZ8yfKQi8qBzmC7BrEA6Sfug9JB4hb5q_M6p20Ay-V35-F4A@mail.gmail.com>
From: no name <keinepostnurmuell@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [B.A.T.M.A.N.]  Super high package loss and weak connection
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

=EF=BB=BFHello there

Hallo (deutsche Version unten)


I have  a simple batman setup that does behave odd:


Raspberry b+, jessie, batman-adv2015.2 witha single LOGILINK WL0084B
USB wifi stick attached


I have 5 rasperries that can see each other via wifi (one of them is a
gw(BASE2), one of them (SHELF_1) is not directly reachable by the gw,
because they are in a line from one room to another and has to be
reached via one single hop in between)


digraph {

{
                "BASE_2"
        }
        "BASE_2" -> "SHELF_3 @ ra" [label=3D"1.689"]
        "BASE_2" -> "SHELF_5 @ Bar" [label=3D"1.689"]
        "BASE_2" -> "SHELF_2 @ CD Regal" [label=3D"2.161"]
        "BASE_2" -> "SHELF_4 @ Toaster" [label=3D"2.161"]
        "BASE_2" -> "SHELF_1 @ Chris" [label=3D"2.040"]
        subgraph "cluster_SHELF_3 @ ra" {
                "SHELF_3 @ ra"
        }
        "SHELF_3 @ ra" -> "SHELF_5 @ Bar" [label=3D"1.192"]
        "SHELF_3 @ ra" -> "SHELF_4 @ Toaster" [label=3D"1.328"]
        "SHELF_3 @ ra" -> "BASE_2" [label=3D"2.277"]
        subgraph "cluster_SHELF_4 @ Toaster" {
                "SHELF_4 @ Toaster"
        }
        "SHELF_4 @ Toaster" -> "SHELF_3 @ ra" [label=3D"1.037"]
        "SHELF_4 @ Toaster" -> "SHELF_2 @ CD Regal" [label=3D"1.483"]
        "SHELF_4 @ Toaster" -> "SHELF_5 @ Bar" [label=3D"1.175"]
        "SHELF_4 @ Toaster" -> "SHELF_1 @ Chris" [label=3D"1.371"]
        "SHELF_4 @ Toaster" -> "BASE_2" [label=3D"3.446"]
        subgraph "cluster_SHELF_1 @ Chris" {
                "SHELF_1 @ Chris"
        }
        "SHELF_1 @ Chris" -> "SHELF_3 @ ra" [label=3D"1.170"]
        "SHELF_1 @ Chris" -> "SHELF_5 @ Bar" [label=3D"1.020"]
        subgraph "cluster_SHELF_5 @ Bar" {
                "SHELF_5 @ Bar"
        }
        "SHELF_5 @ Bar" -> "SHELF_3 @ ra" [label=3D"1.045"]
        "SHELF_5 @ Bar" -> "SHELF_2 @ CD Regal" [label=3D"1.393"]
        "SHELF_5 @ Bar" -> "SHELF_4 @ Toaster" [label=3D"1.203"]
        "SHELF_5 @ Bar" -> "SHELF_1 @ Chris" [label=3D"1.226"]
        "SHELF_5 @ Bar" -> "BASE_2" [label=3D"2.898"]

=EF=BB=BF}

The problem is, when pinging ANY of the clients from the base (or any
client from any other client) I always have a package loss of roughly
50% with a ping reply time up to 10ms sometimes (BASE2 -> SHELF_1, the
closer ones are faster). To make things worse, the connection is so
weak, even a ssh login may bring it down.


I tried quite a few different settings and already updated to the new
version and used multiple USB sticks - the result always stays the
same. Now I am out of ideas and I would appreciate some new ideas.

=EF=BB=BF


GERMAN:


Ich habe hier 5 Raspberries die sich gegenseitig sehen k=C3=B6nnen (einer
ist eine BASIS (BASE2), einer davon (SHELF_1) kann von der Basis nicht
direkt gesehen werden, weil sie von einem raum zum n=C3=A4chsten immer
gr=C3=B6=C3=9Fere Distanzen =C3=BCberwinden m=C3=BCssen).


Das Problem ist nun, dass wenn ich irgend einen client von der Basis
aus pinge, oder irgend einen client von einem anderen client pinge,
dass ich rund 50% package loss mit bis zu 10ms antwortzeit habe. Die
die sich n=C3=A4her sind funktionieren besser (2ms) die weiter weg sind
schlechter. Ich kann nicht mal mit einer ssh konsole von BASE2 auf
SHELF_1 so dass ich da sinnvoll was eingeben kann.


Ich habe schon einige verschiedene Optionen durchprobiert, wie
Beispielsweise Update von 2015.0 auf 2015.2, sogar zwei USB Sticks pro
Raspberry PI, aber das Problem bleibt. Nun w=C3=BCrde ich um Input bitten,
mir sind die Ideen ausgegangen.


Danke

Thanks a lot!

Richard
