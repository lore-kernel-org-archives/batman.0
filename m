Return-Path: <antonio@meshcoding.com>
References: <1440600113-21305-1-git-send-email-sw@simonwunderlich.de>
 <1440600113-21305-3-git-send-email-sw@simonwunderlich.de>
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <55E5692D.8090909@meshcoding.com>
Date: Tue, 1 Sep 2015 11:00:29 +0200
MIME-Version: 1.0
In-Reply-To: <1440600113-21305-3-git-send-email-sw@simonwunderlich.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AeV5K6od5T1ecbwcM7D0wjPTNtVhxLNA7"
Subject: Re: [B.A.T.M.A.N.] [PATCH-maintv2 2/3] batman-adv: avoid keeping
 false temporary entry
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, alessandro@mediaspot.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AeV5K6od5T1ecbwcM7D0wjPTNtVhxLNA7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 26/08/15 16:41, Simon Wunderlich wrote:
> In the case when a temporary entry is added first and a proper tt entry=

> is added after that, the temporary tt entry is kept in the orig list.
> However the temporary flag is removed at this point, and therefore the
> purge function can not find this temporary entry anymore.

When can this really happen? When a temporary client has roamed to a new
originator before it could be claimed by the first one ? Or are there
other cases ? I think it is important to make this clear, because the
original logic was such as the expected behaviour was to receive an ADD
event from the same originator where the temporary client was seen.

Other than this, the patch looks good.



--=20
Antonio Quartulli


--AeV5K6od5T1ecbwcM7D0wjPTNtVhxLNA7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV5WkzAAoJEOb/4TMchkvfYI0P/29yWcmDdOUpKH0k/tZScYhq
Nm+OEYJ/fiRV5Qk2ypeG+PUFX/iR9B9hg8PsBq+b2x2s4vRg9K1oIaw9WkfxZAiy
zQ9EHVSlmg0I2ewnWjfXhiWAsTu2XoMyc58gaYyqxl+OPmchLPkGwB3rge5MrQ05
pU7Tv1jKjenZ7fSEYhSXwkWDUgxI/tuQsQLzQ01w6AjvU0yaG+GNtyyY+EO+ouB6
VIF6I7Tg2h2LqaxJb5YnfS45873SbQdfQtlYY8y2moDsr2wwZLU8p7MO2URNfK3w
O56guHoXN0T9ELJwLO+JosrDkwHG14MBcs/HCeXOWpO85iS8/hgB2tYPxvMLRNeF
0T8R48St+/1zBQXQEeE+CIJ1OhfVusRErhdY83M/OZQ0N5OawdTDwrJu9eAOLZA5
56nb0fon27zl0fTdJVqzLn2iJyxN8BjxpBrdrg75pIK93lmGHI1IgKg4Z6EtvF25
FmbKDnx586C5SC9IpAU3zVxaqaz+Vyfm+mqlNsMRSVnUKYoKVgrElC1ps4073yp3
5n77HMCuA58gAfNAlet1HLMWClCZojEdaKXCBstvDl+1bAexIo650LSk9xm/ZLhJ
wqxTk8GjN+nFQWHGUvwwbcja59apGv3gjck+497oKTf5oixLdqV1hY6WEWp23ITa
QU95BTSOsKhItyTkFG99
=0elf
-----END PGP SIGNATURE-----

--AeV5K6od5T1ecbwcM7D0wjPTNtVhxLNA7--
