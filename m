Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Fri, 9 Mar 2012 09:56:36 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20120309085636.GA9018@pandem0nium>
References: <4F4F6D18.3070403@ninux.org>
	<201203070156.51341.lindner_marek@yahoo.de>
	<20120306193643.GM12778@kerneis.info>
	<201203070552.33850.lindner_marek@yahoo.de>
	<7i62egijym.fsf@lanthane.pps.jussieu.fr>
	<20120307144709.GA19891@ritirata.org>
	<7ieht4mnnp.fsf@lanthane.pps.jussieu.fr>
	<20120307171751.GC1389@ritirata.org>
	<20120307221847.GR12778@kerneis.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <20120307221847.GR12778@kerneis.info>
Subject: Re: [B.A.T.M.A.N.] [Battlemesh] Battlemesh v5 tests
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Battle of the Mesh Mailing List <battlemesh@ml.ninux.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Gabriel,

thanks for bringing the discussion to the batman ml and giving some constru=
ctive
input. I've written this bonding/alternating feature some time ago, and we =
released
it at WBMv3 together with this little documentation to be found in the wiki=
=2E Actually,
I considered the feature rather simple and therefore I did not write too mu=
ch about it
- because there is not really much to write about, or so I thought. Obvious=
ly, there
were some things unclear, so thanks for pointing me/us to that.=20

When implementing, it is easy to miss some things that are not that obvious
for outsiders, so please feel free to ask or suggest things. We'll rework t=
he
bonding/interface alternating part in the next days, and would be
happy to include your suggestions. :)

Usually, we create the protocol documentation for the purpose of review and
documentation for other batman-adv devs - and we don't expect that they all
fall on the head at the same time. They are meant to describe the concept a=
nd
not the actual implementation with all their nasty details.

On Wed, Mar 07, 2012 at 11:18:48PM +0100, Gabriel Kerneis wrote:
> [CC: b.a.t.m.a.n@lists.open-mesh.org, see note 3 in particular]
>=20
> Antonio,
>=20
> On Wed, Mar 07, 2012 at 06:17:52PM +0100, Antonio Quartulli wrote:
> > Technical details about what? Interface-alternating? It is there!
> > Gabriel wrote the link. =20
>=20
> No. Please re-read my email carefuly.  The wiki contains a rough explanat=
ion of
> the general principle (ie. =E2=80=9Csame interface =3D bad, different int=
erface =3D good=E2=80=9D).
> Not the actual algorithm used by batman-adv (quoting from the wiki: =E2=
=80=9Cthe
> algorithm tries to avoid forwarding packets on the interface which just r=
eceived
> the packet=E2=80=9D).
>=20
> Note that the wiki has been updated since then, by Simon with a few more
> details [1], and by Marek with benchmark results from WBMv3.
>=20

Maybe "algorithm" is a big word for a little feature like that. The bonding
and interface alternating basically work in two steps:

 1) detect that a neighbor is reachable via two different links
 2) use the two different links for various manipulations (bonding, interfa=
ce alternation)

1) The detection part is batman-specific, we use the the PRIMARIES_FIRST_HO=
P flag
to do that. As a reminder (that might be documented somewhere else):

 * OGMs from the primary interface are broadcasted on ALL interfaces and ar=
e spread over
   the mesh (big TTL) --> these get the PRIMARIES_FIRST_HOP flag, which is =
cleared
   when forwarded by other nodes
 * OGMs from the secondary interfaces are only broadcasted on their respect=
ive interface
   and are only used for local link sensing (TTL =3D 1)

When we receive OGMs with PRIMARIES_FIRST_HOP flags on different interfaces=
, we know
that it came from the same neighbor, just from different interfaces. We hav=
e two
links to this neighbor.

2) the manipulation step is independent of the routing protocol, as long as=
 the routing
protocol routes packets based on their destination and does not care about =
on which
interface it comes in.

Because we already made our routing decision (we have chosen a neighbor), i=
t does not
matter on which link we send the frame. We use this freedom to either use a=
nother
interface where the frame came in (interface alternation) or round-robin ov=
er the
available, detected links (bonding). Note that this would work on any routi=
ng protocol
and is independent of the BATMAN routing.

However, we need the fact that we are on layer 2 and can decide on the pack=
et link usage
in batman-adv. This would not work so easily with static layer 3 routing ta=
bles, I suppose.

