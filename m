Date: Wed, 14 Nov 2007 07:30:15 +0000 (GMT)
From: Marek Lindner <lindner_marek@yahoo.de>
Subject: AW: [B.A.T.M.A.N.] wrong ip rules
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Message-ID: <470056.58415.qm@web26904.mail.ukl.yahoo.com>
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



Hi,


> 6598:   from all to 104.0.0.0/8 lookup olsr
> 6599:   from 104.0.0.0/8 lookup olsr

> 6598:   from all to 104.0.0.0/8 lookup olsr
> 6599:   from 104.0.0.0/8 lookup olsr

> 6802:   from 104.0.0.0/8 lookup 68

> batmand delete olsr-rules and set "from 104.0.0.0/8 lookup 68"!?

which olsr-rules are deleted ? I can't see a difference there.

In table 68 is the batman default route. All interfaces not controlled
by batmand are routed towards this routing table. If you don't want
that OLSR traffic is routed into the batman default route you have
2 choices:
- You deleted the OLSR rules after each batmand start (hackish).
- You use the --no-policy-routing option and set all rules by=20
yourself. This option allows a tight integration into a firmware and
full control of the policy routing.

Why does batmand not recognize OLSR interfaces and=20
ignores them ? We simply could not find a good solution for
this kind of detection but we are open to suggestions.  ;-)

Greetings,
Marek






       __________________________________ Ihr erstes Fernweh? Wo gibt es de=
n sch=F6nsten Strand? www.yahoo.de/clever

