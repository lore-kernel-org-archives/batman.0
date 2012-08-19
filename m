Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sun, 19 Aug 2012 09:57:48 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20120819075748.GA7547@pandem0nium>
References: <1345361393-8759-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <1345361393-8759-1-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: Set special lockdep classes to
 avoid lockdep warning
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


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Sven,

it works in my QEMU machines (and I could reproduce the bug report from 162=
).

Acked-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
(provided you add some sane commit message. ;] )


Cheers,
	Simon


On Sun, Aug 19, 2012 at 09:29:53AM +0200, Sven Eckelmann wrote:
> [text will be added after I am awake... maybe]
>=20
> [Should be fix the problem found in bug 162... formerly known as 161. code
> stolen from macvlan... this is just a reimplementation of a solution prop=
osed
> by Simon Wunderlich]
>=20
> Reported-by: Linus L=C3=BCssing <linus.luessing@web.de>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  soft-interface.c |   29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>=20
> diff --git a/soft-interface.c b/soft-interface.c
> index 1aee7db..588c6f6 100644
> --- a/soft-interface.c
> +++ b/soft-interface.c
> @@ -344,7 +344,36 @@ out:
>  	return;
>  }
> =20
> +/*
> + * batman-adv network devices have devices nesting below it and are a sp=
ecial
> + * "super class" of normal network devices; split their locks off into a
> + * separate class since they always nest.
> + */
> +static struct lock_class_key batadv_netdev_xmit_lock_key;
> +static struct lock_class_key batadv_netdev_addr_lock_key;
> +
> +static void batadv_set_lockdep_class_one(struct net_device *dev,
> +					 struct netdev_queue *txq,
> +					 void *_unused)
> +{
> +	lockdep_set_class(&txq->_xmit_lock, &batadv_netdev_xmit_lock_key);
> +}
> +
> +static void batadv_set_lockdep_class(struct net_device *dev)
> +{
> +	lockdep_set_class(&dev->addr_list_lock, &batadv_netdev_addr_lock_key);
> +	netdev_for_each_tx_queue(dev, batadv_set_lockdep_class_one, NULL);
> +}
> +
> +static int batadv_softif_init(struct net_device *dev)
> +{
> +	batadv_set_lockdep_class(dev);
> +
> +	return 0;
> +}
> +
>  static const struct net_device_ops batadv_netdev_ops =3D {
> +	.ndo_init =3D batadv_softif_init,
>  	.ndo_open =3D batadv_interface_open,
>  	.ndo_stop =3D batadv_interface_release,
>  	.ndo_get_stats =3D batadv_interface_stats,
> --=20
> 1.7.10.4
>=20
>=20

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlAwnHwACgkQrzg/fFk7axbYngCbB26CXkHNBkuHTCvndnX8JycP
RucAnjUOKBRUUWU5iE+I4I1r5H54T1Q1
=KD4F
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
