Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 11 Sep 2015 17:43:48 +0200
Message-ID: <3031965.xR9RMR6qaB@prime>
In-Reply-To: <20150911151956.GF19674@ibawizard.net>
References: <1441980723-3805-1-git-send-email-sw@simonwunderlich.de>
 <20150911151956.GF19674@ibawizard.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3371709.ZM735Ugx8Z";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH-maint] batman-adv: lock crc access
	in	bridge loop avoidance
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org, Petr =?utf-8?B?xaB0ZXRpYXI=?= <ynezz@true.cz>


--nextPart3371709.ZM735Ugx8Z
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"


On Friday 11 September 2015 17:19:56 Petr =C5 tetiar wrote:
> Hi,
>=20
> Simon Wunderlich <sw@simonwunderlich.de> [2015-09-11 16:12:03]:
> > @@ -1669,11 +1685,15 @@ int batadv_bla_claim_table_seq_print_text(s=
truct
> > seq_file *seq, void *offset)>=20
> >  =09=09hlist_for_each_entry_rcu(claim, head, hash_entry) {
> >  =09=09
> >  =09=09=09is_own =3D batadv_compare_eth(claim->backbone_gw->orig,
> >  =09=09=09
> >  =09=09=09=09=09=09    primary_addr);
> >=20
> > +
> > +=09=09=09spin_lock_bh(&claim->backbone_gw->crc_lock);
> > +=09=09=09backbone_crc =3D claim->backbone_gw->crc;
> > +=09=09=09spin_lock_bh(&claim->backbone_gw->crc_lock);
>=20
> shouldn't this be spin_unlock_bh?

Oh my, good catch! Yes, that's right!! I'll send a revised version!

Thanks,
    Simon
--nextPart3371709.ZM735Ugx8Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlXy9rgACgkQrzg/fFk7axbRCgCfXSaavBjd4CozL9Penv7/VHQ5
c7YAnjD7gVfgWTmPEQ/13tVkX2wGNLwc
=+kCC
-----END PGP SIGNATURE-----

--nextPart3371709.ZM735Ugx8Z--

