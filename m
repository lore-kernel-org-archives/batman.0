Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 04 Jan 2019 08:52:22 +0100
Message-ID: <9046472.zWXYbWcy6o@sven-edge>
In-Reply-To: <20190104003954.GD21623@otheros>
References: <20181207135846.6152-1-sven@narfation.org>
 <20181207135846.6152-4-sven@narfation.org> <20190104003954.GD21623@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4484960.KpLy6tMDOY";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC v3 03/19] batman-adv: Prepare framework for
 hardif genl config
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

--nextPart4484960.KpLy6tMDOY
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Friday, 4 January 2019 01.39.54 CET Linus L=FCssing wrote:
> On Fri, Dec 07, 2018 at 02:58:30PM +0100, Sven Eckelmann wrote:
> [...]
> > +/**
> > + * batadv_get_hardif_from_info() - Retrieve hardif from genl attributes
> > + * @bat_priv: the bat priv with all the soft interface information
> > + * @net: the applicable net namespace
> > + * @info: receiver information
> > + *
> > + * Return: Pointer to hard interface on success, error pointer on error
> > + */
> > +static struct batadv_hard_iface *
> > +batadv_get_hardif_from_info(struct batadv_priv *bat_priv, struct net=20
*net,
> > +			    struct genl_info *info)
> > +{
> > +	struct batadv_hard_iface *hard_iface;
> > +	struct net_device *hard_dev;
> > +	unsigned int hardif_index;
> > +
> > +	if (!info->attrs[BATADV_ATTR_HARD_IFINDEX])
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	hardif_index =3D nla_get_u32(info->attrs[BATADV_ATTR_HARD_IFINDEX]);
> > +
> > +	hard_dev =3D dev_get_by_index(net, hardif_index);
> > +	if (!hard_dev)
> > +		return ERR_PTR(-ENODEV);
> > +
> > +	hard_iface =3D batadv_hardif_get_by_netdev(hard_dev);
> > +	if (!hard_iface)
> > +		goto err_put_harddev;
> > +
> > +	if (hard_iface->soft_iface !=3D bat_priv->soft_iface)
> > +		goto err_put_hardif;
>=20
> When would this case above happen?


When you ask for a hard interface from a different mesh interface or a hard=
=20
interface without a mesh interface.


> It seems unnecessary to keep holding a reference to hard_dev on
> successful return here (and releasing it in post_doit).
[...]

Ok.

> often with these net_device reference counters...) Same for
> batadv_get_softif_from_info().

No, no, no, no, no, no, no and again no. The net_device is the only thing w=
ith=20
a refcounter here. The bat_priv doesn't have a refcounter because it is jus=
t a=20
memory region in the net_device.

Kind regards,
	Sven
--nextPart4484960.KpLy6tMDOY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlwvELYACgkQXYcKB8Em
e0YFzg/+PItNrsWfLp5n0ONQuQ1Zyle7cO/mH+8qD8Tm9f+DHuJiORXOzCtYP6ef
nOh+ejENnYLfXD1IeY5d06kv/knijy6l6TpfoUuBPfo61oms3w4CzC+wQz2q0rVB
DKouvZdEhW/41vl7ncf6a8DaZvdrgGBJTbRPevliR4raTuSZN+wyDgBMsAgBEyZ6
LEKrliPvWreyadHh3v9df+xY9mgy1hr4Ws5siPeM481xa33BxMX69GKe1yUw3vTY
T3sfVs+t0MtqowkDDwmno4/uMejhLtRo3UcaEyA4eZ6Cmt2rAAnRE18DCW9VB7Rm
T2NJDQRThNMDYiCsM9iBOtF0aeqMkGxP0fXkwZDU1/zWOVhrPY6NcxLZ2EUIOOXb
LJc0S8wyL9nnNs19sMFyFUg9l6EliBOG/vp+4VdTS8lzRI2c7ooK6lBdMxIyi33v
UV3Uc3KHdAcBsXMDejvjURG/nNLtC+JUmrWRF//hGnoRRDtEFsjxsvklIV63KJEx
KzhO663aTe1PkemCW3mxYiJvkgnpky+eFqoPkK34T0ivmAGNDW0qkH4+JmDSU+/d
p7tnL3fqG/XBwnuZ5JJpwXLAnVXKQdvjMdW3urnHZQ9e09RzIbBiOhj3sFUfGQfm
NTyCmVWi19QsOCom6mXUQUUjw7vtG06/PBIkHAQhtRI7MJARhzc=
=9pIX
-----END PGP SIGNATURE-----

--nextPart4484960.KpLy6tMDOY--



