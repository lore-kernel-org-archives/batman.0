Return-Path: <ordex@autistici.org>
Date: Tue, 24 Jul 2012 09:06:03 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120724070603.GI3610@ritirata.org>
References: <CAHD-aqLxF0HHXbW0YtZa700qbUytyv3Gd40FC6E7nRWLMD-=Ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="tSiBuZsJmMXpnp7T"
Content-Disposition: inline
In-Reply-To: <CAHD-aqLxF0HHXbW0YtZa700qbUytyv3Gd40FC6E7nRWLMD-=Ew@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] avahi broadcasts over two-radio batman.. dropped?
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--tSiBuZsJmMXpnp7T
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Guido,

On Thu, Jul 19, 2012 at 01:20:15AM -0300, Guido Iribarren wrote:
> Hello again,
> can't determine exactly since when, but avahi is acting funny in
> QuintanaLibre :(
>=20
> two computers (pbx and veci) connected to different nodes in the mesh
> can't always resolve hostnames through avahi
>=20
> pbx ]=3Deth=3D=3D[ nicoyjesi --> .. --> .. --> wlan1(czuk)wlan0 <-->
> natychucho ]=3D=3Deth=3D[ veci
> (cf. attached dotgraph)
>=20
> question from pbx is broadcasted perfectly and reaches veci,
> veci replies, natychucho broadcasts the replly through wifi , gets to
> czuk wlan0, but czuk doesn't re-broadcast it , silently dropping the
> packet.
>=20
> relevant tcpdump
> http://pastebin.com/6xLmDqe5
> you can see question coming in through czuk(wlan1), rebroadcasted
> through czuk(wlan0), reach veci, veci reply, czuk(wlan0) gets reply,
> but doesn't retransmit it through czuk(wlan1) :(
>=20

I see..

> iptables @ czuk looks sane
> http://pastebin.com/mFUFuNdC
>=20

I trust you on this because there are too many rules :) (have you tried a
'iptables -F' just in case?)

> ## czuk has two wifi interfaces, both in ap mode, managed by batman
> ## natychucho is connected to wlan0 in client mode,
> ## and cisterna is client to wlan1. no WDS whatsoever.
> root@czuk:~# batctl if
> wlan0: active
> wlan1: active
> root@czuk:~# brctl show
> bridge name	bridge id		STP enabled	interfaces
> br-lan		8000.54e6fcb98e2b	no		eth0
> 							bat0
>=20
> complete live config can be lurked in
> https://bitbucket.org/nicoechaniz/quintanalibre-configs/src/d9bd3603824d/=
czuk/overlay
>=20
> I don't find any reason batman would be involved in this, but iptables
> is discarded as a suspect, and AFAICS there are no other factors
> messing with the packets (maybe it's a bit late night :) ). No bridges
> whatsoever.
> In fact, packet is catched by batctl td coming in at wlan0.
>
> Any hints or experiences will be greatly appreciated as always!
>

is BLA2 enabled on czuk?

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--tSiBuZsJmMXpnp7T
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlAOSVsACgkQpGgxIkP9cwfpCQCeOQGl8iXM1DLRN/Iy4DuQ+tRg
8kgAniIE9oFBP/SaBWLRjer9e9p7+viC
=bflJ
-----END PGP SIGNATURE-----

--tSiBuZsJmMXpnp7T--
