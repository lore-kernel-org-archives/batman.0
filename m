Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 26 Jan 2017 09:12:35 +0100
Message-ID: <1666444.c3KG0nh7Qr@prime>
In-Reply-To: <1485395221-3515-1-git-send-email-jhaws@sdl.usu.edu>
References: <1485395221-3515-1-git-send-email-jhaws@sdl.usu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart13628868.yhdg8Tup4j";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v5] alfred: IPv4 multicast distribution
	support.
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
Cc: Jonathan Haws <jhaws@sdl.usu.edu>

--nextPart13628868.yhdg8Tup4j
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, January 25, 2017 6:47:01 PM CET Jonathan Haws wrote:
> Enabled via -4 expert option where multicast group address is specified.
> This option will disable IPv6 communication and is intended for use in
> networks which do not support IPv6 addressing.
> 
> When this option is enabled, all IPv6 communication is disabled. Combining
> IPv4 and IPv6 alfred nodes is unsupported.
> 
> Hardware address handling done by submitting queries to the local ARP
> cache rather than forcing an ARP request.
> 
> Signed-off-by: Jonathan Haws <jhaws@sdl.usu.edu>

Committed in revision c7da798.

Thank you!
     Simon
--nextPart13628868.yhdg8Tup4j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAliJr3MACgkQoSvjmEKS
nqHqexAAolzTTGhKmVTX6TRta5ETk7/Nf2ygxYkjP3lf8l9HyYevhC6LMHqOkvd8
PwVdoBAltXAzjQDg3adx1UzY8NneehMIACASi78fQy9qer1H/D4KeJQkERBGIW2W
yv9Pxk//LFCnLdmZLn1FhIJZQXE0izpwQr49IEjJF/M4/YF9iMftWOn7jh80kEcu
g5BFrb1yoQE0CnMI2Px4i+MtKjayl4KnLCJ0i22vY8pE0wFXNYBx6+1vn5X+qz+q
S2XJ1k+SRdbF9vZXKhPPzIIjfovwUbtvhuZ/WqT4KfBU4J3+AuUyRn7w8VVNqjwd
aP/ksnkkDTKdThSTMmgjmGOeUUrgAMT9lJ1BbB7i/eZKcBI5FQ/cEDezharSFm4v
l2UAB+QRDaeldlGXMWT3K+ODb0iZZt0zrnwdlwgGf2jpQ1BIB2WABwFDIOFjEFmC
Exfh9DROFjafmiDCUiIY+81by/4V9v+gC9GIAY7LQQbmT6WIbNmN8vvsHC+KLLIz
GP6/ZkV7mHCDovUPCl3wJj3Eu7sn5fBWxpAhOAwVnAFDEMzQZs+cZT2BlTWiSvDu
k+uQEuFtlRTbeEsE50iGb0sZVG+4LU7mIsU85SuqZ5vaXM0lx7u2fZ5ngRv/0GxQ
6vNYR4zJhNR9kJ3fjj3od3Hmpuz2X5EOVkYWiKSeoicA+tTgZaE=
=sUah
-----END PGP SIGNATURE-----

--nextPart13628868.yhdg8Tup4j--

