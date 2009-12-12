Return-Path: <aaron@lo-res.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Apple Message framework v1077)
From: "L. Aaron Kaplan" <aaron@lo-res.org>
In-Reply-To: <99C2F51C-5CF6-4047-96DA-CB432DDE8D3D@lo-res.org>
Date: Sat, 12 Dec 2009 02:14:06 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <7E3DFBF9-3D2C-493B-9279-9CE3F5DBF97B@lo-res.org>
References: <102820.28764.qm@web111617.mail.gq1.yahoo.com>
	<48655D92-93E9-4E10-A84C-A9B86B69B54C@lo-res.org>
	<801558.78070.qm@web111609.mail.gq1.yahoo.com>
	<99C2F51C-5CF6-4047-96DA-CB432DDE8D3D@lo-res.org>
Subject: Re: [B.A.T.M.A.N.] BATMAN development vs. Freifunk usage of OLSR ?
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

>=20
> One aspect was the OLSR-NG project, which I started. OLSR.org was at =
that time programmed very inefficiently.
> We (Hannes, Henning, Bernd, me) re-wrote large parts of OLSR and now =
it uses a < 5% CPU load on 200MHz linksys devices in a network of 400 =
nodes.
Sorry, forgot to add: Sven-Ola, Markus and quite a few others.

> The CPU improvements were dramatic! It makes sense to use trees =
instead of linked lists sometimes :)
> It makes sense, to use proper Dijkstra implementations instead of an =
O(n^2) implementation.
> So the main critique point against OLSR (high CPU usage) was actually =
proven to be wrong.
> It was simply the implementation which was broken (and got eventually =
fixed).
>=20


a.

