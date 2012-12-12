Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed, 12 Dec 2012 11:41:59 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20121212104159.GA20392@pandem0nium>
References: <1355267105-18479-1-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <1355267105-18479-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: postpone sysfs removal when
	unregistering
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
To: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>, sven@narfation.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch needs rework for two reasons:
 * we still need to defer the softif as well, otherwise we keep the
   deadlock for the softif
 * work struct and delayed_work are mixed up here

I'll post a revised version soon.

Cheers,
	Simon

On Wed, Dec 12, 2012 at 12:05:05AM +0100, Simon Wunderlich wrote:
> When processing the unregister notify for a hard interface, removing
> the sysfs files may lead to a circular deadlock (rtnl mutex <->
> s_active).
>=20
> To overcome this problem, postpone the sysfs removal in a worker.
>=20
> Reported-by: Sasha Levin <sasha.levin@oracle.com>
> Reported-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> ---
> Postponing the sysfs removal for the hardif unregister is easier than
> other alternatives involving deferring. This should bring us to the
> same level to the bridge code, which also messes with sysfs in the
> notifier processing function, and uses rtnl_trylock when called
> from within sysfs.
>=20
> As far as I could understand the net/core code, only the unregister
> case is the critical one, so the original bug should hopefully be
> fixed.
>=20
> Anyway, I might overlook something so I'm sending this as RFC.
> ---
>  hard-interface.c |   18 ++++++++++++++++--
>  types.h          |    1 +
>  2 files changed, 17 insertions(+), 2 deletions(-)
>=20
> diff --git a/hard-interface.c b/hard-interface.c
> index f1d37cd..075cb27 100644
> --- a/hard-interface.c
> +++ b/hard-interface.c
> @@ -506,6 +506,19 @@ out:
>  	return NULL;
>  }
> =20
> +static void batadv_hardif_remove_interface_finish(struct work_struct *wo=
rk)
> +{
> +	struct delayed_work *delayed_work;
> +	struct batadv_hard_iface *hard_iface;
> +
> +	delayed_work =3D container_of(work, struct delayed_work, work);
> +	hard_iface =3D container_of(delayed_work, struct batadv_hard_iface,
> +				  cleanup_work);
> +
> +	batadv_sysfs_del_hardif(&hard_iface->hardif_obj);
> +	batadv_hardif_free_ref(hard_iface);
> +}
> +
>  static void batadv_hardif_remove_interface(struct batadv_hard_iface *har=
d_iface)
>  {
>  	ASSERT_RTNL();
> @@ -518,8 +531,9 @@ static void batadv_hardif_remove_interface(struct bat=
adv_hard_iface *hard_iface)
>  		return;
> =20
>  	hard_iface->if_status =3D BATADV_IF_TO_BE_REMOVED;
> -	batadv_sysfs_del_hardif(&hard_iface->hardif_obj);
> -	batadv_hardif_free_ref(hard_iface);
> +	INIT_DELAYED_WORK(&hard_iface->cleanup_work,
> +			  batadv_hardif_remove_interface_finish);
> +	queue_work(batadv_event_workqueue, &hard_iface->cleanup_work);
>  }
> =20
>  void batadv_hardif_remove_interfaces(void)
> diff --git a/types.h b/types.h
> index 030ce41..6e9746a 100644
> --- a/types.h
> +++ b/types.h
> @@ -63,6 +63,7 @@ struct batadv_hard_iface {
>  	struct net_device *soft_iface;
>  	struct rcu_head rcu;
>  	struct batadv_hard_iface_bat_iv bat_iv;
> +	struct delayed_work cleanup_work;
>  };
> =20
>  /**
> --=20
> 1.7.10.4
>=20
>=20

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlDIX3cACgkQrzg/fFk7axYb8gCg0tADBPxz+FzbA0M1j/2fHnYK
HOcAoJnWn7XknUS8AA5PPCstY1ejbd7s
=8io9
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
