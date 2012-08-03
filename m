Return-Path: <luca.pretto@gmail.com>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Apple Message framework v1278)
From: Luca Pretto <luca.pretto@gmail.com>
In-Reply-To: <2670997.NDZah7qDiQ@bentobox>
Date: Fri, 3 Aug 2012 11:40:43 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <B6EC8CB5-DDE0-4708-B89E-FADE58F33026@gmail.com>
References: <BB2F02D2-9B93-465E-BB7D-FA13492511BF@gmail.com>
 <2670997.NDZah7qDiQ@bentobox>
Subject: Re: [B.A.T.M.A.N.] Batman-adv and routed subnets
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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

Thanks for your answer Sven.

So, I've obviously misunderstood the part "mixing non-B.A.T.M.A.N. =
systems with batman-adv" [&]
I admit: the fact that batman-adv operates al L2 really confuses me a =
lot!
I'm a DIY nerd with no background training, so it's quite difficult to =
me.. But I won't give up! ;D

So, do you think that I should try to setup OSPF on every node, to keep =
the thing as-much-auto-scaling-as-possible?

But in that case I suspect I won't be able to use the "Gateway support" =
functions. Is it correct? [%]

Have a nice day,
Luca

[&] http://www.open-mesh.org/projects/batman-adv/wiki/Quick-start-guide
[%] http://www.open-mesh.org/projects/batman-adv/wiki/Gateways

Il giorno 03/ago/2012, alle ore 11:22, Sven Eckelmann ha scritto:

> First thing: batman-adv doesn't route (as in l3 routing). batman-adv =
creates a=20
> distributed switch on l2 (so, batman-adv does path finding). =
Therefore,=20
> batman-adv doesn't care about the l3 stuff.
>=20
> And the stuff you've mentioned above is l3 stuff. So out of scope for =
batman-
> adv. Either you create static routes, use proxy arp or use another =
software=20
> that distributes the l3 routes.
>=20
> Kind regards,
> 	Sven

