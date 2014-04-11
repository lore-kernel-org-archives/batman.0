Return-Path: <antonio@open-mesh.com>
Message-ID: <534793D3.1020202@open-mesh.com>
Date: Fri, 11 Apr 2014 09:03:47 +0200
From: Antonio Quartulli <antonio@open-mesh.com>
MIME-Version: 1.0
References: <1396211704-4677-1-git-send-email-antonio@meshcoding.com>		
 <1396211704-4677-3-git-send-email-antonio@meshcoding.com>	
 <1396951430.5936.16.camel@jlt4.sipsolutions.net>	
 <5346BCEB.1010700@open-mesh.com>
 <1397149987.4757.23.camel@jlt4.sipsolutions.net>
In-Reply-To: <1397149987.4757.23.camel@jlt4.sipsolutions.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GQHGmO8hwMIS7q6ehVTqejaUEgBue8jqh"
Subject: Re: [B.A.T.M.A.N.] [RFCv2 2/6] mac80211: add new RC API to retrieve
	expected throughput
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: devel@lists.open80211s.org, b.a.t.m.a.n@lists.open-mesh.org, linux-wireless@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GQHGmO8hwMIS7q6ehVTqejaUEgBue8jqh
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/04/14 19:13, Johannes Berg wrote:
> On Thu, 2014-04-10 at 17:46 +0200, Antonio Quartulli wrote:
>=20
>>> What about drivers with HW rate control?
>>>
>>
>> True, they do not implement the rate_control_ops API.
>>
>> Therefore, as discussed on IRC, I need to move this new API at the
>> mac80211 level, so that each driver can implement it the way it prefer=
=2E
>=20
> Well, not *move*, but rather have both. Or you can just say that the
> drivers that may need this can worry about it ...
>=20

You are right, I meant to *add* another API at the mac80211 level and
have both. I think this is the cleanest solution.

Cheers,

--=20
Antonio Quartulli


--GQHGmO8hwMIS7q6ehVTqejaUEgBue8jqh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJTR5PYAAoJEEKTMo6mOh1V838P/35HYmA4MOPNM1qGv1EZCsH0
X28haFphUBxCSrfE5kt1/M0R0reMFmt/MKSvM/XTNh+GfKTwqVpGhIy3m/EcSNV8
bXrzeo9yCqEfqhDNeuyNzgrP0TSXyP5fcemaIdUZI1PWfs2HZ5y0BSapMvyA9PjJ
KfYj3OyDe75kjkuexPSOGtDQwf2LYVh2sNRsiFNLI6IKHKqKwVyEvkFWtymdS6rt
Qh/S19WV8DR4yaBOkwOzH/DLGWUKOMOxw+gfO+k9aGFqnpEWVAdM34C/0ueb87Ap
JOhQqY9LCxh3WLo3yobL3cbOVc9ithNgXCl8/oeWarHNF4fB846rBYKJPmY159dd
TGGQRRrsyThBye3spCGxk5fxgJI4kH4EPVgJ/kriOImcE8MTET4N4m3uNjts+QDz
6S6EkbmbOCXFL/stWm/mQ9q1hXnC3vVXaMjPkTPxXOGk6WqVoWoRNXgTc7zHoKEN
3xube5+y07hzWTMZAtNlYCOUouRf1K4gctlrQzL6ZJhtaMilIoLjBrKbhxBur5vb
Qhh/mkjGuzMkJgwyyZiMMY9manm7CV2RLn/ekBC9kgYbXsPHBEQzEA9Pcg9uOgdS
OEEB3ed38oOidDB4or58VkQ1KdzUJfFv36iIkJHVprqgAs4IK53zKrGL+AGIUv+f
81sSKyQfpX1+XcB0PkwZ
=5qOP
-----END PGP SIGNATURE-----

--GQHGmO8hwMIS7q6ehVTqejaUEgBue8jqh--
