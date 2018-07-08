Return-Path: <a@unstable.cc>
References: <20180707200121.2684-1-sven@narfation.org>
 <20180707200121.2684-4-sven@narfation.org>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <5abe742c-110a-8ad4-e46b-bb4cd6d39945@unstable.cc>
Date: Sun, 8 Jul 2018 18:45:12 +0800
MIME-Version: 1.0
In-Reply-To: <20180707200121.2684-4-sven@narfation.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dBmRql66YXDtAkJpi22jopJpMcvaTmnI7"
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: Convert
 batadv_dat_addr_t to proper type
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dBmRql66YXDtAkJpi22jopJpMcvaTmnI7
Content-Type: multipart/mixed; boundary="7ycEX5c6uUqs3HmhE57zIeUhEL4lhLaVD";
 protected-headers="v1"
From: Antonio Quartulli <a@unstable.cc>
To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>, Sven Eckelmann <sven@narfation.org>
Message-ID: <5abe742c-110a-8ad4-e46b-bb4cd6d39945@unstable.cc>
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: Convert batadv_dat_addr_t
 to proper type
References: <20180707200121.2684-1-sven@narfation.org>
 <20180707200121.2684-4-sven@narfation.org>
In-Reply-To: <20180707200121.2684-4-sven@narfation.org>

--7ycEX5c6uUqs3HmhE57zIeUhEL4lhLaVD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

On 08/07/18 04:01, Sven Eckelmann wrote:
> The #define for batadv_dat_addr_t is doing nothing else than giving u16=
 a
> new typename. But C already has the special keyword "typedef" which is =
also
> better supported by kernel-doc.
>=20
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Acked-by: Antonio Quartulli <a@unstable.cc>



--=20
Antonio Quartulli


--7ycEX5c6uUqs3HmhE57zIeUhEL4lhLaVD--

--dBmRql66YXDtAkJpi22jopJpMcvaTmnI7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAltB6zgACgkQB6U8WA7y
zXSpMhAAsJPVEoaBpptXJDlujNdYXVaGSqWWvTFplqDn/3QT53BsW+VX6FlUUwwf
fSEqjNNffRTAUrm1hnZe0hjEyMpTTMbFqtOcJYGm1zDgqKTgvcRxm9vQYySej2fe
KF0lnmbuOerJCr2AzHH4kgiCucuN+/9VfonXYJFsbjNSAA0mhxJ0Q3NvGNTXc8b7
bymCgvL//kZnvCYWTK72wX84yaiXuoMgb0/MsKaeW93gk11UCXxR8SXBtGbLH1lf
0KWlwiTnAr2T5HMbtETJq5+DWhOhcurVCg64yi5iiNcgZxk3+RYy6fBBaUyr8oC6
GPkWR36wEy/FtaRg/4zzff74+i4Iq7z1kvoWkZZxwEabaux4lBk0sAVYIMWQBAbP
5oYTDTpdBz+xu0YmOuXF6PF01y1zZ4OUnPrZlR/hfiXygnhpPgUST2eRiBsgiFEG
jBGlvIIWN6yZjp/fFydhM7ocLxS+j0CkWp8WLfPZvASkH4DZk0MDJ1eFpb4U95yI
pXecuf7+bcFCRsVk05XzOZ18U1XkHticrH3CXE+ia8ODqbp3w1E1KVylWiD4VvH4
P0T5CCIHyxiCX+7FyHw4fpftLO4ROrFUcVkK22DS5xcwwvC2b/13gpLgY4YgXa4l
spVN8g/ElzBTOYMis4Nt++TQA2JOycPnU566rAC8hsfSEldWMs0=
=RX1g
-----END PGP SIGNATURE-----

--dBmRql66YXDtAkJpi22jopJpMcvaTmnI7--