> > Gabriel said he has not enough time to look into it. I'm sorry, but I d=
on't think
> > this is a good reason to blame batman-adv devs :P
>=20
> I finally decided to settle this issue and spent my breakfast reading
> batman-adv/routing.c [2] instead of my favorite newspaper.  Here is what I
> understood:
>=20
>     At all times, batman-adv maintains a list of "bonding candidates" for=
 each
>     node (bonding_candidate_add, called from bat_iv_ogm.c:699).
>     Some node "neigh" is a bonding candidate for another node "orig" if a=
nd only
>     if:
>     - neigh and orig have the same primary address, ie. are in fact the s=
ame
>       router,

that's right - we are talking about one neighbor, and the bonding candidate=
s are the
available links to this neighbor.

>     - the links to reach them have the same quality up to some additive
>       constant (BONDING_TQ_THRESHOLD =3D 50) [3],

Yep, it would be useless if we can reach one link perfectly and the other o=
ne
is dropping all the packets. We want similar TQ quality.

>     - orig does not already have another bonding candidate for the same
>       interface, because it could interfere =E2=80=93 but what if the nei=
gh has a better
>       link quality, isn=E2=80=99t it a pity to ignore it?

If it had a better quality, it would have been chosen as router already - a=
t least
we expect that here. Maybe this is a little rough, but using the same inter=
face/frequency
is far worse, IMHO.


>=20
>     Then, assuming that "interface alternating" is enabled, the list of b=
onding
>     candidates is used on every route selection (find_ifalter_router, cal=
led
>     from routing.c:769).

Thats right. Interface alternating is always enabled, BTW.

>     More precisely, once batman has chosen a next-hop router for a packet=
 based
>     on its classical routing algorithm, it walks the list of the bonding
>     candidates associated to the primary interface for this router [4].  =
It
>     selects the actual next-hop on the following criteria:
>     - it must not be on the same interface as the packet came in,
>     - its quality must be as high as possible (given the previous constra=
int).
>=20
> This is the kind of explanation I would have loved to find on the wiki.  =
By the
> way, consider it public domain and feel free to copy/paste/correct it if =
you
> wish.

Thanks for sharing your explanation. I will happily include it on the rewor=
k of
this section.=20

>=20
> It is still not clear to me exactly why this works, but I believe this is=
 what
> the code does, and is definitely easier to discuss than generic, unsubsta=
ntiated
> claims.
>=20
> Best regards,
> Gabriel
>=20
> [1] =E2=80=9CInterface alternating is only performed if the two candidate=
 links to the
>     next hop have a similar quality.=E2=80=9D
>     http://www.open-mesh.org/wiki/batman-adv/Multi-link-optimize
>=20
> [2] http://www.open-mesh.org/projects/batman-adv/repository/revisions/mas=
ter/entry/routing.c
>=20
> [3] By the way, there is something I don=E2=80=99t understand: neigh_node=
->tq_avg will be
>     accepted event if it is far greater than router->tq_avg + BONDING_TQ_=
THRESHOLD.
>     Shouldn=E2=80=99t it be: abs(neigh_node->tq_avg - router->tq_avg) > B=
ONDING_TQ_THRESHOLD?
>     http://www.open-mesh.org/projects/batman-adv/repository/revisions/mas=
ter/entry/routing.c#L166

We expect that router->tq_avg is already the highest, so neigh_node->tq_avg=
 shouldn't
be (far) higher than router->tq_avg.
>=20
> [4] Why the primary and not the chosen router directly? Is the bonding
>     candidates list always associated to the primary interface?

We might have chosen the originator of a secondary interface, but should al=
so
have the originator of the primary interface (as explained above, we receive
this over the secondary interfaces as well). The primary orig will have all
neighbors from secondary interfaces as well, and yes, the bonding candidate=
s are
only associated to this primary originator (to avoid duplication of the sam=
e=20
information), so this is the proper originator to choose for bonding/altern=
ation.
This is merely a implementation issue, and does not change the routing
decision.

Thanks again for your comments - I'll notify you when we have updated=20
the protocol documentation for your review, if thats okay?

Cheers,
	Simon

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk9ZxcQACgkQrzg/fFk7axYeBwCgjccDS93w80+3Tiqi5/yha2KD
2qsAnj7kM8dovkbIBFRb4g2gQcUljhHE
=PCSj
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
