Return-Path: <ordex@autistici.org>
Date: Mon, 26 Nov 2012 01:23:02 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20121126002302.GH14547@ritirata.org>
References: <cover.1353331252.git.martin@hundeboll.net>
 <b5f675c75c4dffa2454e635c19c73f7912eb7e74.1353331252.git.martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Wb5NtZlyOqqy58h0"
Content-Disposition: inline
In-Reply-To: <b5f675c75c4dffa2454e635c19c73f7912eb7e74.1353331252.git.martin@hundeboll.net>
Subject: Re: [B.A.T.M.A.N.] [RFC 1/6] batman-adv: Add the initial code for
 network coding.
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
Cc: Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@hundeboll.net>


--Wb5NtZlyOqqy58h0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 19, 2012 at 02:21:59PM +0100, Martin Hundeb=C3=B8ll wrote:
=2E..

> +/**
> + * batadv_nc_start_timer - initialise the nc periodic worker
> + * @bat_priv: the bat priv with all the soft interface information
> + */
> +static void batadv_nc_start_timer(struct batadv_priv *bat_priv)
> +{
> +	INIT_DELAYED_WORK(&bat_priv->nc.work, batadv_nc_worker);

INIT_DELAYED_WORK is not really needed each and every time. It can be invok=
ed
when setting up the worker for the first time only. It's pure beautificatio=
n in
this case. There is a little performance implication but this does not hurt=
 this
code.

> +	queue_delayed_work(batadv_event_workqueue, &bat_priv->nc.work,
> +			   msecs_to_jiffies(10));
> +}
> +
> +/**
> + * batadv_network_coding_init - initialise coding hash table and start

why not keeping the same namespace everywhere? The previous function name s=
tarts
with batadv_nc_, now you are moving to batadv_network_coding_.

> + *  house keeping
> + * @bat_priv: the bat priv with all the soft interface information
> + */
> +int batadv_network_coding_init(struct batadv_priv *bat_priv)
> +{

I think you could move the INIT_DELAYED_WORK here..

> +	batadv_nc_start_timer(bat_priv);
> +
> +	return 0;
> +}

[...]

> +/**
> + * batadv_nc_worker - periodic task for house keeping related to network=
 coding
> + * @work: kernel work struct
> + */
> +static void batadv_nc_worker(struct work_struct *work)
> +{
> +	struct delayed_work *delayed_work;
> +	struct batadv_priv_nc *priv_nc;
> +	struct batadv_priv *bat_priv;
> +
> +	delayed_work =3D container_of(work, struct delayed_work, work);
> +	priv_nc =3D container_of(delayed_work, struct batadv_priv_nc, work);
> +	bat_priv =3D container_of(priv_nc, struct batadv_priv, nc);
> +
> +	/* Schedule a new check */
> +	batadv_nc_start_timer(bat_priv);
> +}

What's the meaning of this function? It just runs and reset the worker?


> diff --git a/sysfs-class-net-mesh b/sysfs-class-net-mesh
> index bc41da6..c75e594 100644
> --- a/sysfs-class-net-mesh
> +++ b/sysfs-class-net-mesh
> @@ -74,6 +74,14 @@ Description:
>                  Defines the interval in milliseconds in which batman
>                  sends its protocol messages.
> =20
> +What:           /sys/class/net/<mesh_iface>/mesh/network_coding
> +Date:           Nov 2012
> +Contact:        Martin Hundeboll <martin@hundeboll.net>
> +Description:
> +                Controls whether Network Coding (using some magic
> +                to send fewer wifi packets but still the same
> +                content) is enabled or not.
> +

Marek spent a lot of time to sort this list by alphabetical order, make him
happy :)

>  What:           /sys/class/net/<mesh_iface>/mesh/routing_algo
>  Date:           Dec 2011
>  Contact:        Marek Lindner <lindner_marek@yahoo.de>

[...]

> +/**
> + * struct batadv_priv - per mesh interface private data
> + * @network_coding: enable/disable network coding
> + * @batadv_priv_nc: network coding private data
> + */
>  struct batadv_priv {
>  	atomic_t mesh_state;
>  	struct net_device_stats stats;
> @@ -308,6 +321,10 @@ struct batadv_priv {
>  #ifdef CONFIG_BATMAN_ADV_DAT
>  	struct batadv_priv_dat dat;
>  #endif
> +#ifdef CONFIG_BATMAN_ADV_NC
> +	atomic_t network_coding; /* boolean */

just another style note: why don't you put this boolean switch together wit=
h the
others?

> +	struct batadv_priv_nc nc;
> +#endif /* CONFIG_BATMAN_ADV_NC */
>  };
> =20
>  struct batadv_socket_client {
> --=20
> 1.8.0


Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--Wb5NtZlyOqqy58h0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlCytmYACgkQpGgxIkP9cwdbzwCdE6zu8w+SuNQndgUhSc4wApEW
T/4Anibkqaj96awHxRy/DumFzBC2w5a6
=PEFI
-----END PGP SIGNATURE-----

--Wb5NtZlyOqqy58h0--
