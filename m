Return-Path: <ordex@autistici.org>
Date: Tue, 14 Feb 2012 08:47:08 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120214074708.GA6104@ritirata.org>
References: <1328830902-11574-1-git-send-email-ordex@autistici.org>
	<201202112159.58282.lindner_marek@yahoo.de>
	<20120213203343.GA19783@ritirata.org>
	<201202141407.57905.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <201202141407.57905.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv5 3/9] batman-adv: Distributed ARP Table
 - create DHT helper functions
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 14, 2012 at 02:07:57PM +0800, Marek Lindner wrote:
> On Tuesday, February 14, 2012 04:33:52 Antonio Quartulli wrote:
> > > Moreover, the name dht_hash is a bit confusing. At first I thought it=
 is
> > > a pointer to a hash (read: orig_hash/tt_local_hash/tt_global_hash/etc=
).
> >=20
> > ok, I'll rename it to dht_id (or dht_addr ?)
>=20
> It is difficult for me to suggest a better name because I don't understan=
d=20
> what this variable is used for.=20

Ops sorry! Actually this variable represent the address of the node (me or =
the
others, depending on the struct it belongs to - bat_priv or orig_node) in t=
he
dht space. In the dht space every object has an id, either mesh_node and st=
ored
keys.

I'd say that dht_addr better represent this concept.

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJPOhF8AAoJEFMQTLzJFOZFT8AH/3uscDmIUyQXnx2mip2O5GPk
zHufUpb/OvBMIOOhMggWY+gOcJwEcrurXv8UedYci/sxhF05gaRnI4k2vm97rwa3
rDXZdZAHPKPyGxCd+Byd2hRnIPlQR0tIrjrTsiFrPMYR0RvPLJ+H0FD9l0+WLWbn
tbstgTxUDI7vwCXUOrTzz8u1FgeirNMeH0CrFqdEjZckvOSg4h6rl54GJ5UmZH+y
67b2Kckl50Imw+OjoTADY14BA/YHPsa4t3bsD774mPh+Ju1Hfuz32Db4NQjethmn
36XNo+ZCO4tujPO9v6HZ5j5x9ELRvT8G9c0NzRiAd00Du0oN9ActVr5r4qzYXrg=
=0ZoP
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
