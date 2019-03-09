Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 09 Mar 2019 14:35:51 +0100
Message-ID: <10494594.TRTkPdsu0N@sven-edge>
In-Reply-To: <FE867393-B71B-4CEB-8C98-93E0991A6BA4@blupoint.org>
References: <FE867393-B71B-4CEB-8C98-93E0991A6BA4@blupoint.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1722242.uhP6YXQY7f";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Issues with mesh routing
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
Cc: Phill Raynsford <phill@blupoint.org>

--nextPart1722242.uhP6YXQY7f
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, 5 March 2019 11:03:31 CET Phill Raynsford wrote:
[...]
> Has anyone ever seen this kind of thing occur before, and perhaps to fix it? I haven't seen any suspicious messages in any of the system logs, and other batctl diagnostic outputs seem OK.

Seen this with broken or misconfigured wifi drivers. For example drivers which 
were changing broadcast frames to unicast frames (which breaks OGMs because 
they must be broadcasts) or some of them were changing the source address of 
broadcast frames (which is also not acceptable).

Kind regards,
	Sven
--nextPart1722242.uhP6YXQY7f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlyDwTcACgkQXYcKB8Em
e0Y/uQ//XKQw0CxiMK4UDJJ6vGdzKq+1pNRjGIo73lf8hlO4NyARJV4nYtkCv8Bk
Ooy9/9e7710OEyN7HiEG1/+R8cVjWuIqVUpkiJWftBjzWj8duvnUgx7tbtIPkGas
Zao/vogUZ6JjkRqo767ErWmMeye9VaaI2FbQWUgSU4ak+Wcf9oQ1B5Nx1c0BMhE5
Nafq3yZ+OFCF+mDAS1Ae8D209Qcnk6LaWXmiagkpsnP7BswC5o88C+ckWk+7+5RG
dJIVGL7mg2YaWpre0D7Ff38Qq0jvEk/hxzmJSbJtzWadTwA/kmZp6eD1fWCTGm3I
C/VdJ3TnLh3TIrfuuza7YM683ztQz40DdCn+rqnn+T2/c2eSXoaEUjdPYiwqXtxM
4X7YuX40CGjq3hrHyz15mSQo9Tsolci+QG27f8w4zjwtU8spj2kvnPYNRfbFTHE8
U74ei7UIWusJRHmP0llJxSJmYXiBzVTe+Qyps2k6NUArNgBRm475B60xvamQ8Yty
dygsfo3Vd8nKPTl1GDPKO2qKaZ75SM2yteaT1bECiT92DEC185ktpLV1G2N6NSeO
r/t76VoexWBpHewDsG2/ldA0RRnCUooWzCfXFeoI5P4DaFSL9c/CSYFr8uDAKQb9
LpOJbbG24hzGLBQjo3lLkz8MdK34wl/bicsoVtVrKrP+4PrU4HA=
=lNJ+
-----END PGP SIGNATURE-----

--nextPart1722242.uhP6YXQY7f--



