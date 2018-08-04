Return-Path: <a@unstable.cc>
References: <20180804134854.4075-1-mareklindner@neomailbox.ch>
 <20180804134854.4075-7-mareklindner@neomailbox.ch>
 <1538516.THWfRjFL1q@sven-edge>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <c37e1f28-c831-d97a-85b4-55ea99733123@unstable.cc>
Date: Sat, 4 Aug 2018 22:24:41 +0800
MIME-Version: 1.0
In-Reply-To: <1538516.THWfRjFL1q@sven-edge>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mSy01u3xTGcoeASniT48CxLIuh3iscwoD"
Subject: Re: [B.A.T.M.A.N.] [PATCH v3 6/7] batman-adv: ELP - use tp meter to
 estimate the throughput if otherwise not available
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Sven Eckelmann <sven@narfation.org>
Cc: Marek Lindner <mareklindner@neomailbox.ch>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mSy01u3xTGcoeASniT48CxLIuh3iscwoD
Content-Type: multipart/mixed; boundary="LOY6R1dTXwBwwCw77KU6whtEMQDor9ODV";
 protected-headers="v1"
From: Antonio Quartulli <a@unstable.cc>
To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>, Sven Eckelmann <sven@narfation.org>
Cc: Marek Lindner <mareklindner@neomailbox.ch>
Message-ID: <c37e1f28-c831-d97a-85b4-55ea99733123@unstable.cc>
Subject: Re: [B.A.T.M.A.N.] [PATCH v3 6/7] batman-adv: ELP - use tp meter to
 estimate the throughput if otherwise not available
References: <20180804134854.4075-1-mareklindner@neomailbox.ch>
 <20180804134854.4075-7-mareklindner@neomailbox.ch>
 <1538516.THWfRjFL1q@sven-edge>
In-Reply-To: <1538516.THWfRjFL1q@sven-edge>

--LOY6R1dTXwBwwCw77KU6whtEMQDor9ODV
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 04/08/18 22:23, Sven Eckelmann wrote:
> On Samstag, 4. August 2018 15:48:53 CEST Marek Lindner wrote:
>> +               total_bytes =3D atomic64_read(&tp_vars->tot_sent);
>> +
>> +               /* The following calculation includes these steps:
>> +                * - divide bytes by the test length (msecs)
>> +                * - convert result from bits/ms to 0.1Mb/s (1Mb/s=3D=3D=
1000000b/s)
>> +                */
>> +               total_bytes =3D atomic64_read(&tp_vars->tot_sent);
>=20
> Reading it once is enough :)

argh, agreed! changed that twice...and forgot to remote the other line :)=


>=20
> Kind regards,
> 	Sven
>=20

--=20
Antonio Quartulli


--LOY6R1dTXwBwwCw77KU6whtEMQDor9ODV--

--mSy01u3xTGcoeASniT48CxLIuh3iscwoD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAltltykACgkQB6U8WA7y
zXRLeQ//UzcdpzHnmfni300YdP0NAAqfazFrGVnm5j58qQnrEU/l1H+ZCDLwWs8X
bGHgxzGvbbR/wyGXH7zlLo0urgJZRcITtjR7i+Utch1PDX9/HmD6qxFjaRcZjDoW
S/LrCqXa3aQQGZJT4vLnGqIRIoW2CLXM1WvgWEA9FWC4NigSGL7PTnt48WPi9ilH
vVTz+CqwOIo9CvUVS5yTu8r+/P6IAj/J4TUQPi81EdkxU5XW/B9ZGHJvhlaDi3ag
dffStgenyTqb8zCYE5VA6i68VtyphG7VWUN0U2Vs6luiqFXeS/OFQC5+WJilDcp1
BZtFPSfjBjYLKqC//vTCVR+xQzNT55cyFMeYYKXh8RloAeFFZN1/7LdeU3fpUDeP
yj/XeytdvTZcC2mXAudYKks4Eh7EhDYxbumgy1qBqKedqcqEom2CcphZo6I0a3nQ
BEb7Vxu7CUYq+xGCH8i21xImhWkaCTKbQL+jvtjJxbiAYrBk1uX8lZJ6FUoJ31sz
GPpQHR01pe8/t7SVKjHel328kKarN5HvRcWeW62pqE4kEJg7hfW+SS+1NJsMjep8
41pQY8Sfk2tpW0rWWaKkFsIkevNiVUMDw9Z+uNe4uSKeW3H3lwa3R8HFP8t7gBj7
9Pwr9MpRfMH9+przt0FXjuPl6lNueisTt94b8KDT3GdrX1hEgfo=
=wIr5
-----END PGP SIGNATURE-----

--mSy01u3xTGcoeASniT48CxLIuh3iscwoD--
