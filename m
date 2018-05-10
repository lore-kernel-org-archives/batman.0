Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 10 May 2018 09:13:46 +0200
Message-ID: <3042023.D3qD38dNFT@sven-edge>
In-Reply-To: <eba673b5-8caa-11ad-3317-19186263e17a@irrelefant.net>
References: <eba673b5-8caa-11ad-3317-19186263e17a@irrelefant.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart95373336.EsWu4fPQZH";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] batman-adv: Bug: Missing TT entry leads to
 inconsistent but stable TT state
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
Cc: me <me@irrelefant.net>

--nextPart95373336.EsWu4fPQZH
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Donnerstag, 10. Mai 2018 03:20:42 CEST me wrote:
> We have three nodes, which have the following topology:
> 
> NDS-Agenda21Haus70 <-> sn04 <-> sn03
> 
> Something happened, so they came into a stable (for hours) but inconsistent
> state of their translation tables:
> 
> - sn03 has 11 entries in its translocal table and crc = 0x2b6d458c
> - sn04 has only 10 entries in the table for sn03 but still crc = 0x2b6d458c
> - NDS-Agenda21Haus70 has also 10 entries in the table for sn03 but crc = 0x74fb4f96
> 
> It seems as like something (erroneously) removed the entry 33:33:00:00:00:01
> from table on node sn04 without recalculating the crc sum.

I have copied the bug report to https://www.open-mesh.org/issues/355

Kind regards,
	Sven
--nextPart95373336.EsWu4fPQZH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlrz8SoACgkQXYcKB8Em
e0brTw/+KmX8QQcoNCELk5B2969dihMPXaC9gNR0ILdqi6r2Gnk7Nb10ljdFtOig
jLZ5QwgVzxQMKDRiMxV2tXx8y5XRsJY2Zjmq55NheZ8wvB50aEvVeZ3dkFoFxX73
IyzYPv+/JYixUJsZxz/a/QOrn63HsOTI7xCY71F/yLTUPnyC0LDQxhDfawceW0PR
yHiyYu+muZYflQNZeC01lerJTsV0CmtR589ZkXK1C2x3AeMeBJKWyuIcvhhIyHXN
QrrkyCPQw8aJR2JG9z8eQ2XUbaHpcp5XypFnZ6Itu++fWyb+qamJXXejQ9K5h8GJ
5Qhnw8C9Zt2OJl5Ik1VmcSeCguKxJblUieIKTG1A8Wz0Sas6Y3KQ510yddZ3X64g
f672VWv2jVGHT2i+g6IvX9BcGm2fm93bB4U/0TVQkhbRJ52Ds+UUu4IzSPlO42XC
fskvnhQFwLPOAA1uwxN64PSFA9oO5g8wJH5VIX+Mn2Ak3KEeDmoo6N6Y3yIU9Qxp
GPq4MvrhCgYnSGu2VRVk/iUUQJ19MHa65C9oPXm7+0S2R4t1U+z4TFVAh8oMz1rV
0MIX6g4wX/qSL03KtRrintc62dPbBaGhBNKT5m9YQZeu1OvYMSGF5I057NwFx1w/
gJM50tPnYfIm/7SBn95p9eoPswysBIT4M8MUvawgofb4k5XkJ5Y=
=yfrN
-----END PGP SIGNATURE-----

--nextPart95373336.EsWu4fPQZH--



