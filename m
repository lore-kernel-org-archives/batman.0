Return-Path: <ordex@autistici.org>
Date: Thu, 30 Aug 2012 13:46:55 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120830114655.GC29563@ritirata.org>
References: <1346057631-2382-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="OBd5C1Lgu00Gd/Tn"
Content-Disposition: inline
In-Reply-To: <1346057631-2382-1-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Write lockdep xmit class
 in late initialization phase
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


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 27, 2012 at 10:53:50AM +0200, Sven Eckelmann wrote:
> e27bb6fa916451e9eaced16e7c21d5b71a3b7f30 ("batman-adv: Set special lockdep
> classes to avoid lockdep warning") introduced a lockdep class for the tx =
queue,
> but did not set it in the correct initialization phase. The batman-adv sp=
ecific
> lock class could be replaced by a later netdevice registration phase.
>=20
> Reported-by: Antonio Quartulli <ordex@autistici.org>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Tested-by: Antonio Quartulli <ordex@autistici.org>


This solves the problem reported in bug #162! Thank you Sven!

> ---
>  soft-interface.c |   35 ++++++++++++++++++++++++-----------
>  1 file changed, 24 insertions(+), 11 deletions(-)
>=20
> diff --git a/soft-interface.c b/soft-interface.c
> index a584f62..72d8767 100644
> --- a/soft-interface.c
> +++ b/soft-interface.c
> @@ -352,16 +352,6 @@ out:
>  	return;
>  }
> =20
> -static const struct net_device_ops batadv_netdev_ops =3D {
> -	.ndo_open =3D batadv_interface_open,
> -	.ndo_stop =3D batadv_interface_release,
> -	.ndo_get_stats =3D batadv_interface_stats,
> -	.ndo_set_mac_address =3D batadv_interface_set_mac_addr,
> -	.ndo_change_mtu =3D batadv_interface_change_mtu,
> -	.ndo_start_xmit =3D batadv_interface_tx,
> -	.ndo_validate_addr =3D eth_validate_addr
> -};
> -
>  /* batman-adv network devices have devices nesting below it and are a sp=
ecial
>   * "super class" of normal network devices; split their locks off into a
>   * separate class since they always nest.
> @@ -382,6 +372,30 @@ static void batadv_set_lockdep_class(struct net_devi=
ce *dev)
>  	netdev_for_each_tx_queue(dev, batadv_set_lockdep_class_one, NULL);
>  }
> =20
> +/**
> + * batadv_softif_init - Late stage initialization of soft interface
> + * @dev: registered network device to modify
> + *
> + * Returns error code on failures
> + */
> +static int batadv_softif_init(struct net_device *dev)
> +{
> +	batadv_set_lockdep_class(dev);
> +
> +	return 0;
> +}
> +
> +static const struct net_device_ops batadv_netdev_ops =3D {
> +	.ndo_init =3D batadv_softif_init,
> +	.ndo_open =3D batadv_interface_open,
> +	.ndo_stop =3D batadv_interface_release,
> +	.ndo_get_stats =3D batadv_interface_stats,
> +	.ndo_set_mac_address =3D batadv_interface_set_mac_addr,
> +	.ndo_change_mtu =3D batadv_interface_change_mtu,
> +	.ndo_start_xmit =3D batadv_interface_tx,
> +	.ndo_validate_addr =3D eth_validate_addr
> +};
> +
>  static void batadv_interface_setup(struct net_device *dev)
>  {
>  	struct batadv_priv *priv =3D netdev_priv(dev);
> @@ -391,7 +405,6 @@ static void batadv_interface_setup(struct net_device =
*dev)
>  	dev->netdev_ops =3D &batadv_netdev_ops;
>  	dev->destructor =3D free_netdev;
>  	dev->tx_queue_len =3D 0;
> -	batadv_set_lockdep_class(dev);
> =20
>  	/* can't call min_mtu, because the needed variables
>  	 * have not been initialized yet
> --=20
> 1.7.10.4

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--OBd5C1Lgu00Gd/Tn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlA/Uq8ACgkQpGgxIkP9cweQgQCfQxDucors97HMpR17DKZdI543
nKwAn0SoX4NLyQ2MWb50GvrL3702zjRG
=Rg5z
-----END PGP SIGNATURE-----

--OBd5C1Lgu00Gd/Tn--
