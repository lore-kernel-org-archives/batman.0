Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 13 Mar 2018 09:20:37 +0100
Message-ID: <2162965.7E0QXh8GzM@bentobox>
In-Reply-To: <8d6c7fcc-7681-721b-554d-9110574ed5b6@unstable.cc>
References: <20180310235321.1324-1-linus.luessing@c0d3.blue>
 <2042233.hTAz9L1TrL@sven-edge>
 <8d6c7fcc-7681-721b-554d-9110574ed5b6@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9002136.UbB3neMqGj";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 0/2] batman-adv: netlink support for
 DAT and MCAST
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <a@unstable.cc>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>

--nextPart9002136.UbB3neMqGj
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Dienstag, 13. M=E4rz 2018 16:02:34 CET Antonio Quartulli wrote:
[...]
> Another observation: do these attributes need to be DAT specific? or can
> we just define (or reuse) a generic HWADDRESS attribute that we might
> already be using somewhere else (i.e. for TT)?

I've asked myself the same but we have BLA_- and TT_ADDRESS and these are=20
named in a way which connects them to these specific subsystems. Using one =
of=20
them for DAT seems to be a little bit odd.

Kind regards,
	Sven
--nextPart9002136.UbB3neMqGj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlqnidUACgkQXYcKB8Em
e0YWAhAAtYsQK9CGFm1/ettxT3FJqOb+OpqLrJs9EZ7UYBWFJZ2ZfuPP9L3Ryd/l
VH+BE03wvGV67H7QeUMMX+0tljmfWzy/y6ZjWArzR/X/+ehNaEqEFoH5excquieJ
MOCBiCjEH6EspiAuUuSfBqbPNC74qE0GMhF31Sgf1hx8KDUuc+ob05QTwIIkVUFQ
8WNIQZ5jQZqwx94JA+Qz/2nh1UIV31xCv7+TmvtXYnQrF6L7J+RhDz0oPUP73bqW
PIzx8YJD0rw5xLMvkIg4N1PPeBIQvIQ1MBpeR279aMOguu5PDSgnCJcj9tJkS2/s
a0RMWlKvUFwgDU6cuMxOAqVdH0uof9z5W3PIrkt38rWt+DYLpanfkmcoQ+RD+h0O
Y8tWlm8IeNvERul1Ln3XVC5ic/aUKiF76qN2G55hL6hHwuQbUSUEBSvwam61K8Xy
W2NKYsbWG68jIQ2IV+rfhqAsOnLtRwd0JOyPtWE9AAPhP/CpYiU+S52QwYF9/GLD
xtoEUL6SGItZUm9/VO9wyal9WuplYzc/DcWVNiftoMC9jQCfy40HBi7Jiaqu83nQ
jN/nJv0FB97mY/S+hxSwk/iLsBW5L1p3uxkzYOf+1ldmRtHScF78DABOfVWsD7iu
+fB5eDOoeo/xfMfKuvUqnpI69KXhnO4R13ZiLUOPrYAVF4lHPKg=
=TU+S
-----END PGP SIGNATURE-----

--nextPart9002136.UbB3neMqGj--

