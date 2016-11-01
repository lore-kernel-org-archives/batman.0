Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 01 Nov 2016 16:00:28 +0100
Message-ID: <1694277.7a7ditMbRV@prime>
In-Reply-To: <20161101121937.31890-1-sven@narfation.org>
References: <20161101121937.31890-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5797378.d4TvB7iLTC";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2] alfred: vis: Don't fail when debugfs
	cannot be mounted
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

--nextPart5797378.d4TvB7iLTC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, November 1, 2016 1:19:37 PM CET Sven Eckelmann wrote:
> The vis server is supposed to use netlink when available. This allows to
> work on systems without debugfs and under network namespaces. Thus it is
> now not strictly required anymore to have debugfs available.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Applied in a580287.

Thanks,
     Simon
--nextPart5797378.d4TvB7iLTC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYGK4MAAoJEKEr45hCkp6hxAYP/1QjTnlrX864IpzABblK6bvE
UsGKo4zay7r7Ed8EH6SMiKAoYD1DtfFTG0atnvQdrbJ/CeI1boRvaVWignBY7+cN
iHLQDg5jgHxnJkZGrIMlsOv7PXuaXInOOa5ig6/g3VSxjorM6l3lxzJIK8h9VKRY
nNlvWuEAFYReohvIKWrxAVSxiQQ9KylbXSmdjha/GySxnuHadBGKuZPfRSFwTSY3
wV3feYBp3+Da3WrUbQR+rtzHoQ2TZbA2EY8pGoI3/AGH0sJvmYKeRzjfvdZTdgTB
CZTByQR6IutFjf+RMwXWDslnczHvUJUAyfsF1XprcQ6nJoM0f+FzEQgQmjtpTjIJ
omLIyZpxHGRQ79c55IQdamRBMQfULm2lpLiH1HHNb0owjxt2aGj4g1PxOU7cArbU
XKWsxoceSnE57DN2DpSdmTUptdCqg946/015ZcOOPQbCPyn6N9pm/ansZmjmnaQe
tGuVKDGxJBkDbInsapycL6syVy6Slnt03a/g9y7mCtQUMUOQzwLwyBHkkRt+Iu1y
FdF2r+fLnEv5aepdvEmIDvMDEXbmhI51s6+fIgYPg8UGGBXTNt0zIS9GGxNHK+Nx
OfKrCzpI8OKR8Kel5694/bJcx+3Zr2KT/tinNCxRnuWauSdV6mrheDEuSwamUxNm
6N+nvjbsIRhQtw2/K5Xa
=VN8s
-----END PGP SIGNATURE-----

--nextPart5797378.d4TvB7iLTC--

