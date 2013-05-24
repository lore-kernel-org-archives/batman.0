Return-Path: <ordex@autistici.org>
Date: Fri, 24 May 2013 09:03:46 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130524070345.GI1679@ritirata.org>
References: <1369340122-2660-1-git-send-email-ordex@autistici.org>
 <1369340122-2660-7-git-send-email-ordex@autistici.org>
 <201305241423.42027.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="451BZW+OUuJBCAYj"
Content-Disposition: inline
In-Reply-To: <201305241423.42027.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 6/7] batman-adv: add per VLAN interface
 attribute framework
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


--451BZW+OUuJBCAYj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2013 at 02:23:41PM +0800, Marek Lindner wrote:
> On Friday, May 24, 2013 04:15:21 Antonio Quartulli wrote:
> > From: Antonio Quartulli <antonio@open-mesh.com>
> >=20
> > Since batman-adv is now fully VLAN-aware, a proper framework
> > able to handle per-vlan-interface attributes is now needed.
>=20
> We have "now" twice in the same sentence. :)
>=20
>=20
> > diff --git a/compat.c b/compat.c
> > index da556a4..b99d505 100644
> > --- a/compat.c
> > +++ b/compat.c
> > @@ -27,6 +27,15 @@
> >=20
> >  #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 0, 0)
> >=20
> > +void batadv_free_rcu_priv_vlan(struct rcu_head *rcu)
> > +{
> > +	struct batadv_priv_vlan *vlan;
> > +
> > +	vlan =3D container_of(rcu, struct batadv_priv_vlan, rcu);
> > +
> > +	kfree(vlan);
> > +}
>=20
> I bet you didn't try to compile that on an older kernel ...

ah, no I did not. :)
I'll add the prototype to compat.h

>=20
>=20
> > +/**
> > + * batadv_get_priv_vlan - get VLAN priv data
>=20
> The naming could be better. Following your initial scheme this function s=
hould=20
> be called "batadv_priv_vlan_get". How about replacing "priv" with "softif=
" ?=20
> We'd end up with:=20
>  * batadv_softif_vlan_free_ref()
>  * batadv_softif_vlan_get()
>=20

ok, will use 'softif'

>=20
> > +/**
> > + * batadv_add_vid - ndo_add_vid API implementation
>=20
> Again, the naming .. didn't we introduce a naming convention for each fil=
e ?=20
> soft-interface.c uses "interface" a lot. Why not using it ? For example,
> batadv_interface_vid_add() ?
>=20

ok, I will add 'interface'.

>=20
> > + * @dev: the netdev of the mesh interface
> > + * @vid: identifier of the new VLAN
> > + *
> > + * Set up all the internal structures for handling the new VLAN on top=
 of=20
> the
> > + * mesh interface
> > + */
>=20
> Returns ?

ops :)

>=20
>=20
> > +/**
> > + * batadv_kill_vid - ndo_kill_vid API implementation
>=20
> Same here. It should be batadv_interface_vid_kill() or something similar.
>=20

ok

>=20
> > + * @dev: the netdev of the mesh interface
> > + * @vid: identifier of the deleted VLAN
> > + *
> > + * Destroy all the internal structures used to handle the VLAN identif=
ied
> > by vid + * on top of the mesh interface
> > + */
>=20
> Returns ?

ops :)

