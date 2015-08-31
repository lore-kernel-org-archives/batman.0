Return-Path: <antonio@meshcoding.com>
References: <1440600113-21305-1-git-send-email-sw@simonwunderlich.de>
 <1440600113-21305-2-git-send-email-sw@simonwunderlich.de>
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <55E48290.3090902@meshcoding.com>
Date: Mon, 31 Aug 2015 18:36:32 +0200
MIME-Version: 1.0
In-Reply-To: <1440600113-21305-2-git-send-email-sw@simonwunderlich.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fnSDd9B5KNG4GoP3pCguq3Bcf4nCSQKcX"
Subject: Re: [B.A.T.M.A.N.] [PATCH-maintv2 1/3] batman-adv: fix speedy join
 for DAT cache replies
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
--fnSDd9B5KNG4GoP3pCguq3Bcf4nCSQKcX
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 26/08/15 16:41, Simon Wunderlich wrote:
> DAT Cache replies are answered on behalf of other clients which are not=

> connected to the answering originator. Therefore, we shouldn't add thes=
e
> clients to the answering originators TT table through speed join to
> avoid bogus entries.
>=20
> Reported-by: Alessandro Bolletta <alessandro@mediaspot.net>
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>

Acked-by: Antonio Quartulli <antonio@meshcoding.com>



--=20
Antonio Quartulli


--fnSDd9B5KNG4GoP3pCguq3Bcf4nCSQKcX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV5IKUAAoJEOb/4TMchkvfj5QP/3y2G/Wt8wXojZH0e0AAmMhD
mN/WQ5D3iOhEF6W1ib5WZXcGy/Afjc2/gJVgOd+PO0cwe2woYMBbxXVHN+pJUSuv
UrlkaVKw49+qCVFv6XGCJBQCJs/QQazhPvmZPbyRsGZ5YUEbORsE7GDZF6V/n+oH
3QxXMrLMfu6UYGT/S5i7unSdnTb4gIeYe26nhgHFXgw1Cv08AWQ35nxymyzG4Qpq
xCqxRhZsSlFKfu/8HRkqsD6TUhy4JjMBHtKLe4a+ek7yIDScZenAb5qW+iCLNZDN
DCUWZWYfxAMMi8VtZB3qD0yT+hy+kU7X9AOmv3wvXclTMnsqYeyu6RQ0Ra+AGDUV
iB4p0f2FxbCXHDhLShZIguGwfxygr4tQVpWxEzngAUSZ9URrdZjXbNk3uoyOqAwg
Jjx7r2SGWAY1DnzO8Tfq2PIZvoe9IRMwPr7uXYJ295RMvppTZkq9YgmK0UnOXriB
Wm3K+kF4jlxyrk4u1Ku14s3BV2n4TIveaDXymT6ImdLweDbMTrCdabbvrYATBTCA
kWpudfy4p7ycKH/gFivxm4A5bvdn8viaAnvyDS3/dEkRo/wI2X0Ps6gH5Eda8jVB
gnXFSXBhv64RpgZwj+u52YghiFC6p5gkCU10GM1A5cZgu/A5N7QzWXLEc/1t5PpM
UQV3XGyPtQXVsZx9g0tt
=XkM9
-----END PGP SIGNATURE-----

--fnSDd9B5KNG4GoP3pCguq3Bcf4nCSQKcX--
