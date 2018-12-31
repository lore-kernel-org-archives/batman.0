Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 31 Dec 2018 20:08:19 +0100
Message-ID: <1842705.uoa0R6XjVQ@sven-edge>
In-Reply-To: <20181230165754.GC4150@otheros>
References: <20181207135846.6152-1-sven@narfation.org>
 <20181207135846.6152-2-sven@narfation.org> <20181230165754.GC4150@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2658736.S6grkqtJDO";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC v3 01/19] batman-adv: Move common genl doit
 code pre/post hooks
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2658736.S6grkqtJDO
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sunday, 30 December 2018 17.57.54 CET Linus L=FCssing wrote:
> On Fri, Dec 07, 2018 at 02:58:28PM +0100, Sven Eckelmann wrote:
> > +/**
> > + * batadv_get_softif_from_info() - Retrieve soft interface from genl=20
attributes
> > + * @net: the applicable net namespace
> > + * @info: receiver information
> > + *
> > + * Return: Pointer to soft interface on success, error pointer on error
> > + */
> > +static struct batadv_priv *
> > +batadv_get_softif_from_info(struct net *net, struct genl_info *info)
>=20
> Since this returns a batadv_priv, shouldn't it better be called
> batadv_get_batpriv_from_info() or batadv_get_bat_priv_from_info() maybe?

OK

>=20
> > +{
> > +	struct net_device *soft_iface;
> > +	int ifindex;
> > +
> > +	if (!info->attrs[BATADV_ATTR_MESH_IFINDEX])
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	ifindex =3D nla_get_u32(info->attrs[BATADV_ATTR_MESH_IFINDEX]);
> > +
> > +	soft_iface =3D dev_get_by_index(net, ifindex);
> > +	if (!soft_iface)
> > +		return ERR_PTR(-ENODEV);
> > +
> > +	if (!batadv_softif_is_valid(soft_iface))
> > +		goto err_put_softif;
> > +
> > +	return netdev_priv(soft_iface);
> > +
> > +err_put_softif:
> > +	dev_put(soft_iface);
> > +
> > +	return ERR_PTR(-EINVAL);
> > +}
>=20
> Is holding a reference to bat_priv->soft_iface really
> necessary (and releasing it in batadv_post_doit() )?
> If we are able to retrieve a valid bat_priv then this bat_priv
> itself should hold a reference to to soft_iface, shouldn't it?

No, we don't hold any explicit reference to bat_priv itself. The bat_priv i=
s a=20
part of the memory of the soft_iface. So we most hold a reference for=20
soft_iface because we don't prevent that it is removed in the meantime (the=
=20
netlink interface is registered per module and not per meshif/softif).

[...]
> > +	if (ops->internal_flags & BATADV_FLAG_NEED_MESH) {
> > +		bat_priv =3D batadv_get_softif_from_info(genl_info_net(info),
> > +						       info);
>=20
> Would it look nicer to store genl_info_net(info) in a temporary variable
> so that its shorter and the newline for the second parameter could
> be avoided?

Ok

> > +		if (IS_ERR(bat_priv))
> > +			return PTR_ERR(bat_priv);
> > +
> > +		info->user_ptr[0] =3D bat_priv;
>=20
> Would it make sense to wrap this private data access into
> something somehow? Conceptually similar to what we do not with skb private
> data already for instance. There we use BATADV_SKB_CB() for instance.

Please not, we only have two pointers and I definitely don't want to force=
=20
specific positions (we need three at the moment - but max two per command).=
=20
You should compare it with the nl80211 code.

Kind regards,
	Sven


--nextPart2658736.S6grkqtJDO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlwqaSMACgkQXYcKB8Em
e0ahrRAAgQIMtmEmeogL1KH69H9I6up4WZmGBTVcIK5qavW/pTyOvPSd1qdeliYD
NuE/LcvnPujCyARNz77BLMfBycMQruAX+frZa0NjH5HdRXF1GrPdpR77L/pL27Uh
kxajdVjwgimW5qqMj1ktj+Ub1rxt7iLtPGp6g6VFzi9hdW13+qoMna1HT1pwEeQI
6j5hKe1VKYBNOkOegTx6Aa8KnquZ+TIT15J3RBWLqM5NubYBxHCtURjr48ioHCXI
jeoIDu0MPC4/TJhAFqCrm36PzUTY39VavOnAZI3vms3d0i9ynCgXPLYYUw3XI76U
Jp8Lbzw/FxhMR30bxbmlb2p+f9ldTT83VKH2y0TVj1418P9kgj/SfpV2t1NaAydQ
vSoBJySeSqcPlgbvRvzIUinNi+URXOrO7GkXplctR7acUYpk3rjako7BSnH4Qypo
0nxmhJ70IzTiegYI0VCwi6/QkGNBG4ZyMSgxV2YuqUkhXuskGdl4e5PP2T3rs5e3
eueZbamJntgtGaudYSujF220aWhwO8IXB4PGzq0FApwxEgtrYtRu0DKf6pvrbENS
ZiP4pKbM2XkH/CUYTaMPUkNmhkk6RYZwaVdDz0VY/eFTvi135PFjjQDlmgkU8BGc
PAUEHGiX2l47516/0MCd7Xc8fGVYkmnSa9SxkH96hB3fPtR0K98=
=BXVo
-----END PGP SIGNATURE-----

--nextPart2658736.S6grkqtJDO--



