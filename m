Return-Path: <ordex@autistici.org>
Date: Fri, 6 Apr 2012 12:13:36 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120406101335.GB10310@ritirata.org>
References: <1333543332-26942-1-git-send-email-ordex@autistici.org>
	<1333543332-26942-5-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DKU6Jbt7q3WqK7+M"
Content-Disposition: inline
In-Reply-To: <1333543332-26942-5-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 4/4] batman-adv: enable nodes to detect
 not yet announced clients
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
To: b.a.t.m.a.n@lists.open-mesh.org


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 04, 2012 at 02:42:12PM +0200, Antonio Quartulli wrote:
> A client that connects to the mesh network is not visible to any node unt=
il it
> has been announced by its serving node in the next TT diff sent out by me=
ans of
> the next OGM.
>=20
> During this period the client is not able to communicate to anyone becaus=
e no
> node has a route towards it yet. This is usually acceptable in networks w=
ith
> short OGM interval (=3Dthe maximum waiting time before the next announcem=
ent), but
> it is definitely problematic in networks where the OGM interval has been =
set to
> an higher value (e.g. 5 seconds). The client, that probably issued an ARP=
 or
> DHCP request upon connection will suffer from several timeouts before bei=
ng able
> to communicate with the rest of the network.
>=20
> This patch enable nodes to detect such "new born" clients and to add a te=
mporary
> route towards them in order to be able to communicate. If the client is n=
ot
> claimed by any node within a certain amount of time, it will then be dele=
ted.
>=20
> Roaming operations have been adapted accordingly in order to be let clien=
ts
> switch serving node even during the first OGM interval (when they have no=
t been
> announced yet)
>=20
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  main.h              |    2 +
>  packet.h            |   15 +++----
>  routing.c           |   26 +++++++++---
>  soft-interface.c    |    6 ++-
>  soft-interface.h    |    2 +-
>  translation-table.c |  111 +++++++++++++++++++++++++++++++++++++++++----=
------
>  translation-table.h |    4 +-
>  types.h             |    1 +
>  8 files changed, 130 insertions(+), 37 deletions(-)


We definitely need to keep TEMP entries away from global CRC computation an=
d full
table response! So please, drop this patchset. I'll send a new one later.

Cheers,

/me acting as schizophrenic


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--DKU6Jbt7q3WqK7+M
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJPfsHPAAoJEFMQTLzJFOZFr4sH/3anj1RiWPoI91udOGxF/Jpz
iIFozxNgZVcesYv7GvVLtu6OLFYasOjuDI0FFTlMO9/boke1l5ElPZm+EB5LPrQv
4GAUu08HGFVmCgf+bNPhemSzh01NDKEPiwR1oUyia+EZ0cdWht57GursiaHU6Mo0
ibFVuFb/VmjpdVkS3gILuqV76fQrkm59oL5CKOYRWwxDZE1O6U9p0I/m46GFJQgN
if9XcwO5tDEH/40Zqg+kAmq4uBpFptPlUWwzDsXKcbJwl0XE+negnoXmdlbRNv7C
j9OdoaSJpbVSYldwXNll9mTq0EkRAjLD8rSLxWOSNUCgoAwg4nCqmF4QYw3ysd8=
=h3Ns
-----END PGP SIGNATURE-----

--DKU6Jbt7q3WqK7+M--
