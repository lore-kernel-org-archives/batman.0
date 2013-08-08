Return-Path: <ordex@autistici.org>
Date: Thu, 8 Aug 2013 10:27:28 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130808082728.GP2943@ritirata.org>
References: <1375916848-1874-1-git-send-email-ordex@autistici.org>
 <201308081255.22537.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6lXr1rPCNTf1w0X8"
Content-Disposition: inline
In-Reply-To: <201308081255.22537.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix memory leak in
 batadv_softif_create_vlan()
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


--6lXr1rPCNTf1w0X8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2013 at 12:55:22PM +0800, Marek Lindner wrote:
> On Thursday, August 08, 2013 07:07:28 Antonio Quartulli wrote:
> > --- a/soft-interface.c
> > +++ b/soft-interface.c
> > @@ -466,8 +466,10 @@ int batadv_softif_create_vlan(struct batadv_priv
> > *bat_priv, unsigned short vid) atomic_set(&vlan->ap_isolation, 0);
> > =20
> >         err =3D batadv_sysfs_add_vlan(bat_priv->soft_iface, vlan);
> > -       if (err)
> > +       if (err) {
> > +               kfree(vlan);
> >                 return err;
> > +       }
>=20
> You raise a valid point here but what about the local entry that is added=
=20
> right above ? Does it require cleanup as well ?

Good point! Thanks!

I think I will move the tt_local_add right below this if loop.
v2 is coming.

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--6lXr1rPCNTf1w0X8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSA1ZwAAoJEADl0hg6qKeO1toQAKQXeqRKyGSImgx0RKKgGQmG
irNoftUyyFEEb61+jVlL4kE8MsZvooHAa0rA3V24Cy/wN7E9nEHcL4owcx6LdElf
pua3mfBZM+F4YW45PidleFupv5RE4Om6KuLagi04OYM2Y2MnEc5ILDx9wD9+tix9
AXIjSU+D5ahojIZFTK3SYFouXcqQxe+rIgSpUJ6eKatBos5JNuZrpoFqT2xVo4Hh
1F+4xRmIz2vekFpgHGZUwjg0wjJmp9LUF4thnVy8tFSMC9suGJie4sj71afcGUjV
/UzLO97PK5tyoSQMOiQdsUu1UpqJDRQmK19k/47Jj34aSIrpX5jWSOPBnnKTx6XU
pmu7H0slPb+9elWC0gxaYt6aNv0UfFipCX1GMcZiXy9VYrd/EbacOnskuzej8MuD
swYLzUJjw07/YjnJEOCEHTzuwM8ju1HROIenmywcgtzUMFIAnrDpvt2SsQLnDj3Q
ulNlbBsLZKyU0werg5E/KVMsvVitMnfh1hfW8OSEYP4AEatOJxr6bsB8JRD25aWC
Gk7eXqjKTHz8nblT8hVgSQCEkucRBDHGY5JgrW4aMVyd/PMh7jRzvIsE/EBEqLTx
hqDqCILf/3nJ+3JOh4IfGQsaCweJNm+5ICQLqs/3D0JgsIYet6d3xKvfjm1lgB9O
fIxKZBIWHgGsXlEq/hEn
=ylLs
-----END PGP SIGNATURE-----

--6lXr1rPCNTf1w0X8--
