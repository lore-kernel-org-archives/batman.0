Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 05 Jan 2019 18:22:08 +0100
Message-ID: <1945694.KajX6SUHRp@sven-edge>
In-Reply-To: <20190105151224.GQ21623@otheros>
References: <20181207135846.6152-1-sven@narfation.org>
 <9046472.zWXYbWcy6o@sven-edge> <20190105151224.GQ21623@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1824393.xHCZ3PyRSZ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC v3 03/19] batman-adv: Prepare framework for
 hardif genl config
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

--nextPart1824393.xHCZ3PyRSZ
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Saturday, 5 January 2019 16.12.24 CET Linus L=FCssing wrote:
[...]
> > > often with these net_device reference counters...) Same for
> > > batadv_get_softif_from_info().
> >=20
> > No, no, no, no, no, no, no and again no. The net_device is the only thi=
ng with=20
> > a refcounter here. The bat_priv doesn't have a refcounter because it is=
 just a=20
> > memory region in the net_device.
>=20
> With "Same for batadv_get_softif_from_info()" I was talking about
> the
>=20
> > In any case, maybe it would make sense to mention increased refcounts in
> > the kerneldoc?
>=20
> That is to add a line like "Increases the refcount of foo and
> bar." So that users know which references to release and how to
> use this function just from reading the kerneldoc.
>=20
> I'm not talking about bat_priv here.

Ok

Kind regards,
	Sven


--nextPart1824393.xHCZ3PyRSZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlww58AACgkQXYcKB8Em
e0YRXg/+IZqlBUeyyfzLiGl9Hll+0/WBulRRgK1DXzNVGEuA0OZ/v49bKJQfHUaW
CnjPCym3+ziYVWtDbObT7MbcWAI9H47aRAiRTj/BCUXokUWbYN4IsM8qzVEw9pLZ
b8H1rtQlWoSmZ+SqzmiV/TxUYlPJo+QXMWMolxUED+eBs6cPFu7s7L+JT/xvMsAD
Q9ypzO820MwuKC53kD0GScMAl7Hah6Acu0HMxRNhTIdO8xJ+qxQu26bwftvOQ44B
+iYE76j/oyHECfuBrU6CFsAB2Wj7nRIrFT6cxCMx7pw7uKJO7kxVyAM2UfYyyk2n
4GXRE35meqWXI82sisd4c6azkrqkLLnG+8lGkiv1bW6OKFtw/2uoyAbQUfQAnNmr
YyY8hwIw30D8Iuu97mITHTu+xd9jlO/vNL8BqKUuU/6uyNKEWu+LUYd1V6Kt5xll
nUgXQmZaEGneoNw9CvmWsYgrORB9f1LLt67VLeTt4AUDHDArB1bgNfDAqAIPItyM
EAeLQmdjLzpq0adZMQ2ZN2+d/1IJ2Cxec/3fXt3dbplEcuHv35/wikUq4MGl/Rad
zTI07xUWlogXqV6xab+j1wAstbzLt3m0+8I2dOPqgkQyzzwCUM/+Pebu3ssushFr
8X32mZgj0KVzptUiX7CFPLoNrw34AZCH9hozgbg+w5tPeagjPhQ=
=iby2
-----END PGP SIGNATURE-----

--nextPart1824393.xHCZ3PyRSZ--



