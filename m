Return-Path: <ordex@autistici.org>
Date: Thu, 24 Jan 2013 05:53:52 +0800
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130123215352.GD10344@ritirata.org>
References: <c15e0026ed81d2da11ee59ab7bfcb3a6271cd10b.1358961079.git.mschiffer@universe-factory.net>
 <4b41fb1f387acd24ecab6e4e47b2126b6dbddb5a.1358961079.git.mschiffer@universe-factory.net>
 <20130123210730.GA10344@ritirata.org>
 <51005884.7090106@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="2Z2K0IlrPCVsbNpk"
Content-Disposition: inline
In-Reply-To: <51005884.7090106@universe-factory.net>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: filter out invalid DAT
 entries
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
To: Matthias Schiffer <mschiffer@universe-factory.net>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--2Z2K0IlrPCVsbNpk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 23, 2013 at 10:39:16PM +0100, Matthias Schiffer wrote:
> ipv4_is_zeronet() checks if the first byte of the address is zero, to my
> knowledge there is no special funtion for checking for the unspecified
> address, as the case is trivial and independent of byte ordering.
>=20

correct. Then the change you proposed is fine with me.

> It might make sense though to check for different types of addresses
> that are invalid for ARP (zeronet, loopback, multicast, etc.), but I
> wanted to keep the patch as simple as possible. If you think these
> should be filtered as well, I'll prepare a v2.

in distributed-arp-table.c:784 you can already find these checks ;)

I think at this point the patch is ok. Thanks a lot!

Acked-by: Antonio Quartulli <ordex@autistici.org>


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--2Z2K0IlrPCVsbNpk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRAFvwAAoJEADl0hg6qKeOF6QP/i+YPy/im8XW39WNHhGgUwkn
bwS10ZCWIdrwlkv6RopEVeuuulxyIwPDhVkaZBT7tZI0a1Zm2F7CCXLHBPotg8eF
sguKqX/B6b/Os0chbfeEZPQSG03XoVz5A82gFAloY6nJv/v0uxNTdnasEQiA6OPw
XHJWOSaB4SOOrk4GFZamoMNT5cKjrgIgYPJ5Q5xG4sRoZ7LEmVMgQXYI3viJzGvQ
Wf0YoSH6PIOIToDIQ/O5DidbALW4XWfz64CwDYl7J2tTZr/+u4KxfcOtv/hGZiHZ
0e6bagQ53IDhU8Llx2J4qA17hCF+OQGDu8f+wjGOLMopwqtj5b3K2CkuvHsR0ZC0
jXvDx/rM7JeDbGH2ME6OZ4fPWkKnNPvw2JzxSP4pZ/fMxiF/vqUenNyxRdv6zbLv
vlB99uiM6n1BRly8dn3WVzQ7QCAMmLJ+vHLJXZ87NHcArMzJI9s1ZZhlALxHsOv1
0xOPPgj36DIr+pD1pu5pJdUuZulwyekPMlSC/mM14DvhFPax04qRbAcgRd6X9V11
prcmUa0pieO1r/z6dMEPjLwpfR5KXgYaxhr1iGc+6N7VHiw67HOczfzPvbdFjYSA
BDGl+1mIOsABDyPwcR1oqO9gQyAY/k1oXgiZY4HDI6dCdJsx2G187KithyvngL9O
Jmlr0n+4NN7wBPX30BEO
=mNRC
-----END PGP SIGNATURE-----

--2Z2K0IlrPCVsbNpk--
