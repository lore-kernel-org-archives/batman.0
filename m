Return-Path: <antonio@meshcoding.com>
Date: Sat, 16 Nov 2013 10:10:21 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <20131116091021.GI1663@neomailbox.net>
References: <1384360685-366-1-git-send-email-antonio@meshcoding.com>
 <1384360685-366-2-git-send-email-antonio@meshcoding.com>
 <3563164.50QBaKXCKk@diderot>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MPkR1dXiUZqK+927"
Content-Disposition: inline
In-Reply-To: <3563164.50QBaKXCKk@diderot>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 1/6] batman-adv: add isolation_mark
 sysfs attribute
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


--MPkR1dXiUZqK+927
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2013 at 01:35:53PM +0800, Marek Lindner wrote:
> On Wednesday 13 November 2013 17:38:00 Antonio Quartulli wrote:
> > @@ -692,6 +692,8 @@ static int batadv_softif_init_late(struct net_device
> > *dev)>=20
> >  #endif
> > =20
> >         bat_priv->tt.last_changeset =3D NULL;
> >         bat_priv->tt.last_changeset_len =3D 0;
> >=20
> > +       bat_priv->isolation_mark =3D 0;
> > +       bat_priv->isolation_mark_mask =3D 0;
> >=20
> >         /* randomize initial seqno to avoid collision */
> >         get_random_bytes(&random_seqno, sizeof(random_seqno));
>=20
> Wasn't the plan to initialize isolation_mark_mask with something useful l=
ike=20
> 0xFFFFFFFF ?

Uhm, no. The plan is that when the user enters a value _without_ specifying=
 a
mask, then we assume the mask is 0xFFFFFFFF (this is what mask =3D UINT_MAX=
 does
in the next few lines).

During initialization isolation_mark_mask must be 0 because this means "ext=
ended
isolation is off".

[...]

> > +static ssize_t batadv_store_isolation_mark(struct kobject *kobj,
> > +					   struct attribute *attr, char *buff,
> > +					   size_t count)
> > +{
> > +	struct net_device *net_dev =3D batadv_kobj_to_netdev(kobj);
> > +	struct batadv_priv *bat_priv =3D netdev_priv(net_dev);
> > +	uint32_t mark, mask =3D UINT_MAX;
> > +	char *mask_ptr;

[...]

> We always have 'show' before 'store' in the sysfs.c file. Please keep the=
=20
> order.

Ok, will do.

>=20
> Where is the sysfs documentation update ?

Oh, right. I totally forgot about that. Thanks!


Cheers,


--=20
Antonio Quartulli

--MPkR1dXiUZqK+927
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJShzZ9AAoJEADl0hg6qKeOsCMQAJ0hCZPr1dWo+3FTqBKD7W8E
wiU2R2yqYPHyyXGoItYANFxQTztBw5mkzTclM+BS1JUcEOMT/Fi9HPFZpZaBrlnW
DMdqzmHFAoHA3WNvFiaFTP2s7A9u0WknUSnzD3SHU3AJ45viGnYlvqXfZs5uMP/+
as3IIVtvl00nfXs7rEu6Xi42Unrkp3ARZA2Pr3uoS2sMGJlBd+j3I+c5Nu6Z8t6u
jXmfP/zHNwGohdlzV8L5nFgOVztnRGz9ZpgPnNgMBh6eS80i+GtzMAOhImez2TMf
NkkihAG4sIAFtOzW/xP3T6qd74IbG6I0XH+50gR2ERaqhhLulgE4HVMLX1LtaD3V
nOKOpth6Kwllr1Vzzcs1o5w1cpUXfpibuG54NBp8uT/ph8XkVExe1WiMVHcmlbTo
DVZGmiljUHNpZSgAmhvhEBVwNgF835wUBRlMNskRxXpPy+Gat3d2TULZR5PoV3GI
J76+bJmXRoyOliQdy9a88HB2kfgv2jyZcAcjFTiHQPJsNRLqc3f8vRT5L6KyE0yE
VmhoD7TycU9hXy7XuHkXHzYIiNAIrMvBssa265ysftd8JlsrwdYgnXKoVBnapKcc
5a5TS3SN5nmj3HkhKhkGZ8mhgm76RTqAmkkRMDLmpStsrDX5hUQhNk0nu/llEO5b
CNMmBg/kw1NhOjQPvVY1
=UvTo
-----END PGP SIGNATURE-----

--MPkR1dXiUZqK+927--
