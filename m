Return-Path: <antonio@meshcoding.com>
Message-ID: <5581A993.8020306@meshcoding.com>
Date: Wed, 17 Jun 2015 19:08:35 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1434556811-4120-1-git-send-email-mareklindner@neomailbox.ch>
In-Reply-To: <1434556811-4120-1-git-send-email-mareklindner@neomailbox.ch>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="L0ArGToPD1xtj2TdrHdVgFV3DQ97fnpx0"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 maint] batman-adv: protect
 tt_local_entry from concurrent delete events
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
--L0ArGToPD1xtj2TdrHdVgFV3DQ97fnpx0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 17/06/15 18:00, Marek Lindner wrote:
> The tt_local_entry deletion performed in batadv_tt_local_remove() was n=
either
> protecting against simultaneous deletes nor checking whether the elemen=
t was
> still part of the list before calling hlist_del_rcu().
>=20
> Replacing the hlist_del_rcu() call with batadv_hash_remove() provides a=
dequate
> protection via hash spinlocks as well as an is-element-still-in-hash ch=
eck to
> avoid 'blind' hash removal.
>=20
> Reported-by: alfonsname@web.de
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>

Acked-by: Antonio Quartulli <antonio@meshcoding.com>

--=20
Antonio Quartulli


--L0ArGToPD1xtj2TdrHdVgFV3DQ97fnpx0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVgamXAAoJEOb/4TMchkvf4v4QAIu1tjmM4f5XPvv8Q5fVIqMY
AUYJO4jPedUtPNAIQsvdKkNNsQ6gFTBJzn5BKRWtgroniYzLgHQFu8bzijtbCYQS
7XLSQbqfdCrQuVwtXSaXum7oISPFJC6vuFRJq+Jtfjf2sdiaDy5V2VFYsjhNQLh8
6qxDEY7mDxvxSkztFhn1vbYCYTY7uHNV6cF5MIeoojxLFiAKUei4gtGxPJvPQNIA
n1JPCYWgv/At3Kru3VvAsbq4oPaqV4okEo9OvdDIPz72iFSiAmA7l02c6EDkcyHV
YJ+S1pjb+Eo9vu6brSFmzJyBa/pVPuEEsmpCJ0Xm3oC4vhYaet4DgbHMCJH7Kvsj
6mDMBkDrSBNl9ZTmM49OThXTysBUKHTkUAWrueKt0qMcjb8EEyIteygEd62UuHEd
8TjE/T8Z//Pr0JgeW8/r2eJZS9EbvojJku3aqpy3YP6aOY05hQPSA8jbvdOWGF5f
TFG4xKdgPk1XxYAu4j10Ai4kr4gMVb8dA5oeOCJdrKWwQJjJGV7AvFhfHjBqfuj8
1yeVrGtBLAbpIgqS00mhL6u8ooQBgmgDmyocHbclBVFEUWYLSPi385xXciptkyXL
DqLuwsq9POkRMh1igEwLB7UoVNasgCN8lr00ukcC5M1IIQRP8juu8SOrLN9FbPCd
XvwE40e2msSLEkd81SzS
=oOTW
-----END PGP SIGNATURE-----

--L0ArGToPD1xtj2TdrHdVgFV3DQ97fnpx0--
