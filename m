Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Mon, 14 Dec 2009 23:25:12 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20091214222512.GB2155@pandem0nium>
References: <200912101749.11482.sven.eckelmann@gmx.de>
	<1260471043-25687-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Content-Disposition: inline
In-Reply-To: <1260471043-25687-1-git-send-email-sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] [batman-adv] Remove whitespace
	style	errors
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sven,

thank you for your patch, i applied it in svn revision r1494.

On Thu, Dec 10, 2009 at 07:50:43PM +0100, Sven Eckelmann wrote:
> checkpatch.pl found different smaller errors regarding trailing
> whitespaces or trailing extra newlines before EOF. These should be
> removed to follow linux-2.6 CodingStyle.
>=20
> Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
> ---
>  batman-adv-kernelland/CHANGELOG    |    2 +-
>  batman-adv-kernelland/originator.c |    2 --
>  batman-adv-kernelland/originator.h |    1 -
>  batman-adv-kernelland/proc.c       |    2 --
>  batman-adv-kernelland/routing.c    |    1 -
>  batman-adv-kernelland/routing.h    |    6 +++---
>  batman-adv-kernelland/vis.c        |    1 -
>  7 files changed, 4 insertions(+), 11 deletions(-)
>=20
> diff --git a/batman-adv-kernelland/CHANGELOG b/batman-adv-kernelland/CHAN=
GELOG
> index 18d82f5..8a18163 100644
> --- a/batman-adv-kernelland/CHANGELOG
> +++ b/batman-adv-kernelland/CHANGELOG
> @@ -19,7 +19,7 @@ batman-adv 0.1:
>  * support latest kernels (2.6.20 - 2.6.28)
>  * LOTS of cleanup: locking, stack usage, memory leaks
>  * Change Ethertype from 0x0842 to 0x4305
> -  unregistered at IEEE, if you want to sponsor an official Ethertype ($2=
500)=20
> +  unregistered at IEEE, if you want to sponsor an official Ethertype ($2=
500)
>    please contact us
> =20
>   -- Sun, 28 Dec 2008 00:44:31 +0100
> diff --git a/batman-adv-kernelland/originator.c b/batman-adv-kernelland/o=
riginator.c
> index 9962af7..80106f7 100644
> --- a/batman-adv-kernelland/originator.c
> +++ b/batman-adv-kernelland/originator.c
> @@ -239,5 +239,3 @@ void purge_orig(struct work_struct *work)
> =20
>  	start_purge_timer();
>  }
> -
> -
> diff --git a/batman-adv-kernelland/originator.h b/batman-adv-kernelland/o=
riginator.h
> index 6ef7a05..c1a9c2d 100644
> --- a/batman-adv-kernelland/originator.h
> +++ b/batman-adv-kernelland/originator.h
> @@ -28,4 +28,3 @@ struct orig_node *get_orig_node(uint8_t *addr);
>  struct neigh_node *
>  create_neighbor(struct orig_node *orig_node, struct orig_node *orig_neig=
h_node,
>  		uint8_t *neigh, struct batman_if *if_incoming);
> -
> diff --git a/batman-adv-kernelland/proc.c b/batman-adv-kernelland/proc.c
> index ed4c734..f476d9c 100644
> --- a/batman-adv-kernelland/proc.c
> +++ b/batman-adv-kernelland/proc.c
> @@ -827,5 +827,3 @@ int setup_procfs(void)
> =20
>  	return 0;
>  }
> -
> -
> diff --git a/batman-adv-kernelland/routing.c b/batman-adv-kernelland/rout=
ing.c
> index f4be6be..2873468 100644
> --- a/batman-adv-kernelland/routing.c
> +++ b/batman-adv-kernelland/routing.c
> @@ -1063,4 +1063,3 @@ void batman_data_ready(struct sock *sk, int len)
>  	atomic_set(&data_ready_cond, 1);
>  	wake_up_interruptible(&thread_wait);
>  }
> -
> diff --git a/batman-adv-kernelland/routing.h b/batman-adv-kernelland/rout=
ing.h
> index 985728f..890a4f5 100644
> --- a/batman-adv-kernelland/routing.h
> +++ b/batman-adv-kernelland/routing.h
> @@ -27,9 +27,9 @@ extern atomic_t exit_cond;
>  void slide_own_bcast_window(struct batman_if *batman_if);
>  void batman_data_ready(struct sock *sk, int len);
>  int packet_recv_thread(void *data);
> -void receive_bat_packet(struct ethhdr *ethhdr,=20
> -				struct batman_packet *batman_packet,=20
> -				unsigned char *hna_buff, int hna_buff_len,=20
> +void receive_bat_packet(struct ethhdr *ethhdr,
> +				struct batman_packet *batman_packet,
> +				unsigned char *hna_buff, int hna_buff_len,
>  				struct batman_if *if_incoming);
>  void update_routes(struct orig_node *orig_node,
>  				struct neigh_node *neigh_node,
> diff --git a/batman-adv-kernelland/vis.c b/batman-adv-kernelland/vis.c
> index cdb8aab..c26d48c 100644
> --- a/batman-adv-kernelland/vis.c
> +++ b/batman-adv-kernelland/vis.c
> @@ -559,4 +559,3 @@ static void start_vis_timer(void)
>  	queue_delayed_work(bat_event_workqueue, &vis_timer_wq,
>  			   (atomic_read(&vis_interval)/1000) * HZ);
>  }
> -
> --=20
> 1.6.5.4
>=20
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@lists.open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>=20

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAksmu0gACgkQrzg/fFk7axbbRQCggn0Va/LdT5eF7Wl6Wju3FRQy
MEEAoKWin7HiAjhjA7uCXwK891XsRXxO
=LYu4
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--
