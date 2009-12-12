Return-Path: <aaron@lo-res.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Apple Message framework v1077)
From: "L. Aaron Kaplan" <aaron@lo-res.org>
In-Reply-To: <801558.78070.qm@web111609.mail.gq1.yahoo.com>
Date: Sat, 12 Dec 2009 02:01:25 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <99C2F51C-5CF6-4047-96DA-CB432DDE8D3D@lo-res.org>
References: <102820.28764.qm@web111617.mail.gq1.yahoo.com>
	<48655D92-93E9-4E10-A84C-A9B86B69B54C@lo-res.org>
	<801558.78070.qm@web111609.mail.gq1.yahoo.com>
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
>=20
>>> This all makes sense to me, but what I don't understand is, why do =
all (or=20
>> nearly all ?) of the freifunk
>>> networks use OLSR, and continue to use OLSR on the freifunk firmware =
?

One aspect was the OLSR-NG project, which I started. OLSR.org was at =
that time programmed very inefficiently.
We (Hannes, Henning, Bernd, me) re-wrote large parts of OLSR and now it =
uses a < 5% CPU load on 200MHz linksys devices in a network of 400 =
nodes.
The CPU improvements were dramatic! It makes sense to use trees instead =
of linked lists sometimes :)
It makes sense, to use proper Dijkstra implementations instead of an =
O(n^2) implementation.
So the main critique point against OLSR (high CPU usage) was actually =
proven to be wrong.
It was simply the implementation which was broken (and got eventually =
fixed).

But for more reasons see below....

>>>=20
>>> Are any of the freifunk networks using BATMAN ?  If so, what routing =
metric=20
>> are they using with it ?
>=20

AFAIK the routing metric in BATMAN is "built-in" and not changeable.=20
But please correct me if there have been changes to that recently.
My know-how on this aspect might be outdated.

>=20
>=20
> This is the meat of what I am asking - I am wondering what context is =
it proper to use BATMAN, and the reason I am confused about it
> is that I see most (all ?) of the freifunk networks using OLSR.
>=20
> And as an aside, I am curious, if any freifunk networks are using =
BATMAN, what routing metric do they use ?
>=20
> Again, no interest in past politics, just trying to answer the "where =
did you get that idea" question in advance :)
>=20


(note: I am biased in this aspect, but I will try hard to stay as =
objective as possible now).

For the general understanding: the freifunk (and funkfeuer.at) networks =
were already using OLSR at the point in time when the BATMAN idea came.
It was probably nearly impossible to make everyone switch from OLSR to =
BATMAN (or any other protocol). The problem in the freifunk networks is =
that there was never a centrally planned upgrade mechanism. Every node =
is owned by someone else.

The other reason is that - objectively speaking - not everyone in the =
freifunk networks believes in either the matureness / stability / =
scalability of BATMAN or has some other favorite routing protocol (Babel =
comes to mind, others use lots of BGP). BATMAN is of course a very =
smart, unique and interesting idea... but OLSR has it's advantages in =
the eyes of others (stable and mature plugin architecture, well tested, =
RFC standard, around 50 implementations of OLSR worldwide, academic =
background, etc )

In addition, there are also plenty of other MANET protocols:   =
http://en.wikipedia.org/wiki/List_of_ad-hoc_routing_protocols
To my knowledge, finding "the best MANET protocol" is an unsolved =
research topic :)
There are always trade-offs.


Personally I am also starting to firmly believe that the layer 2.5 (or =
layer 3) routing protocol does not matter so much anymore if the lower =
levels (Wi-Fi) are not stable enough. We can probably fight all the time =
about routing protocols but miss the point that we need a good layer 1 =
and 2 as a basis ;)))

Ok, I hope I could answer that as objectively as possible.


a.



