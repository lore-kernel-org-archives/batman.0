Return-Path: <antonio@meshcoding.com>
Message-ID: <5583CC0A.9020802@meshcoding.com>
Date: Fri, 19 Jun 2015 10:00:10 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1434697758-8399-1-git-send-email-mareklindner@neomailbox.ch>
In-Reply-To: <1434697758-8399-1-git-send-email-mareklindner@neomailbox.ch>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4DMAQt50rjMVfbWKwbakjHvhSoh44UKTm"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: convert tt request list into
 hlist
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
--4DMAQt50rjMVfbWKwbakjHvhSoh44UKTm
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 19/06/15 09:09, Marek Lindner wrote:
> The tt request list does not require a double linked list, hence a
> conversion to hlist saves memory without losing functionality.
>=20
> Also, the list_del() call was changed to hlist_del_init() to allow
> an adding an extra check prior to deletion in batadv_tt_req_node_new().=

>=20
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>

Nice one :)

Acked-by: Antonio Quartulli <antonio@meshcoding.com>


--=20
Antonio Quartulli


--4DMAQt50rjMVfbWKwbakjHvhSoh44UKTm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVg8wOAAoJEOb/4TMchkvfl+YP/ja+NfvE6kg2YcMgHEwQsAcY
Kl9jRZ4XfOcUJZy0R2cNIrzDpjAM6pOSDKYJUtMY0e7cS/atnoEswaFRAaKEUEGL
pXzieHF7kumK5Q/XjCYVk55UDoRWxTOsOW967WZ0Bmdf56CMZVBBA10ybVNxKqVG
/IjAUTC1t+D69IHXhuqwHLbZyFFMY8oYMVoSWTB1qlMmsu69OdPQzb2OgDVr1+zG
M3+RGrqVNUz9UEwSnee3/1HG8ABggutVu5gYWOvPbytn6F1hCJWaZyNwmPWG519s
BCd/h2eGQdy2YGfntTqAyHF8YZfP9gNXpPVxFYxuF57PazmQ5TYE++SK/83gVfai
MND2G7ZDzv1ykhZcYxvpyMRVvwbGu25d6iZ4b0TxFJjORVLpegPFNRv+mHMH4ywZ
FZueDWYBduDyGB+oR0rGKWqywPnpBVwsRJvBugbxVovqxK06pxfawdlQIzJVX3Cw
PBiNAlrQj2iPfiJjQwMf76y+hEBstfQpaRVKstbxJoLkXQDRsYn6tYrQlDpVaSTq
KkqnyjTdKyVfhufKJIAUN+9YjBCuI9yVvwbdaHkhRwtTN8/AFgRa66EQCnSj3bd4
3SR32HIMsSzqOIERo05hWx1VoXCR6segu94Kyuo2gzJdnNlh7qWLShOmGXSmIU06
tv5TuJsthxtrGQpS7Ky3
=iqt1
-----END PGP SIGNATURE-----

--4DMAQt50rjMVfbWKwbakjHvhSoh44UKTm--
