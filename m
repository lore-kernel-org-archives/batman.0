Mime-Version: 1.0 (Apple Message framework v752.3)
Message-Id: <E82C5AD5-131B-41A9-9B3F-26924A75A74A@gmx.net>
Content-Type: text/plain; charset="iso-8859-1"; delsp="yes"; format="flowed"
From: Hendrik <cloughar@gmx.net>
Date: Fri, 9 Feb 2007 09:30:52 +0100
Content-Transfer-Encoding: quoted-printable
Subject: [B.A.T.M.A.N.] Probleme mit Routing bei BATMAN
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

Hallo,
ich wollte mal BATMAN ausprobieren und habe hierzu folgendes Netz =20
aufgebaut:

A --- B ---- C (stehen alle drei direkt nebeneinander)
(IP: 192.168.0.	A:3
				B:1
				C:2)
So, bei einer direkten Kommunikation klapp alles ganz toll (und =20
schnell!). Sobald ich aber in A via iptables sage, dass er nichts =20
mehr von der MAC-Adr. von C annehmen soll (und andersherum) - spich =20
so tue als ob die Nodes A und C keine Funkverbindung mehr haben, =20
Klappt das Routing =FCber B nicht. B sagt zwar, dass es A und C kennt/=20
h=F6rt, A kennt aber nur B und C auch nur B (nicht aber den Weg dahinter)

Der Debug auf Node A (192.168.0.3) auf Level 3  gab mir folgendes aus:

[     39552] Received BATMAN packet from 192.168.0.1 (originator =20
192.168.0.2, seqno 162, TTL 49)
[     39552] update_last_hop(): Searching originator entry of last-=20
hop neighbour of received packet
[     39552] new packet - orig: 192.168.0.2, sender: 192.168.0.1
[     39552] Packet with unidirectional flag
[     39552] purge()
[     39552] ------------------ DEBUG ------------------
[     39552] Forward list
[     39552]     192.168.0.3 at 40000
[     39552] Originator list
[     39552] 192.168.0.1, last_aware:39552, last_reply:36003, =20
last_seen:1153 via:
[     39552] ---------------------------------------------- END DEBUG
[     39552]

Er bekommt also =FCber B (192.168.0.1) von C (192.168.0.2) eine =20
Message, kann damit aber nichts anfangen.


Ich benutze batman-III-0.1-rc1auf einem Debian Sarge System ohne tun.


Danke f=FCr eure Hilfe
Hendrik


