Date: Tue, 6 Nov 2007 08:24:47 +0000 (GMT)
From: Marek Lindner <lindner_marek@yahoo.de>
Subject: AW: [B.A.T.M.A.N.] 0.3-beta-rv779 and rv780
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Message-ID: <709285.93018.qm@web26901.mail.ukl.yahoo.com>
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>



> The non-usual setup: you have different parts of your mesh operating in
=20
> different subnets you need an additional ip rule to make the nodes in
 the=20
> non-homed subnet reachable from a node which has no interface in that
 subnet.=20
> So for example, if your setup looks like:
>      A---------------------B1_B2---------------C
> 10.0.0.1/24       10.0.0.2/24 10.0.1.2/24  10.0.1.3/24  =20
>=20
> the easiest way to do achieve that at A and C is:
> $ ip rule add from all pref 6500 t 66

Wouldn't be HNA the much better solution ? Node B should announce one of=20
the networks. To not rebroadcast OGMs from the wrong network batman
should check if the received originator IP is within the own network.



Regards,
Marek




      Jetzt Mails schnell in einem Vorschaufenster =FCberfliegen. Dies und =
viel mehr bietet das neue Yahoo! Mail - www.yahoo.de/mail

