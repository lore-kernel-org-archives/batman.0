Return-Path: <ordex@autistici.org>
Date: Sat, 4 May 2013 14:17:28 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130504121728.GE3773@ritirata.org>
References: <1366727676-23233-1-git-send-email-ordex@autistici.org>
 <201304240358.56353.lindner_marek@yahoo.de>
 <20130423200434.GC16603@ritirata.org>
 <201305042012.23113.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0H629O+sVkh21xTi"
Content-Disposition: inline
In-Reply-To: <201305042012.23113.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/7] batman-adv: use vid when computing
 local and global TT CRC
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


--0H629O+sVkh21xTi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 04, 2013 at 08:12:22PM +0800, Marek Lindner wrote:
> On Wednesday, April 24, 2013 04:04:34 Antonio Quartulli wrote:
> > On Wed, Apr 24, 2013 at 03:58:56AM +0800, Marek Lindner wrote:
> > > On Tuesday, April 23, 2013 22:34:30 Antonio Quartulli wrote:
> > > > @@ -1535,7 +1535,9 @@ static uint32_t batadv_tt_global_crc(struct
> > > > batadv_priv *bat_priv, orig_node)) continue;
> > > >=20
> > > > -                       crc ^=3D crc32c(0, tt_common->addr, ETH_ALE=
N);
> > > > +                       crc_tmp =3D crc32c(0, &tt_common->vid,
> > > > +                                        sizeof(tt_common->vid));
> > > > +                       crc ^=3D crc32c(crc_tmp, tt_common->addr,
> > > > ETH_ALEN);
> > > >=20
> > > >                 }
> > > >                 rcu_read_unlock();
> > >=20
> > > Is it necessary to define another variable ?
> >=20
> > yes
> >=20
> > > Why not:
> > >=20
> > > crc =3D crc32c(0, &tt_common->vid, sizeof(tt_common->vid));
> > > crc ^=3D crc32c(crc, tt_common->addr, ETH_ALEN);
> >=20
> > because crc_tmp is the result of the CRC operation on the VID and the M=
AC
> > address (so one per client), while crc is the container of all the crc_=
tmp
> > xor'ed together..
>=20
> As we discussed on IRC please add a big comment here explaining why we do=
=20
> things this way and not differently.

Yeah, as I told you on IRC the comment is ready :-)
Will add it in the next version

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--0H629O+sVkh21xTi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRhPxYAAoJEADl0hg6qKeOlqMP/0zBWwK89ClQ6Enn1/panRGU
4ti42AXWH3nqRQZBBOioFzokOLPSBKzNEzt8oD4YWfs5qOi+H5oodGiRMBiKGnEp
PsXqKHqFJO0R/GO8x9HtmkdVJUpKyLcBcPp4NsPvuz1dmJbu90uCLzazzcYM/KOE
YpIVw3DfuWmn1vGzqqEBSbwSYbiJln1avBaKsBViMQjql87OrIPj/bxPheDSJusw
PhDMw3IU7tbvuJXmmTsVC7Qs+CU0YN/A9mh7DKjAxhWjg5kBmyykZ2RoiP9hFXcT
i2yZPFDYZrEgxd1QzeHYaqggY5sK3Cl2u6YPH1IqSZOgCxDs2EO6+NipdnKg/jJB
z4hnRUw56T9hPm3YO9IlM92QWWouKysoa8tOkDciqsoQ2xDtXDke4AKkj03H8dbb
8MKAELmY0+wWN8KhJeHUnVxEw3RYjvBjKl0m6q4DaqOVJl75kIHA8rL/aMvsjmlA
+OlmA9npB0/Av6g2ndoyE5K7FMCvXaBJSXKVtiycIkdFJfeC8GOIlI6ePD1CTo22
MMgv9rS088JJackU5Kxy/yGJFYamHen3KkKFYhg9YV+RZhrUIsF8biyCD9X3zdr5
Z0M+Chk8iNd+UMoHiTf6bPcPdcNvpaMjn327TPdsdCwFwcOrJp76dsmvgbQ00kZe
I+sf206aC6cUG0Om920f
=MU2/
-----END PGP SIGNATURE-----

--0H629O+sVkh21xTi--
