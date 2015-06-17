Return-Path: <antonio@meshcoding.com>
Message-ID: <558169C5.7050700@meshcoding.com>
Date: Wed, 17 Jun 2015 14:36:21 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1434542995-22376-1-git-send-email-mareklindner@neomailbox.ch>
In-Reply-To: <1434542995-22376-1-git-send-email-mareklindner@neomailbox.ch>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BklpFaR6t24e6QbF15NC8sDk0mHd9J35u"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: protect tt_local_entry from
 concurrent delete events
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Marek Lindner <mareklindner@neomailbox.ch>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BklpFaR6t24e6QbF15NC8sDk0mHd9J35u
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17/06/15 14:09, Marek Lindner wrote:
> The tt_local_entry deletion performed batadv_tt_local_remove() was neit=
her
> protecting against simultaneous deletes nor checking whether the elemen=
t
> was still part of the list before calling hlist_del_rcu().
>=20
> Replacing the hlist_del_rcu() with batadv_hash_remove() provides adequa=
te
> protection via hash spinlocks as well as a is-element-still-in-hash che=
ck.
>=20
> Reported-by: alfonsname@web.de
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>

Acked-by: Antonio Quartulli <antonio@meshcoding.com>

Thanks!

--=20
Antonio Quartulli


--BklpFaR6t24e6QbF15NC8sDk0mHd9J35u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVgWnIAAoJEOb/4TMchkvf770P/1HzfLEb1izj8Clj8fbNp4G/
31ttB8R8QzYHPZN9FRVYU3AgYp6f/zbDAzzcLtLtwVromUgbz5NQ3Jji4Pjb6A83
GXMFVUuotIPrzB9W3LdTZkMAcmThTB1dzrl8hD4CZB5NgwMU/VDTchSfOIFwKjZJ
YvjzP+ncyUhmKnDlD78rHGwafSxzoeoYajIsUyAxGHcQTeLQtE6qiOHLYKMxOpK5
7HTGaAKesXWr1DH/Fe0+WiH11d6RE5JScLnlb27hw1k1WlzMeBzUIp+PwP39hImw
ndowfFCBdTGMYRcA0VMRTVVOSt6MyHUxc/1VyJKvhhV3PXRjukX63s4Jxfm/HXhn
9+MZVJOoPVOyObnGDsxpdfQHjVrgUSFQraF0ov69NGkEMrtEZjWxojS/ivzMGcQB
DTpsHRtOBj2pCmyiaO/QboWoP2QvZlzbNSq6u7Oqi1wViw5gF5gVtCyz0pg1Y2pV
4lwF3Jb+3CGDn0ziRmhm/nUtm6oUvIUm9UOWchPHPhFeVFIfkDXil+oFTxeMyVjz
ug5KIr8j0PYgjQmRD2YWOvrmIYnK0XgsL6CXnR/VONnbSSCJGMTSui/Q0X0kNMCf
TxZNu26/J43WMfYzFeS03ZKG4F8VvQWItHwfJL//bJ8jcAzORlJT3bJZPFPVusPg
Gp9hzJaQviqP2PIHOfvV
=Hg0N
-----END PGP SIGNATURE-----

--BklpFaR6t24e6QbF15NC8sDk0mHd9J35u--