>=20
>=20
> > +static int batadv_kill_vid(struct net_device *dev, unsigned short vid)
> > +{
> > +	struct batadv_priv *bat_priv =3D netdev_priv(dev);
> > +	struct batadv_priv_vlan *vlan, *vlan_tmp =3D NULL;
> > +
> > +	list_for_each_entry_rcu(vlan, &bat_priv->priv_vlan_list, list) {
> > +		if (vlan->vid !=3D vid)
> > +			continue;
> > +		vlan_tmp =3D vlan;
> > +		break;
> > +	}
>=20
> How about re-using your get() function from above ?

I'll check, I remember there was a reason to do not use gat().

>=20
>=20
> > +/*
> > + * struct batadv_priv_vlan - per VLAN attributes set
> > + * @vid: VLAN identifier
> > + * @kobj: kobject for sysfs vlan subdirectory
> > + * @list: list node for bat_priv::priv_vlan_list
> > + * @refcount: number of context where this object is currently in use
> > + * @rcu: struct used for freeing in a RCU-safe manner
> > + */
> > +struct batadv_priv_vlan {
> > +	unsigned short vid;
> > +	struct kobject *kobj;
> > +	struct list_head list;
> > +	atomic_t refcount;
> > +	struct rcu_head rcu;
> > +};
>=20
> I am not so happy about the choice regarding the name again. The "batadv_=
priv"=20
> prefix has been introduced for bat_priv sub structs. Clearly, this isn't =
one=20
> but an element for a list.=20

ok, I'll change it to softif as stated above.

>=20
>=20
> >  /**
> >   * struct batadv_priv - per mesh interface data
> >   * @mesh_state: current status of the mesh (inactive/active/deactivati=
ng)
> > @@ -573,6 +589,9 @@ struct batadv_priv_nc {
> >   * @primary_if: one of the hard interfaces assigned to this mesh inter=
face
> >   *  becomes the primary interface
> >   * @bat_algo_ops: routing algorithm used by this mesh interface
> > + * @priv_vlan_list: a list of priv_vlan structs, one per VLAN created =
on
> > top of + *  the mesh interface represented by this object
> > + * @priv_vlan_list_lock: lock protecting priv_vlan_list
> >   * @bla: bridge loope avoidance data
> >   * @debug_log: holding debug logging relevant data
> >   * @gw: gateway data
> > @@ -620,6 +639,8 @@ struct batadv_priv {
> >  	struct work_struct cleanup_work;
> >  	struct batadv_hard_iface __rcu *primary_if;  /* rcu protected pointer=
 */
> >  	struct batadv_algo_ops *bat_algo_ops;
> > +	struct list_head priv_vlan_list;
> > +	spinlock_t priv_vlan_list_lock; /* protects priv_vlan_list */
> >  #ifdef CONFIG_BATMAN_ADV_BLA
> >  	struct batadv_priv_bla bla;
> >  #endif
>=20
> This leads to weird code like: bat_priv->priv_vlan_list_lock (priv twice)=
 ..

yeah, softif everywhere! :D

Thanks a lot!

I'll send v3 and I'll include the BLA integration too.

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--451BZW+OUuJBCAYj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRnxDRAAoJEADl0hg6qKeOdSMP/iICaoTr604rY6y9btTkbaWj
iHsYTESJzWyerh50eVrmuCYeomOCtxP5FfjmKuXVnro9LeuWby9gdR5Z33rsicf/
Pk/hN5hJctF/loXK2LonnRW7u6V8RtfU9/OBql99qvBZv+ZbsM/x9ZA4D6LaeHT+
37fiyzPQdT2ZWsdi75X99abhQjPxRXcjFzRENgB3PdGfxJllVc0xeteTozj6QFt3
4mW1WeHv1GiWlullzYEZVrAPQugPmkVytW44rUttqpmLOA1fBYTckpnAwiU3y6bL
6uL4rXMWz1YdgD83hnmbu+Aq4Ndd3nE/pNMCWJ5WnoKBDu46TIxGH4hG04w3HsNq
ZwvqQTYH5oFPEc+rS+05duhQzkPR4kIN3pVM9K/cZIK9NcXs8IVdVY0kIexTQW3C
XVAbGpG/IhTOuMU5nVx/f9bJh7PaH9Fl4A/pO59GKTyMzHf5HG/+TTWjXo17kYra
YqG42J5RoQ3JHelBFnve36Lcm4IZnluxsL3ebxpyE9w4z00RBxXE0/tB5rGFtI2p
B3l/fMMxNldUlOU2dRW/OAryK5VtSsUVprUD+GgMSu1JJpZ83HrHOit65f1AkgEm
YR8FUwy2jWwDxtQ7MDMIGpw92vKK4yZRP6RTPZPfmKo4XMin8fNPIlfcdaCKBryu
lonH9qK0j7DSsjomF10O
=PKRY
-----END PGP SIGNATURE-----

--451BZW+OUuJBCAYj--
