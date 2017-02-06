Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 06 Feb 2017 10:56:25 +0100
Message-ID: <2104576.qJKP21On3P@bentobox>
In-Reply-To: <20160905112029.32533-1-sven@narfation.org>
References: <20160905112029.32533-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2041130.bnv7Vr86ay";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v7 1/5] batman-adv: prevent multiple ARP
	replies sent by gateways if dat enabled
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
Cc: a@unstable.cc

--nextPart2041130.bnv7Vr86ay
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

On Montag, 5. September 2016 13:20:25 CET Sven Eckelmann wrote:
> From: Andreas Pape <APape@phoenixcontact.com>
> 
> If dat is enabled it must be made sure that only the backbone gw which has
> claimed the remote destination for the ARP request answers the ARP request
> directly if the MAC address is known due to the local dat table. This
> prevents multiple ARP replies in a common backbone if more than one
> gateway already knows the remote mac searched for in the ARP request.
[....]

Just in case someone it wondering why this wasn't applied yet. Antonio didn't 
like the patches and thus the patches were assigned to him in Patchwork [1]. 
It is currently unknown what problems he meant, but he created a branch under 
his namespace [2]. This branch only contains a re-factorization of the first 
patch (+ batadv_bla_check_claim/batadv_bla_is_my_claim behavior changes when 
batadv_primary_if_get_selected or batadv_claim_hash_find return NULL). We 
currently don't know whether this all or if he had more problems with these 
patches.

It is therefore currently unknown how to continue from here. Antonio, please 
provide a statement what we should do with the patches.

We don't want to add new patches before the v2017.0 release but maybe this is 
a candidate for v2017.1.

Kind regards,
	Sven

[1] https://patchwork.open-mesh.org/project/b.a.t.m.a.n./list/?delegate=7
[2] https://git.open-mesh.org/batman-adv.git/shortlog/refs/heads/ordex/bla_dat

--nextPart2041130.bnv7Vr86ay
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAliYSEkACgkQXYcKB8Em
e0b7eg/9GnfQn4ioqX3nLBuRsnfDrLLJ8CuB7Wnt1R0QDETIl6WeDk3cmLbgiF5w
yyFqSdwCBA0evwwsmEiiLsuXtVr/n1dNCUnREWDgtEWq6Ml5MnJQXjfdu1CJTzHx
ZQbdZpdzl6RaFvzO3esxplxWWQ1Mz/WLBoNPUMHhB/YSk7JDf1u0sBl2JZW4Y04k
RrH3lU4Qrmh/iK5gr1cVIqksDJt2efFTkTiDOkEEWo5NiIccgWjVzs4St040kHx6
kyi3g0N2ouo2s82h25gK0/MpAlGaE6uCMoZUfMuIAlvbcWzBVjcScqn05gGD3Dby
99XRF3WkIjYeCeVNKU/dxyRbYdSz3UEDr8OWTxKDyHWMTnL+HVfNGMEaHBHKP9sX
c9KF1ujJsugu7L951BwzOtMZ3TTuVdG8xEtfZrFHQjGatTSLy1aQuALj8Eo6YRgC
HKA9O2IsOK8ZJkNzC89ITGOnKtvyKwL5q6OfTV275Fb1ulAVzsjA1z2FqF+rM6rd
vPDcqqq1DD3z0ziunzjGz2a7EXCM+CYLfnXfrcyUYrv5gk2FOnKAaDOso7G7e8aC
g6PfK9xTMqn72Jmf8BIymVjrHBfKEkEMhAVZ5/ssp1FiNxAZUGFnmRzBWAVBOR59
iRUmzx4DXr7S+ORl26ToSKgf5uUsxB8KUvsTI6bEO2iqTt5JmBQ=
=8K1Y
-----END PGP SIGNATURE-----

--nextPart2041130.bnv7Vr86ay--

