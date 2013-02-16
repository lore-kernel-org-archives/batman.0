Return-Path: <ordex@autistici.org>
Date: Sat, 16 Feb 2013 13:34:08 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130216123407.GC3157@ritirata.org>
References: <1360682516-11005-1-git-send-email-ordex@autistici.org>
 <201302162022.37757.lindner_marek@yahoo.de>
 <201302162027.24930.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IpbVkmxF4tDyP/Kb"
Content-Disposition: inline
In-Reply-To: <201302162027.24930.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: free an hard-interface
 before adding it
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


--IpbVkmxF4tDyP/Kb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 16, 2013 at 08:27:24PM +0800, Marek Lindner wrote:
> On Saturday, February 16, 2013 20:22:37 Marek Lindner wrote:
> > On Tuesday, February 12, 2013 23:21:55 Antonio Quartulli wrote:
> > > @@ -347,6 +342,13 @@ int batadv_hardif_enable_interface(struct
> > > batadv_hard_iface *hard_iface, goto err_dev;
> > >=20
> > >  	}
> > >=20
> > > +	/* check if the interface is enslaved in another virtual one and
> > > +	 * in that case unlink it first
> > > +	 */
> > > +	master =3D netdev_master_upper_dev_get(hard_iface->net_dev);
> > > +	if (master)
> > > +		netdev_upper_dev_unlink(hard_iface->net_dev, master);
> > > +
> > >=20
> > >  	hard_iface->soft_iface =3D soft_iface;
> > >  	bat_priv =3D netdev_priv(hard_iface->soft_iface);
> >=20
> > Seems we need some compat code here:
> >=20
> > hard-interface.c:348:2: error: implicit declaration of function
> > 'netdev_master_upper_dev_get'
>=20
> I wouldn't be surprised if netdev_upper_dev_unlink() also needed some com=
pat=20
> code ...

netdev_upper_dev_unlink() is already in the compat code as it was needed by=
 the
patcheset you have already merged this morning..

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--IpbVkmxF4tDyP/Kb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRH3y/AAoJEADl0hg6qKeOj5QP/3RzmQ0CXb8f2TGN9Gf9IPJq
IWNLZnxTcggQfC0bhHq1YwAkMLuoc/bpcVgQS7ddH/XLe+RRYr0bzrhyN7/YL0bo
s6xYWYFf94QeINi9MXcnGA5xcaq868Oxg2JCUgxUtGAPZvR+iRXBxyHQV2+LRr6r
jz5dARANB+Rrf4mTrkBVTcw8xS3/65W/GPpeNyYfmKp9KDoeF/LH2CoLbJx0s+Ms
fD5Lexrp4PRf4R6jnUtyOTTGuW7/VuRY8OBOAG382IW50D6EVLCE2wdVFjsZ2N/s
dSoAXUC9unhHmgqImhkXBbHXudMgnAPxoRn/HGDG+v1p3EJbYfsT5HnDPUJbcDTi
zO8urpRyYqQ0byHEWOfsohSZnWCG/onY/s95lpId95SVv01aqcAiTR5EU3qyl6Rt
tR4V2uyPntCEObxN6wyhcsbs+huECRUxfIUJHNO+IsLg24PC7vyuXBu2l806h3XA
rx3yQM3SqE+udkgVvBgCOf4nlJ5RuEYufg4s7JUoOYXdjuN/hX1s4XDJc47faXi/
9s4EyNoeiRf25edLXftoju90tlgAAOe2db7xfQ+Ht2l+J0lrlES3gHSLZu/7h3Dg
I/1zuztWZQU1g8jI7erPMDHSLvGCiH2V86zMnGg4F/bXt/GMDYf4G/W1CjGylWIK
MVHG00u15ltBE3oCFKUo
=wXsl
-----END PGP SIGNATURE-----

--IpbVkmxF4tDyP/Kb--
