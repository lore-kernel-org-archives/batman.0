Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 31 Jul 2017 10:57:45 +0200
Message-ID: <1660699.GPcEM8SUVU@prime>
In-Reply-To: <13899415.9hl4lahuAs@sven-edge>
References: <13899415.9hl4lahuAs@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart250250170.T7Mheq66YX";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 0/2] alfred: Use bitmap to store dataset
 change events
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

--nextPart250250170.T7Mheq66YX
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, July 24, 2017 11:18:09 PM CEST Sven Eckelmann wrote:
> Hi,
> 
> the --update-command implementation looked quite memory inefficient to me
> and I have therefore replaced it using a simple bit map which stores in
> BIT(i)
> when datatype I was modified. Here from the second patch:
> > The implementation for --update-command uses a double linked list to store
> > the detected modifications of datasets. This implementation requires 24
> > bytes (1 byte data type, 7 bytes padding, 16 bytes linked list pointers)
> > on
> > amd64 for each element of the list. Each modified dataset type requires an
> > own list item. Each list item is allocated using malloc and therefore
> > additional overhead for the libc allocator information has also to be
> > stored next to it. The list head uses a similar amount of memory (16 byte
> > list pointers, 2 byte counter, 6 byte padding) but doesn't require
> > additional allocations.
> > 
> > The list based implementation provides information about modified dataset
> > type and the order in which these modifications were detected. But the
> > latter is not actually required fr --update-command and can therefore be
> > omitted.
> > 
> > A simple 256 bit wide storage element (32 bytes) is enough to keep the
> > required information when only the detected modified data types have to be
> > registered. BIT(i) is either 1 when dataset type i was modified or 0 when
> > no modification was detected. This removes the (de)allocation CPU + memory
> > overhead and avoids list searches when adding newly detected
> > modifications.
> 
> The bitops.h file is used to implement the bit operations and keep the
> details away from the server code. I've reduced the size of the header file
> a little bit because most of it was not used by alfred.

Thanks, applied this series

Cheers,
    Simon
--nextPart250250170.T7Mheq66YX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAll+8QkACgkQoSvjmEKS
nqGoTRAAnAE36NLyA5c9BnJgHN7qrGrjgEWamKcTdKUmQBm01xvt+yRqpOTs5Pmn
6RLLMTgL6aTrdUhGsao3fSEAk+4KPrTzD2/FAD12HDUGNrR3ZjIpN5EqaDRJ1dak
zC7uQaPpL84OHnd7U0cjckx9eCioX4YSVMv6DqCv/mHewFGF234Sif8TROtpU5Qu
7jaQj66+Oz60WMKMILBzBJUPP3UmjaLRSGMK0ZsxfDaXehOSBVp97tzSywoAjamB
MxTb+fSuen+igWK0PGtmEjzla21maeaCtI1B3Q5eqXmT97qwOdjmw9Sl52UVrCqw
XsfZAv7I5+kNj74yjTsssWiCxaStI5+IlYa3Xy44EXPYJaWMYDVRW/Oa3AVWvwHk
f26TWI7rLETWojBRLeeIMRU3WTXs0ULyr/myAmCpr6qBFwMLzEYKvXr6OxBtoTi9
BYwMlmxfEjngNr1WV6BasTz8mgbJohSpfzA1FGlVfoe8/HIN/JTGj0zCdZ2xhKLd
pAXfYu++XvdEq2XZno67n4R8eZyf5TkBRFFpicXn2MyZRpDGjpZlVfwWN73uEfpW
kOvS7ZDXAzHtT5XwZui43LJ8QG1izX+U61j21OaGZ0vlDZQrSHJvFyfmpQvoZQ7T
iTFvdgP1U9ST0el9MBWGddQAhfSoimteuV1blziC/9VTpNQQ+W0=
=FE3H
-----END PGP SIGNATURE-----

--nextPart250250170.T7Mheq66YX--

