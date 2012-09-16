Return-Path: <ordex@autistici.org>
Date: Sun, 16 Sep 2012 12:12:50 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120916101250.GA7087@ritirata.org>
References: <1347745906-12749-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <1347745906-12749-1-git-send-email-linus.luessing@web.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix symmetry check / route
 flapping in multi interface setups
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


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 15, 2012 at 11:51:46 +0200, Linus L=C3=BCssing wrote:
> If receiving an OGM from a neighbor other than the currently selected
> and if it has the same TQ then we are supposed to switch if this
> neighbor provides a more symmetric link than the currently selected one.
>=20
> However this symmetry check currently is broken if the interface of the
> neighbor we received the OGM from and the one of the currently selected
> neighbor differ: We are currently trying to determine the symmetry of the
> link towards the selected router via the link we received the OGM from
> instead of just checking via the link towards the currently selected
> router.
>=20
> This leads to way more route switches than necessary and can lead to
> permanent route flapping in many common multi interface setups.
>=20
> This patch fixes this issue by using the right interface for this
> symmetry check.
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@web.de>
> ---
> This fixes the route flapping observed in ticket 163 (but unfortunately
> doesn't fix the main issue of this ticket, the starving routes, yet).
>=20
>  bat_iv_ogm.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
> index 7f0adad..2c6b560 100644
> --- a/bat_iv_ogm.c
> +++ b/bat_iv_ogm.c
> @@ -743,7 +743,8 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_pri=
v,
>  	if (router && (neigh_node->tq_avg =3D=3D router->tq_avg)) {
>  		orig_node_tmp =3D router->orig_node;
>  		spin_lock_bh(&orig_node_tmp->ogm_cnt_lock);
> -		sum_orig =3D orig_node_tmp->bcast_own_sum[if_incoming->if_num];
> +		sum_orig =3D orig_node_tmp->
> +				bcast_own_sum[router->if_incoming->if_num];

what about:
	int if_num;
	...
		if_num =3D router->if_incoming->if_num;
		sum_orig =3D orig_node_tmp->bcast_own_sum[if_num];

?

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlBVpiIACgkQpGgxIkP9cwchrgCfQJf4f44K5/aTWtT46kWGCdqX
a9cAnjAV/DV+h513UUJlRE65c1sWo7hm
=+sH5
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
