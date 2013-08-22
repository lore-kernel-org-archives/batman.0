Return-Path: <ordex@autistici.org>
Date: Thu, 22 Aug 2013 10:45:29 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130822084529.GE2963@ritirata.org>
References: <1377156073-556-1-git-send-email-ordex@autistici.org>
 <201308221552.36925.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8TaQrIeukR7mmbKf"
Content-Disposition: inline
In-Reply-To: <201308221552.36925.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: print the VID in the
 dat_cache output
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


--8TaQrIeukR7mmbKf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2013 at 03:52:36PM +0800, Marek Lindner wrote:
> On Thursday, August 22, 2013 15:21:11 Antonio Quartulli wrote:
> > @@ -761,8 +761,8 @@ int batadv_dat_cache_seq_print_text(struct seq_file
> > *seq, void *offset) goto out;
> > =20
> >         seq_printf(seq, "Distributed ARP Table (%s):\n", net_dev->name);
> > -       seq_printf(seq, "          %-7s          %-13s %5s\n", "IPv4",
> > "MAC", -                  "last-seen");
> > +       seq_printf(seq, "          %-7s          %-9s %4s %11s\n", "IPv=
4",
> > +                  "MAC", "VID", "last-seen");
>=20
> Why are you shortening the MAC address length while you try to add the vi=
d ?

This is only to arrange the header line. If you test the code, you will see=
 it
looks good this way :) I also added some more space at the last-seen text to
space it correctly.

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--8TaQrIeukR7mmbKf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSFc+pAAoJEADl0hg6qKeOh00P/iXeOq1eW0D6LR3B8ZSvPziy
nv+Mx8qk2QNp1S270rexQY0YGHJxTpJvhuxSffcGIjZvz6wH+cNlkph6L/stIJOC
p3u0ljAdq9Z/Z8ZupdMwSHVrAzmTpknwaxq6I8odwntemjZb6RDvaMWddi70o9q2
HIrrIlCKwCGdiPzliV3Wkh63jAW73Z6a3OAfTIxwktlTW+GFQb4YhtleOUAZDWqz
HhZ9Jmp292mSLsVhW+LNaoKDaNKhn5i01Y0SiJWX3e40SLjYET9SmcSkXSLjFwzs
Y/AitbiqDpdhmcn8EObHg+YlHtvfIJblvdNzTtRDJXumogQWVCOeBnQCQMM964E7
jmKglqY7CcyPtK2L2cskXZ7oENaj8nn+3OI6cmsV/63TVURTSQLp7EL42aOM+vVi
sCDrAFGa10A3IF8W9eLnwyqWkRLkXTAmMDfP33Giy9F7sa+RWruCa21yIJxx1hz0
a4Au4YzPXtdUiYVZvyL666gmyoLDYJebrYEIwMk0y4VPzshsXwyDnwMwy1Lye/v1
4oJ2DV98/uGWT224KlFToAGxMG4FxGeEZjTECnoyUM9CnVOFSOrBKeaDKLOwmN5G
KnJwV/hu0mv4ZLwIqbhbJBfso9I8yq30/5ZbxTmYIQmTsChSA2kpli7/j4JoyYa4
3eA1VamfOFoCmyweHiGu
=uVB6
-----END PGP SIGNATURE-----

--8TaQrIeukR7mmbKf--
