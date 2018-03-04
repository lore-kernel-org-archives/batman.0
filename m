Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 04 Mar 2018 14:15:13 +0100
Message-ID: <2380843.LR5gV1ucHm@sven-edge>
In-Reply-To: <20180304115837.4647-1-linus.luessing@c0d3.blue>
References: <20180304115837.4647-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart16732797.AMf5XL6ztH";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Avoid redundant multicast TT
 entries
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

--nextPart16732797.AMf5XL6ztH
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sonntag, 4. M=E4rz 2018 12:58:37 CET Linus L=FCssing wrote:
> If a node signals that it wants all traffic for a specific protocol
> family then there is no need to announce individual multicast addresses
> via TT.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---
>  net/batman-adv/multicast.c | 56 ++++++++++++++++++++++++++++++++++++++++=
++----
>  1 file changed, 52 insertions(+), 4 deletions(-)

I cannot say much about the TT details but just some remarks about some cod=
ing=20
style details.

> +static bool batadv_mcast_addr_is_ipv4(unsigned char *addr)

We usually would use "const u8 *addr" here maybe I missed something
but I would expect that this is also used here.

> +{
> +	const unsigned char prefix[] =3D { 0x01, 0x00, 0x5E };

All other single line array initializations in the code used "{" without
extra space after it and "}" without extra space before it.

> +	return !memcmp(prefix, addr, sizeof(prefix));
> +}

Could you please use "=3D=3D 0" here instead of "!". Every time I read !mem=
cmp, I=20
am assuming for a short period of time that the memcpy must "fail" here.

> +static bool batadv_mcast_addr_is_ipv6(unsigned char *addr)

We usually would use "const u8 *addr" here maybe I missed something
but I would expect that this is also used here.

> +{
> +	const unsigned char prefix[] =3D { 0x33, 0x33 };

All other single line array initializations in the code used "{" without
extra space after it and "}" without extra space before it.

> +
> +	return !memcmp(prefix, addr, sizeof(prefix));

Could you please use "=3D=3D 0" here instead of "!". Every time I read !mem=
cmp, I=20
am assuming for a short period of time that the memcpy must "fail" here.

Kind regards,
	Sven

--nextPart16732797.AMf5XL6ztH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlqb8WEACgkQXYcKB8Em
e0ZbMA//ePp2FDCxTr7mvWlVeOiXi9EQs8ZEumQuNuTS7XxgCsxEnSuND2PL7uqk
+mdLxLISfqLILbkineWWbtHonl88y3ezB0+gzZZxLuMenf/Y78BmJOg5/P2qfINs
2wQa6J+fALdxrNmG3T31d4QgFuXwyu4qXPeNRAGDzRi/Rt1N+U4haDk600K6TH5E
SZpZzKM0ncuJmyfKfz9BQFrCKWEZCJ0Cqz6Fq31O9JO4rX+UvXfBFfh3ml5xsVvT
qIT/Yd8rP94QT9RLieKwxTxVyo15wzznQzPQR91l8fvqo5eCF+CoqRQ3bgfNTjNN
1b4SW7eNRbDYTDWncONuqC4tNTLPRIQfbcN/RqxsO/RzISG8Z+Oh0JdOQosG+0Mk
uDAmEElEjdJEYsHO/zdKcG4RTHJhGmi9pphGOuk4Wve9IZAusk7y/A/O5du97Nzn
cfhXtc250q82pRg9Eru9qIKAYs0qrQqto/PzvUNLc9AmZpvpoOGr2KkaFH8ZooOU
NUKnIVLX1KVwOubJqYsB/pJZ7lZiVfHn6gEkrZJ+IlwZBkR4R2FzSwqaJb604sJH
KnpcHLgk+mfeQsNQ42UXSx90kXZy4bJhIFBAxMyj8Pt0zdKeqqTjwsDD8qCalI3G
v8L2yoKEXSFxR/JW10GvZnHNrrZI4lMyE5GErj9GfgGqBnrMxn4=
=GrZd
-----END PGP SIGNATURE-----

--nextPart16732797.AMf5XL6ztH--

