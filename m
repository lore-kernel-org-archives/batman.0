Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 02 Apr 2013 11:10:37 +0200
Message-ID: <6694164.toG189sgU4@bentobox>
In-Reply-To: <20130329114816.GR798@l04.local>
References: <20130320175154.GT41481@l04.local>
 <3212285.GF4Btbehao@sven-desktop> <20130329114816.GR798@l04.local>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1886120.pe8fKaU1Wd";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] Bug#703540: Inconsistent use of _GNU_SOURCE
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
To: Michael Tautschnig <mt@debian.org>
Cc: 703540@bugs.debian.org, b.a.t.m.a.n@lists.open-mesh.org


--nextPart1886120.pe8fKaU1Wd
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 29 March 2013 11:48:16 Michael Tautschnig wrote:
> Hi Sven, hi all,
> 
> [...]
> 
> > > Either all or no file should #define _GNU_SOURCE.
> > 
> > Please add information how to reproduce this the next time you are adding
> > such such a bug. Now I can just assume what you are writing is true (even
> > when the man page about sendto says otherwise).
[...]
> Just one question before I elaborate a bit: what information in the man page
> are you referring to? I can't quite seem to see anything mentioning
> _GNU_SOURCE?

Yes, this was exactly the thing I was pointing out:

> > > (This was at least noticed for the sendto function, but may extend to
> > > others.)

Kind regards,
	Sven
--nextPart1886120.pe8fKaU1Wd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJRWqCNAAoJEF2HCgfBJntG4/AQALRfmOncjSWAo2zOnh1CN3Gr
qlty6ioU8g2H/vn+oREcTZXYSi6KwNiZyi5Pniec7oVu6Xi5jq/HMK5S0sBbeEHO
YBh78y/7mYbzjDjeFDq/qpGnqg/leFVxKOFvF/kmmxz0d2IACL/eWpWpttxIXhNk
CFdnGZwMsSOCwCUr5YYhAYGGmXkN7Yca16ZMhy0NkXLgoMy7sbKewGG2lD5JpGkS
yTgupfWCKjnG4IpPIlx8i7Xc/6Et22CspYbveMZjSde0u7XfaA5B95UegzulYH5R
wIYTNpR/I8pvq2DZ73KV47Qlv99OEDruUUrnqYNwz+WOINPH8iIKRuk8LglWpH+o
C5yn3ZhXERA+6kC9PFUiEwS7kwykAQBSnAAyiVi/jr1az5n/laKPAitQl2dsnSYN
SAvFv5pFuNK+5Jw4mlZtJanJ/hnlCKhHYLtiYk68YRH8B+7JREwto3ypAEWzz3fO
6uPxtYOvANNvLu3jOh7RMafiMPznWk5TBERS/tg0+gIGyGz0DL73gpvMuLH2eAnL
Ikv4aHZ+ZMWuJG1mcW5HYb0icypjiCSbFD5shUpDYkpbm2eg1xDs2PtuU5C+C76D
RC0FolqEPbYmiOp60TcDEsLh02ygZDVEdCMJmzn97iN4g0Pfe/FKnMty2of9ftQk
mM0iLw99oMsh2wjTjkm8
=161E
-----END PGP SIGNATURE-----

--nextPart1886120.pe8fKaU1Wd--

