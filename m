Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 14 Feb 2011 23:44:41 +0100
References: <alpine.LNX.2.00.1102142335331.4530@swampdragon.chaosbits.net>
In-Reply-To: <alpine.LNX.2.00.1102142335331.4530@swampdragon.chaosbits.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5347088.GlsFtsWs27";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201102142344.44819.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH][trivial] Batman: Remove two duplicate
	includes.
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
To: Jesper Juhl <jj@chaosbits.net>
Cc: trivial@kernel.org, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>, Marek Lindner <lindner_marek@yahoo.de>, "David S. Miller" <davem@davemloft.net>

--nextPart5347088.GlsFtsWs27
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Monday 14 February 2011 23:38:18 Jesper Juhl wrote:
> Remove duplicate inclusion of "send.h" and "routing.h" from
> net/batman-adv/soft-interface.c

Applied, thanks

Best regards,
	Sven

--nextPart5347088.GlsFtsWs27
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJNWbBaAAoJEF2HCgfBJntGX6UP/0823WP6xtS7XXMxLyPfR595
eRicoE7cqzjRFLvsA8kEjHM3iepdCL7ZQzPqM+t1wnQP/VjYbJn5iGnxh4aMf2N/
2R9KI/NknJJ9akwsYyPngHzGHPN3kPD2adEsBAMwoedrnUWQdi24RcIgRi8QhWpa
kpWBwPywOdPs5XQjnL3nLiHoaxudgRj9wlUJVQcPEoggj9f1t5JEeR5uELZqnehz
SYccN4ZsT762kqvuT0mwtzjeTvAfXcJvU3512T1s4JhDcG+AcwzFBh3O6qLULFoo
C5TEZyJzKcrYP0itLe05SGefKStyzwAy1GwcWUh0hydD8rRjF9jdZ9MeQb/fiZi8
c8vtU2sIJDcAyhRhx9mysXqeRWbiDjjxVwOECdXhWxjqxIhGTU7sId8wlqqX+JHr
Hbyz3K53DeZBtavEj7gGpmbOag1/3AcRTNY58lb0rj/pxNqBbIcFS40Ii9vmi0dD
oCvCQrCjfSsCaf1TC9uhoL6bebyKYV1lpNVcOBSxJmgp60kIBdVx/Z4mKM8qW8ie
Y+sSG8o3bkohmRRTadcv73VMRt0xrWoaweJkJB+n5KF7IkYSLhWRsc7DABo0Uwkf
McsS3hkABIISusiZNPX90wAJdRe/Gg+UZ5Im8clm/IPKDFddrSYl8aUaOqYBVSrU
ck84ROYp0ThzfQyxQtNn
=cPbo
-----END PGP SIGNATURE-----

--nextPart5347088.GlsFtsWs27--
