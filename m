Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 18 Mar 2018 09:31:09 +0100
Message-ID: <8549185.kVvKlLQMVg@sven-edge>
In-Reply-To: <b512c268fbe9f9d61eadc579457d6b825fcf3638.1521196151.git.mschiffer@universe-factory.net>
References: <b512c268fbe9f9d61eadc579457d6b825fcf3638.1521196151.git.mschiffer@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2580788.gFpNCNQbVg";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint 1/3] batman-adv: update data
 pointers after skb_cow()
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

--nextPart2580788.gFpNCNQbVg
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Freitag, 16. M=E4rz 2018 11:29:09 CET Matthias Schiffer wrote:
> batadv_check_unicast_ttvn() calls skb_cow(), so pointers into the SKB data
> must be (re)set after calling it. The ethhdr variable is dropped
> altogether.
>=20
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> ---

The first two patches were applied in a155327b..7dfe729b [1]

Thanks,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/64d22c76a207ed313b2496f=
0709b2567719452c4
    https://git.open-mesh.org/batman-adv.git/commit/7dfe729b169b1217f47744e=
dbd1616f473340fda
--nextPart2580788.gFpNCNQbVg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlquI80ACgkQXYcKB8Em
e0ZLqxAAo9bjzKdZO4E0jmHIBLKEa/+Bbh5ehXQ4vg2Us/Iqj77+bAEf+yrUQOU3
265ZyGHTdIf3syJ179kZ2STf1/5FQ16A84o7ji3Yw7pA9y0p3OswkftVasfWWvNu
Oq8J0YDsH2ilkGFYnhPVtkjfctMOJ3lM9fY0YCyzUohQNO6gfjHNCvX8kHRK91RV
O59gXsBbc6Insc8GaiWVb3O0JlJAVOiv8U5ZV1MeFhcVVnVx25QXFv7P2T76vhSI
oJsj4Y9GNN7tVa/P3ufav2L65/iE8MitfVLCfmC/I4OfnZtFSsl1i7sMoQgQF1Eo
1AgZ4ThzxOJGSFRuFuz3ys8SVule3WgGDc2QZ4KMW/mmj0QYiSltrBSKURcpmwQn
MLg+Mvlyln7bcGLtISGh3fX3KW/+IKLakWmMth99Mf6Pv7E1XNXOw1QLfbU7ovfh
UDDzotseaw3xN+zOOu865ia4YSG2seFCoBimIbbPrkQTA7GSUDbgpUmzDFd5oOYq
vUf9SX8zleZ8hbhYQG2+aDF0uYBBeKqI4tW/DoFORmWDYjaQ+psH1rlHp+RljbF1
4fdmfQTtWMurZmHC1SUidJLIIW6pEDV8TnU60Suq6ZmwpcgDfUP2z8D4hSsf2peq
/2q95l5rr+d47O6BuBF7fhHvPo3S1yOX+7QSo7C9klaWaZjYgyo=
=nLK4
-----END PGP SIGNATURE-----

--nextPart2580788.gFpNCNQbVg--

