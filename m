Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 3 Nov 2010 11:56:19 +0100
References: <1288778342-10056-1-git-send-email-tklauser@distanz.ch>
	<201011031112.20044.sven.eckelmann@gmx.de>
	<20101103102512.GD10579@distanz.ch>
In-Reply-To: <20101103102512.GD10579@distanz.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4312809.Paija6xqQI";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201011031156.28683.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] staging: batman-adv: Use
	linux/etherdevice.h address helper functions
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
To: Tobias Klauser <tklauser@distanz.ch>
Cc: devel@driverdev.osuosl.org, b.a.t.m.a.n@lists.open-mesh.org, Greg Kroah-Hartman <gregkh@suse.de>, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>, Marek Lindner <lindner_marek@yahoo.de>

--nextPart4312809.Paija6xqQI
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Wednesday 03 November 2010 11:25:12 Tobias Klauser wrote:
> On 2010-11-03 at 11:12:12 +0100, Sven Eckelmann <sven.eckelmann@gmx.de>=20
wrote:
> > On Wednesday 03 November 2010 10:59:02 you wrote:
> > > Replace custom ethernet address check functions by calls to the helpe=
rs
> > > in linux/etherdevice.h
> >=20
> > Have you proven that the addresses are always two bytes aligned in
> > memory? Afaik this function needs it.
>=20
> I don't think they need to be two bytes aligned, but I might be wrong.

compare_ether_addr uses a two byte pointer to access 3x two bytes. This mak=
es=20
it necessary to have all those 3 bytes aligned to 2 byte boundaries. Otherw=
ise=20
the compiler has to generate special instructions on architectures which do=
n't=20
support loads on non-aligned addresses. Usually he doesn't do it unless he =
has=20
some indications that it is necessary (__attribute__ ((packed)) for example=
).

There is also documentation available on that topic in=20
Documentation/unaligned-memory-access.txt

And maybe it is good to use is_broadcast_ether_addr, but leave=20
compare_ether_addr part open (or prove that we always have those two operan=
ds=20
correctly aligned).

> > > In one case where the address was tested for broadcast and multicast
> > > address, the broadcast address check can be omitted as broadcast is
> > > also a multicast address.
> >=20
> > We need to distinguish between these two types for different
> > optimizations (research is currently done for multicast over mesh - but
> > currently not part of batman-adv).
>=20
> I was refering to the following part of the patch:
>=20
> -       if (is_bcast(ethhdr->h_dest) || is_mcast(ethhdr->h_dest)) {
> +       if (is_multicast_ether_addr(ethhdr->h_dest)) {
>=20
> I think this change should be legitimate as the same branch is done for
> multicast and broadcast addresses.

Yes, in that situation it is correct. I was talking more about the complete=
=20
bcast vs. multicast in batman-adv and didn't look at your patch.

Best regards,
	Sven

--nextPart4312809.Paija6xqQI
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJM0T/TAAoJEF2HCgfBJntGLSQP/i3fBsFK8tbgVGgJKQX7seuO
F0SWYM4V1LIEOHFyP5UbALYdiRTVWoPxmUdCKxeuvS2YSlWXd8q7zZsuvsAAuzlV
b1S1u3dSZs5BGR17nYmrNy1FYvhnJC1ptnzJczD4YJBupRSehdGmalgQh9pRqBBp
IoC9MibYNp6HUAJ3O0telkNAk1D2UfNDNfBHInHPteVfGB+x5BSRX1UQE9OjfOTc
rNrL58NvBMnQocvLifAJsr/rOtrgrcRN03rHco6Lt9Jl4ExnsfXo+Ch8WE9pN+ky
Rcqsmah6mmMQtwBismvJsWjHqNVM15FpP5eyRvrrOSy5344xsimjjUuBl+8ARWBR
Jowm5w8vAXZGcPLylAzOvxpfqCQND+wy6zTUkdJWP2pPLkrCAOFlwqIXSSB9xNVD
A0uI70FiRi3OTAkFwenGmd+KwZVOPAfYEwQpxT9BvfJrHZ8LJeEr6jnTb6p82xvE
1w4xYdFL+hwOOKqYInPvn77zmdA1KNM8pIQOZElVN5CcUMm7EwpJ9gox3bUTTAFX
k0Szia3lz0FfzN7bfhitjZAcnpXvTt2YCGH7N5haB1QsBAyUPmZZWz1ImOa0lj+n
U76EcneTnmYn28CcFjNmWu2GsIDm2dZDR/Jy1Z9o7F21SObghBpNvLb9gEhMrXHR
JfcgLOfPl2uxh6hdTR+m
=UZiw
-----END PGP SIGNATURE-----

--nextPart4312809.Paija6xqQI--
