Return-Path: <ordex@autistici.org>
Date: Wed, 26 Jun 2013 23:05:22 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130626210522.GG2120@ritirata.org>
References: <1372266127-1281-1-git-send-email-ordex@autistici.org>
 <1372266127-1281-3-git-send-email-ordex@autistici.org>
 <201306270500.04863.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="B8ONY/mu/bqBak9m"
Content-Disposition: inline
In-Reply-To: <201306270500.04863.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv9 2/3] batman-adv: add sysfs framework
 for VLAN
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


--B8ONY/mu/bqBak9m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2013 at 05:00:04AM +0800, Marek Lindner wrote:
> On Thursday, June 27, 2013 01:02:06 Antonio Quartulli wrote:
> > +static struct batadv_softif_vlan *
> > +batadv_kobj_to_vlan(struct batadv_priv *bat_priv, struct kobject *obj)
> > +{
> > +       struct batadv_softif_vlan *vlan;
> > +
> > +       hlist_for_each_entry_rcu(vlan, &bat_priv->softif_vlan_list, lis=
t) {
> > +               if (vlan->kobj !=3D obj)
> > +                       continue;
> > +
> > +               if (!atomic_inc_not_zero(&vlan->refcount))
> > +                       continue;
> > +
> > +               return vlan;
> > +       }
> > +
> > +       return NULL;
> > +}
>=20
> Aren't we missing a rcu_lock()/rcu_unlock() combo ?

I was unsure of this because of the context where this for_each is executed.
But I think there is nothing protecting the RCU..so yes, we need
rcu_read_lock/unlock.


>=20
> Cheers,
> Marek

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--B8ONY/mu/bqBak9m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJRy1eSAAoJEADl0hg6qKeOl0wP/jIPJ+Rp8ZkJJp5qeSy6xRXL
gh1rAfeXjPb8hoaZ3LqZCfoAy5bYFgySpHnnntSO6DRPywwxbhxFb0AinSk5tIN/
lfyh+vebkfj/L0EZSswstInsFbOQT8kaw7ApoG+p9fwzKYYCIEha5wLm9ZMSgS1/
Zq04ra/Ab9U1Mxe5OFOiMOEIgL9DvmQHPZfHj3wiFtLftiz4ce4wDYMcYFgar/xR
RvRm4VN9+CdDCpdFbhlJspwL3Z/C6nN1IVUmfp6Zdxf+v2CQVdt3/FiR/PJhoVqx
BDyxL1SM9lLS+EpvcJBYrNtbiC3nUsr/VBmC83avFS48cgFBsYG7bA7KLH0ZN8Tw
Gsb4V4wVSoImKB29a+6YHWtOgSJEV4WwUaIT8p3y3UiNTS8QGDqvIg6s8KeS0F7N
jpY2hHTUlYvW3ZeuC4nWieHGz1LuyhQVvEGKR6+fC8d9xeT3K1Y7j2bRp8DBC2n+
R9tqHPnad/VMVHcdlpAXYf7837JAFQmnBYF++FUZihsFGwxZKLjPH6r6qPhT5CoS
2srec3I5/1UcrX51HA+cDdctT52hRP7DwUFmrqME3uIA6IdC0qxrfgKo6xSRtN83
1nHcfo8gvb6NWUxfC7S9CCTQ7GpinDWxqxBoupG0Ued9uV9xEXTnZ/MkMsfc1jyG
EMtUInqA5u3XIp6Dp9ZL
=J9h2
-----END PGP SIGNATURE-----

--B8ONY/mu/bqBak9m--
