Return-Path: <antonio@open-mesh.com>
Message-ID: <5346BE8A.5080601@open-mesh.com>
Date: Thu, 10 Apr 2014 17:53:46 +0200
From: Antonio Quartulli <antonio@open-mesh.com>
MIME-Version: 1.0
References: <1396211704-4677-1-git-send-email-antonio@meshcoding.com>	
 <1396211704-4677-3-git-send-email-antonio@meshcoding.com>
 <1396951464.5936.17.camel@jlt4.sipsolutions.net>
In-Reply-To: <1396951464.5936.17.camel@jlt4.sipsolutions.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="765bCJaP7sV5sxhoA3SRKaD1HxSO8pQpK"
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
--765bCJaP7sV5sxhoA3SRKaD1HxSO8pQpK
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 08/04/14 12:04, Johannes Berg wrote:
> On Sun, 2014-03-30 at 22:35 +0200, Antonio Quartulli wrote:
>=20
>> +	u32 (*get_expected_throughput)(void *priv, void *priv_sta,
>> +				       struct ieee80211_supported_band *sband);
>=20
> why would that need an sband argument?
>=20

I needed this because I saw it is required by some RC algo (only
minstrel) to extract the bitrate starting from the index.

You can check patch 4/6 for this:

+	bitrate =3D sband->bitrates[mi->r[idx].rix].bitrate;

maybe I can extract it from another structure? I couldn't find any way..

Cheers,

--=20
Antonio Quartulli


--765bCJaP7sV5sxhoA3SRKaD1HxSO8pQpK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJTRr6OAAoJEEKTMo6mOh1VmJMP/0d5i0rUXPfXslvjVBI+X8fk
+Df69msrRXEJdZSVSZztlfXy6fv4fSNFFPZ0nZ4d4zs0SZhSe1LJ7ubrei/hXKaT
B3K94lQxJPO3oYwZ+kCUT/AOwpEo5igAvy21XW8ndorfciZUm+1CN1Kl3t/UX+1S
TWAb1KGKOzKayzQrDHP43AEagKJDLRtmYATI+8mdxOYNrS3Rrh2VhKekSTq2nRmJ
xzD12sELTenPlFGYnMfiqiboyYWTsZjLsyGDzm+plmGHiCSdMy3yH6D8Q0NF8GgW
/I8uawIB19j1dHNFd3EihFL5TEnKYxwJIvjEWj6Ro1SlSF8xbspLGCiP5IVR+vRH
1XjfrBo1cB/rQOkNw0wbfgLu5tmJlOCObzVcsrO39pGy/itd/GN9hpIULNcW6YP1
c1EXxLT53VrHmr48bHp1wdBc9nREaqkTrWo/KHc+nniBNc1+0I4kZhS52/wNJNh6
dNOqDYo+FQTzPFUI2eaW/22HvHzKGtjXsx6ujhvSfObc785ny/ToH52yGHC1VZDx
day4lVTR9shUKtIYZL4vYszAU9gWI7BUlVbO2Eo5TOskgul7Q36nlsK4ZOlrKsGE
/+lnWH4b7KIPbGrKKgBCc90G3eih970ZHO8GmLv+rFu+OT6bnLZPwAgqdA81qxFe
fkDcLl6CyFrD+Hc+U3MU
=e52L
-----END PGP SIGNATURE-----

--765bCJaP7sV5sxhoA3SRKaD1HxSO8pQpK--
