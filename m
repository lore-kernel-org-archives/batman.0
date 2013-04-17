Return-Path: <ordex@autistici.org>
Date: Wed, 17 Apr 2013 18:56:59 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130417165658.GF20819@ritirata.org>
References: <1366136165-5839-1-git-send-email-ordex@autistici.org>
 <201304180055.41009.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="11Y7aswkeuHtSBEs"
Content-Disposition: inline
In-Reply-To: <201304180055.41009.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: use CRC32C instead of CRC16
 in TT code
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


--11Y7aswkeuHtSBEs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2013 at 12:55:40AM +0800, Marek Lindner wrote:
> On Wednesday, April 17, 2013 02:16:05 Antonio Quartulli wrote:
> > @@ -1376,13 +1376,11 @@ out:
> >  static uint16_t batadv_tt_global_crc(struct batadv_priv *bat_priv,
> >                                      struct batadv_orig_node *orig_node)
> >  {
> > -       uint16_t total =3D 0, total_one;
> >         struct batadv_hashtable *hash =3D bat_priv->tt.global_hash;
> >         struct batadv_tt_common_entry *tt_common;
> >         struct batadv_tt_global_entry *tt_global;
> >         struct hlist_head *head;
> > -       uint32_t i;
> > -       int j;
> > +       uint32_t i, crc =3D 0;
> > =20
> >         for (i =3D 0; i < hash->size; i++) {
> >                 head =3D &hash->table[i];
>=20
> How about making the function to "static uint32_t" ?

definitely ACK

>=20
>=20
> >  /* Calculates the checksum of the local table */
> >  static uint16_t batadv_tt_local_crc(struct batadv_priv *bat_priv)
> >  {
> > -       uint16_t total =3D 0, total_one;
> >         struct batadv_hashtable *hash =3D bat_priv->tt.local_hash;
> >         struct batadv_tt_common_entry *tt_common;
> >         struct hlist_head *head;
> > -       uint32_t i;
> > -       int j;
> > +       uint32_t i, crc =3D 0;
> > =20
> >         for (i =3D 0; i < hash->size; i++) {
> >                 head =3D &hash->table[i];
>=20
> Same here.
>=20

definitely ACK=C2=B2

>=20
> > @@ -1642,7 +1631,7 @@ out:
> > =20
> >  static int batadv_send_tt_request(struct batadv_priv *bat_priv,
> >                                   struct batadv_orig_node *dst_orig_nod=
e,
> > -                                 uint8_t ttvn, uint16_t tt_crc,
> > +                                 uint8_t ttvn, uint32_t tt_crc,
> >                                   bool full_table)
> >  {
>=20
> Kernel doc ?  :)
>=20

cha cha cha, will do :)

Cheers,

> Cheers,
> Marek

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--11Y7aswkeuHtSBEs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRbtRaAAoJEADl0hg6qKeOtfEQAIQ2+QGuUUVrKqv5oTV6KGzd
mKZq/1wKzJw5x5o1exrrxvJpiPBAN2tojr3qYbv7inK+enxfxWlpwWEJHek7YAn5
qHvXzyTUJU1HsXei4Itmde+wvDicNguhdDhVq00+UQ2TRXeyiS5EBHZikQh+zGTp
L7pt2R3vUqCeogG3V+X4cGo4hjfMrFBVxxFJ7UURLIRd/F3c9oNkC1bCXLUmKPl7
B0NgLz+LCYRanpoh/yUjs3i/5xqFUi9X4XAAythM6GYpLFPj42evpw3YfAd4XD8F
muyl/xLYXKmssvdIXtvVJsNzWRaEJNrLjaNUz+MB8EndVhR/WHht74kkX9OQX/QG
5Ylh5X2CZoC7r1lwwXrHLNoiwCEBsYt+tsyBoXcCj3b60y8/NKw+UWzDtSHrLmdB
gnd9jizrry8uTviN6A0Qd5YmnjzPJoJdonLTvHr/EMkXkliNqGy2gn5F63WqTSMj
j8AOSr4nH/qBZQPfBo6QD14JSvXyeMHFIEjZFhQ4hfBPDEzOW16JCKk2YuqD5GWA
7eWDZKDlS/4Dvqf1zj3w6S+ExlxosD/tm1aZ+UG9hkZkSgz2Z687zo8MP+5outhw
IdabVkA6xW5nSdjyDV+IvSruWDbdvynXF7Pgtw4OyEJpHoLCPTS97lK5SuF0Wbxr
U3+GdnsTJoELkpO5gF3N
=Vq4z
-----END PGP SIGNATURE-----

--11Y7aswkeuHtSBEs--
