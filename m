Return-Path: <gmazzurco89@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1304260873-5356-1-git-send-email-lindner_marek@yahoo.de>
References: <1303776426-29019-1-git-send-email-lindner_marek@yahoo.de>
	<1304260873-5356-1-git-send-email-lindner_marek@yahoo.de>
Date: Sun, 1 May 2011 22:09:14 +0200
Message-ID: <BANLkTin7V3sOMDAW9jem9BnjPPfZf4PQdA@mail.gmail.com>
From: Gioacchino Mazzurco <gmazzurco89@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: multi vlan support for
 bridge loop detection
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

very good :D

we need this in Pisa!

2011/5/1 Marek Lindner <lindner_marek@yahoo.de>:
> The bridge loop detection for batman-adv allows the bat0 interface
> to be bridged into an ethernet segment which other batman-adv nodes
> are connected to. In order to also allow multiple VLANs on top of
> the bat0 interface to be bridged into the ethernet segment this
> patch extends the aforementioned bridge loop detection.
>
> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> ---
> Thanks to Sven's review 2 bugs have been squashed:
> =A0* goto out in softif_neigh_free_ref() did not unlock rcu_lock
> =A0* do_select was not initialized after each loop
>
> =A0main.c =A0 =A0 =A0 =A0 =A0 | =A0 =A03 +-
> =A0soft-interface.c | =A0402 ++++++++++++++++++++++++++++++++++++++------=
---------
> =A0types.h =A0 =A0 =A0 =A0 =A0| =A0 19 ++-
> =A03 files changed, 304 insertions(+), 120 deletions(-)
>
> diff --git a/main.c b/main.c
> index 709b33b..705e8be 100644
> --- a/main.c
> +++ b/main.c
> @@ -87,11 +87,12 @@ int mesh_init(struct net_device *soft_iface)
> =A0 =A0 =A0 =A0spin_lock_init(&bat_priv->vis_hash_lock);
> =A0 =A0 =A0 =A0spin_lock_init(&bat_priv->vis_list_lock);
> =A0 =A0 =A0 =A0spin_lock_init(&bat_priv->softif_neigh_lock);
> + =A0 =A0 =A0 spin_lock_init(&bat_priv->softif_neigh_vid_lock);
>
> =A0 =A0 =A0 =A0INIT_HLIST_HEAD(&bat_priv->forw_bat_list);
> =A0 =A0 =A0 =A0INIT_HLIST_HEAD(&bat_priv->forw_bcast_list);
> =A0 =A0 =A0 =A0INIT_HLIST_HEAD(&bat_priv->gw_list);
> - =A0 =A0 =A0 INIT_HLIST_HEAD(&bat_priv->softif_neigh_list);
> + =A0 =A0 =A0 INIT_HLIST_HEAD(&bat_priv->softif_neigh_vids);
>
> =A0 =A0 =A0 =A0if (originator_init(bat_priv) < 1)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err;
> diff --git a/soft-interface.c b/soft-interface.c
> index 1772e2b..7717d62 100644
> --- a/soft-interface.c
> +++ b/soft-interface.c
> @@ -86,99 +86,91 @@ static void softif_neigh_free_ref(struct softif_neigh=
 *softif_neigh)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0call_rcu(&softif_neigh->rcu, softif_neigh_=
free_rcu);
> =A0}
>
> -static struct softif_neigh *softif_neigh_get_selected(struct bat_priv *b=
at_priv)
> +static void softif_neigh_vid_free_rcu(struct rcu_head *rcu)
> =A0{
> - =A0 =A0 =A0 struct softif_neigh *neigh;
> -
> - =A0 =A0 =A0 rcu_read_lock();
> - =A0 =A0 =A0 neigh =3D rcu_dereference(bat_priv->softif_neigh);
> -
> - =A0 =A0 =A0 if (neigh && !atomic_inc_not_zero(&neigh->refcount))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 neigh =3D NULL;
> -
> - =A0 =A0 =A0 rcu_read_unlock();
> - =A0 =A0 =A0 return neigh;
> -}
> -
> -static void softif_neigh_select(struct bat_priv *bat_priv,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct soft=
if_neigh *new_neigh)
> -{
> - =A0 =A0 =A0 struct softif_neigh *curr_neigh;
> -
> - =A0 =A0 =A0 spin_lock_bh(&bat_priv->softif_neigh_lock);
> -
> - =A0 =A0 =A0 if (new_neigh && !atomic_inc_not_zero(&new_neigh->refcount)=
)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 new_neigh =3D NULL;
> -
> - =A0 =A0 =A0 curr_neigh =3D bat_priv->softif_neigh;
> - =A0 =A0 =A0 rcu_assign_pointer(bat_priv->softif_neigh, new_neigh);
> -
> - =A0 =A0 =A0 if (curr_neigh)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 softif_neigh_free_ref(curr_neigh);
> -
> - =A0 =A0 =A0 spin_unlock_bh(&bat_priv->softif_neigh_lock);
> -}
> -
> -static void softif_neigh_deselect(struct bat_priv *bat_priv)
> -{
> - =A0 =A0 =A0 softif_neigh_select(bat_priv, NULL);
> -}
> -
> -void softif_neigh_purge(struct bat_priv *bat_priv)
> -{
> - =A0 =A0 =A0 struct softif_neigh *softif_neigh, *curr_softif_neigh;
> + =A0 =A0 =A0 struct softif_neigh_vid *softif_neigh_vid;
> + =A0 =A0 =A0 struct softif_neigh *softif_neigh;
> =A0 =A0 =A0 =A0struct hlist_node *node, *node_tmp;
> - =A0 =A0 =A0 char do_deselect =3D 0;
> + =A0 =A0 =A0 struct bat_priv *bat_priv;
>
> - =A0 =A0 =A0 curr_softif_neigh =3D softif_neigh_get_selected(bat_priv);
> + =A0 =A0 =A0 softif_neigh_vid =3D container_of(rcu, struct softif_neigh_=
vid, rcu);
> + =A0 =A0 =A0 bat_priv =3D softif_neigh_vid->bat_priv;
>
> =A0 =A0 =A0 =A0spin_lock_bh(&bat_priv->softif_neigh_lock);
> -
> =A0 =A0 =A0 =A0hlist_for_each_entry_safe(softif_neigh, node, node_tmp,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &bat_pr=
iv->softif_neigh_list, list) {
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((!time_after(jiffies, softif_neigh->las=
t_seen +
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msecs_to_ji=
ffies(SOFTIF_NEIGH_TIMEOUT))) &&
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (atomic_read(&bat_priv->mesh_state)=
 =3D=3D MESH_ACTIVE))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (curr_softif_neigh =3D=3D softif_neigh) =
{
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bat_dbg(DBG_ROUTES, bat_pri=
v,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Current=
 mesh exit point '%pM' vanished "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"(vid: %=
d).\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0softif_n=
eigh->addr, softif_neigh->vid);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 do_deselect =3D 1;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> -
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &softif=
_neigh_vid->softif_neigh_list, list) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hlist_del_rcu(&softif_neigh->list);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0softif_neigh_free_ref(softif_neigh);
> =A0 =A0 =A0 =A0}
> -
> =A0 =A0 =A0 =A0spin_unlock_bh(&bat_priv->softif_neigh_lock);
>
> - =A0 =A0 =A0 /* soft_neigh_deselect() needs to acquire the softif_neigh_=
lock */
> - =A0 =A0 =A0 if (do_deselect)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 softif_neigh_deselect(bat_priv);
> + =A0 =A0 =A0 kfree(softif_neigh_vid);
> +}
>
> - =A0 =A0 =A0 if (curr_softif_neigh)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 softif_neigh_free_ref(curr_softif_neigh);
> +static void softif_neigh_vid_free_ref(struct softif_neigh_vid *softif_ne=
igh_vid)
> +{
> + =A0 =A0 =A0 if (atomic_dec_and_test(&softif_neigh_vid->refcount))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 call_rcu(&softif_neigh_vid->rcu, softif_nei=
gh_vid_free_rcu);
> +}
> +
> +static struct softif_neigh_vid *softif_neigh_vid_get(struct bat_priv *ba=
t_priv,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0short vid)
> +{
> + =A0 =A0 =A0 struct softif_neigh_vid *softif_neigh_vid;
> + =A0 =A0 =A0 struct hlist_node *node;
> +
> + =A0 =A0 =A0 rcu_read_lock();
> + =A0 =A0 =A0 hlist_for_each_entry_rcu(softif_neigh_vid, node,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&bat_pri=
v->softif_neigh_vids, list) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (softif_neigh_vid->vid !=3D vid)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!atomic_inc_not_zero(&softif_neigh_vid-=
>refcount))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 softif_neigh_vid =3D kzalloc(sizeof(struct softif_neigh_vid=
),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0GFP_=
ATOMIC);
> + =A0 =A0 =A0 if (!softif_neigh_vid)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> +
> + =A0 =A0 =A0 softif_neigh_vid->vid =3D vid;
> + =A0 =A0 =A0 softif_neigh_vid->bat_priv =3D bat_priv;
> +
> + =A0 =A0 =A0 /* initialize with 2 - caller decrements counter by one */
> + =A0 =A0 =A0 atomic_set(&softif_neigh_vid->refcount, 2);
> + =A0 =A0 =A0 INIT_HLIST_HEAD(&softif_neigh_vid->softif_neigh_list);
> + =A0 =A0 =A0 INIT_HLIST_NODE(&softif_neigh_vid->list);
> + =A0 =A0 =A0 spin_lock_bh(&bat_priv->softif_neigh_vid_lock);
> + =A0 =A0 =A0 hlist_add_head_rcu(&softif_neigh_vid->list,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&bat_priv->softif_ne=
igh_vids);
> + =A0 =A0 =A0 spin_unlock_bh(&bat_priv->softif_neigh_vid_lock);
> +
> +out:
> + =A0 =A0 =A0 rcu_read_unlock();
> + =A0 =A0 =A0 return softif_neigh_vid;
> =A0}
>
> =A0static struct softif_neigh *softif_neigh_get(struct bat_priv *bat_priv=
,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 uint8_t *addr, short vid)
> =A0{
> - =A0 =A0 =A0 struct softif_neigh *softif_neigh;
> + =A0 =A0 =A0 struct softif_neigh_vid *softif_neigh_vid;
> + =A0 =A0 =A0 struct softif_neigh *softif_neigh =3D NULL;
> =A0 =A0 =A0 =A0struct hlist_node *node;
>
> + =A0 =A0 =A0 softif_neigh_vid =3D softif_neigh_vid_get(bat_priv, vid);
> + =A0 =A0 =A0 if (!softif_neigh_vid)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> +
> =A0 =A0 =A0 =A0rcu_read_lock();
> =A0 =A0 =A0 =A0hlist_for_each_entry_rcu(softif_neigh, node,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&bat_pri=
v->softif_neigh_list, list) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&softif_=
neigh_vid->softif_neigh_list,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0list) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!compare_eth(softif_neigh->addr, addr)=
)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (softif_neigh->vid !=3D vid)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> -
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!atomic_inc_not_zero(&softif_neigh->re=
fcount))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
>
> @@ -191,30 +183,153 @@ static struct softif_neigh *softif_neigh_get(struc=
t bat_priv *bat_priv,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
>
> =A0 =A0 =A0 =A0memcpy(softif_neigh->addr, addr, ETH_ALEN);
> - =A0 =A0 =A0 softif_neigh->vid =3D vid;
> =A0 =A0 =A0 =A0softif_neigh->last_seen =3D jiffies;
> =A0 =A0 =A0 =A0/* initialize with 2 - caller decrements counter by one */
> =A0 =A0 =A0 =A0atomic_set(&softif_neigh->refcount, 2);
>
> =A0 =A0 =A0 =A0INIT_HLIST_NODE(&softif_neigh->list);
> =A0 =A0 =A0 =A0spin_lock_bh(&bat_priv->softif_neigh_lock);
> - =A0 =A0 =A0 hlist_add_head_rcu(&softif_neigh->list, &bat_priv->softif_n=
eigh_list);
> + =A0 =A0 =A0 hlist_add_head_rcu(&softif_neigh->list,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&softif_neigh_vid->s=
oftif_neigh_list);
> =A0 =A0 =A0 =A0spin_unlock_bh(&bat_priv->softif_neigh_lock);
>
> =A0out:
> =A0 =A0 =A0 =A0rcu_read_unlock();
> + =A0 =A0 =A0 if (softif_neigh_vid)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 softif_neigh_vid_free_ref(softif_neigh_vid)=
;
> =A0 =A0 =A0 =A0return softif_neigh;
> =A0}
>
> +static struct softif_neigh *softif_neigh_get_selected(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct soft=
if_neigh_vid *softif_neigh_vid)
> +{
> + =A0 =A0 =A0 struct softif_neigh *softif_neigh;
> +
> + =A0 =A0 =A0 rcu_read_lock();
> + =A0 =A0 =A0 softif_neigh =3D rcu_dereference(softif_neigh_vid->softif_n=
eigh);
> +
> + =A0 =A0 =A0 if (softif_neigh && !atomic_inc_not_zero(&softif_neigh->ref=
count))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 softif_neigh =3D NULL;
> +
> + =A0 =A0 =A0 rcu_read_unlock();
> + =A0 =A0 =A0 return softif_neigh;
> +}
> +
> +static struct softif_neigh *softif_neigh_vid_get_selected(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 struct bat_priv *bat_priv,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 short vid)
> +{
> + =A0 =A0 =A0 struct softif_neigh_vid *softif_neigh_vid;
> + =A0 =A0 =A0 struct softif_neigh *softif_neigh =3D NULL;
> +
> + =A0 =A0 =A0 softif_neigh_vid =3D softif_neigh_vid_get(bat_priv, vid);
> + =A0 =A0 =A0 if (!softif_neigh_vid)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> +
> + =A0 =A0 =A0 softif_neigh =3D softif_neigh_get_selected(softif_neigh_vid=
);
> +out:
> + =A0 =A0 =A0 if (softif_neigh_vid)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 softif_neigh_vid_free_ref(softif_neigh_vid)=
;
> + =A0 =A0 =A0 return softif_neigh;
> +}
> +
> +static void softif_neigh_vid_select(struct bat_priv *bat_priv,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 str=
uct softif_neigh *new_neigh,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sho=
rt vid)
> +{
> + =A0 =A0 =A0 struct softif_neigh_vid *softif_neigh_vid;
> + =A0 =A0 =A0 struct softif_neigh *curr_neigh;
> +
> + =A0 =A0 =A0 softif_neigh_vid =3D softif_neigh_vid_get(bat_priv, vid);
> + =A0 =A0 =A0 if (!softif_neigh_vid)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> +
> + =A0 =A0 =A0 spin_lock_bh(&bat_priv->softif_neigh_lock);
> +
> + =A0 =A0 =A0 if (new_neigh && !atomic_inc_not_zero(&new_neigh->refcount)=
)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 new_neigh =3D NULL;
> +
> + =A0 =A0 =A0 curr_neigh =3D softif_neigh_vid->softif_neigh;
> + =A0 =A0 =A0 rcu_assign_pointer(softif_neigh_vid->softif_neigh, new_neig=
h);
> +
> + =A0 =A0 =A0 if ((curr_neigh) && (!new_neigh))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bat_dbg(DBG_ROUTES, bat_priv,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Removing mesh exit point o=
n vid: %d (prev: %pM).\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vid, curr_neigh->addr);
> + =A0 =A0 =A0 else if ((curr_neigh) && (new_neigh))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bat_dbg(DBG_ROUTES, bat_priv,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Changing mesh exit point o=
n vid: %d from %pM "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "to %pM.\n", vid, curr_neig=
h->addr, new_neigh->addr);
> + =A0 =A0 =A0 else if ((!curr_neigh) && (new_neigh))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bat_dbg(DBG_ROUTES, bat_priv,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Setting mesh exit point on=
 vid: %d to %pM.\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vid, new_neigh->addr);
> +
> + =A0 =A0 =A0 if (curr_neigh)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 softif_neigh_free_ref(curr_neigh);
> +
> + =A0 =A0 =A0 spin_unlock_bh(&bat_priv->softif_neigh_lock);
> +
> +out:
> + =A0 =A0 =A0 if (softif_neigh_vid)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 softif_neigh_vid_free_ref(softif_neigh_vid)=
;
> +}
> +
> +static void softif_neigh_vid_deselect(struct bat_priv *bat_priv,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 struct softif_neigh_vid *softif_neigh_vid)
> +{
> + =A0 =A0 =A0 struct softif_neigh *curr_neigh;
> + =A0 =A0 =A0 struct softif_neigh *softif_neigh =3D NULL, *softif_neigh_t=
mp;
> + =A0 =A0 =A0 struct hard_iface *primary_if =3D NULL;
> + =A0 =A0 =A0 struct hlist_node *node;
> +
> + =A0 =A0 =A0 primary_if =3D primary_if_get_selected(bat_priv);
> + =A0 =A0 =A0 if (!primary_if)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> +
> + =A0 =A0 =A0 /* find new softif_neigh immediately to avoid temporary loo=
ps */
> + =A0 =A0 =A0 rcu_read_lock();
> + =A0 =A0 =A0 curr_neigh =3D rcu_dereference(softif_neigh_vid->softif_nei=
gh);
> +
> + =A0 =A0 =A0 hlist_for_each_entry_rcu(softif_neigh_tmp, node,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&softif_=
neigh_vid->softif_neigh_list,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0list) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (softif_neigh_tmp =3D=3D curr_neigh)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* we got a neighbor but its mac is 'bigger=
' than ours =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (memcmp(primary_if->net_dev->dev_addr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0softif_neigh_tmp->ad=
dr, ETH_ALEN) < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!atomic_inc_not_zero(&softif_neigh_tmp-=
>refcount))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 softif_neigh =3D softif_neigh_tmp;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto unlock;
> + =A0 =A0 =A0 }
> +
> +unlock:
> + =A0 =A0 =A0 rcu_read_unlock();
> +out:
> + =A0 =A0 =A0 softif_neigh_vid_select(bat_priv, softif_neigh, softif_neig=
h_vid->vid);
> +
> + =A0 =A0 =A0 if (primary_if)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hardif_free_ref(primary_if);
> + =A0 =A0 =A0 if (softif_neigh)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 softif_neigh_free_ref(softif_neigh);
> +}
> +
> =A0int softif_neigh_seq_print_text(struct seq_file *seq, void *offset)
> =A0{
> =A0 =A0 =A0 =A0struct net_device *net_dev =3D (struct net_device *)seq->p=
rivate;
> =A0 =A0 =A0 =A0struct bat_priv *bat_priv =3D netdev_priv(net_dev);
> + =A0 =A0 =A0 struct softif_neigh_vid *softif_neigh_vid;
> =A0 =A0 =A0 =A0struct softif_neigh *softif_neigh;
> =A0 =A0 =A0 =A0struct hard_iface *primary_if;
> - =A0 =A0 =A0 struct hlist_node *node;
> + =A0 =A0 =A0 struct hlist_node *node, *node_tmp;
> =A0 =A0 =A0 =A0struct softif_neigh *curr_softif_neigh;
> - =A0 =A0 =A0 int ret =3D 0;
> + =A0 =A0 =A0 int ret =3D 0, last_seen_secs, last_seen_msecs;
>
> =A0 =A0 =A0 =A0primary_if =3D primary_if_get_selected(bat_priv);
> =A0 =A0 =A0 =A0if (!primary_if) {
> @@ -233,17 +348,33 @@ int softif_neigh_seq_print_text(struct seq_file *se=
q, void *offset)
>
> =A0 =A0 =A0 =A0seq_printf(seq, "Softif neighbor list (%s)\n", net_dev->na=
me);
>
> - =A0 =A0 =A0 curr_softif_neigh =3D softif_neigh_get_selected(bat_priv);
> =A0 =A0 =A0 =A0rcu_read_lock();
> - =A0 =A0 =A0 hlist_for_each_entry_rcu(softif_neigh, node,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&bat_pri=
v->softif_neigh_list, list)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(seq, "%s %pM (vid: %d)\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 curr_softif=
_neigh =3D=3D softif_neigh
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ? "=3D>" : =
" =A0", softif_neigh->addr,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 softif_neig=
h->vid);
> + =A0 =A0 =A0 hlist_for_each_entry_rcu(softif_neigh_vid, node,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&bat_pri=
v->softif_neigh_vids, list) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(seq, " =A0 =A0 %-15s %s on vid: =
%d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Originator", "last-=
seen", softif_neigh_vid->vid);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 curr_softif_neigh =3D softif_neigh_get_sele=
cted(softif_neigh_vid);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hlist_for_each_entry_rcu(softif_neigh, node=
_tmp,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0&softif_neigh_vid->softif_neigh_list,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0list) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 last_seen_secs =3D jiffies_=
to_msecs(jiffies -
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 softif_neigh->last_seen) / 1000;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 last_seen_msecs =3D jiffies=
_to_msecs(jiffies -
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 softif_neigh->last_seen) % 1000;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(seq, "%s %pM =A0=
%3i.%03is\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0curr=
_softif_neigh =3D=3D softif_neigh
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0? "=
=3D>" : " =A0", softif_neigh->addr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0last=
_seen_secs, last_seen_msecs);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (curr_softif_neigh)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 softif_neigh_free_ref(curr_=
softif_neigh);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(seq, "\n");
> + =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0rcu_read_unlock();
> - =A0 =A0 =A0 if (curr_softif_neigh)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 softif_neigh_free_ref(curr_softif_neigh);
>
> =A0out:
> =A0 =A0 =A0 =A0if (primary_if)
> @@ -251,6 +382,70 @@ out:
> =A0 =A0 =A0 =A0return ret;
> =A0}
>
> +void softif_neigh_purge(struct bat_priv *bat_priv)
> +{
> + =A0 =A0 =A0 struct softif_neigh *softif_neigh, *curr_softif_neigh;
> + =A0 =A0 =A0 struct softif_neigh_vid *softif_neigh_vid;
> + =A0 =A0 =A0 struct hlist_node *node, *node_tmp, *node_tmp2;
> + =A0 =A0 =A0 char do_deselect;
> +
> + =A0 =A0 =A0 rcu_read_lock();
> + =A0 =A0 =A0 hlist_for_each_entry_rcu(softif_neigh_vid, node,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&bat_pri=
v->softif_neigh_vids, list) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!atomic_inc_not_zero(&softif_neigh_vid-=
>refcount))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 curr_softif_neigh =3D softif_neigh_get_sele=
cted(softif_neigh_vid);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 do_deselect =3D 0;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_bh(&bat_priv->softif_neigh_lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hlist_for_each_entry_safe(softif_neigh, nod=
e_tmp, node_tmp2,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 &softif_neigh_vid->softif_neigh_list,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 list) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((!time_after(jiffies, s=
oftif_neigh->last_seen +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msecs_to_ji=
ffies(SOFTIF_NEIGH_TIMEOUT))) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (atomic_read(&bat_p=
riv->mesh_state) =3D=3D MESH_ACTIVE))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (curr_softif_neigh =3D=
=3D softif_neigh) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bat_dbg(DBG=
_ROUTES, bat_priv,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 "Current mesh exit point on vid: %d "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 "'%pM' vanished.\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 softif_neigh_vid->vid,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 softif_neigh->addr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 do_deselect=
 =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hlist_del_rcu(&softif_neigh=
->list);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 softif_neigh_free_ref(softi=
f_neigh);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_bh(&bat_priv->softif_neigh_lock=
);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* soft_neigh_vid_deselect() needs to acqui=
re the
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* softif_neigh_lock */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (do_deselect)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 softif_neigh_vid_deselect(b=
at_priv, softif_neigh_vid);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (curr_softif_neigh)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 softif_neigh_free_ref(curr_=
softif_neigh);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 softif_neigh_vid_free_ref(softif_neigh_vid)=
;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 rcu_read_unlock();
> +
> + =A0 =A0 =A0 spin_lock_bh(&bat_priv->softif_neigh_vid_lock);
> + =A0 =A0 =A0 hlist_for_each_entry_safe(softif_neigh_vid, node, node_tmp,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &bat_pr=
iv->softif_neigh_vids, list) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!hlist_empty(&softif_neigh_vid->softif_=
neigh_list))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hlist_del_rcu(&softif_neigh_vid->list);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 softif_neigh_vid_free_ref(softif_neigh_vid)=
;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 spin_unlock_bh(&bat_priv->softif_neigh_vid_lock);
> +
> +}
> +
> =A0static void softif_batman_recv(struct sk_buff *skb, struct net_device =
*dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 short vid)
> =A0{
> @@ -283,10 +478,7 @@ static void softif_batman_recv(struct sk_buff *skb, =
struct net_device *dev,
> =A0 =A0 =A0 =A0if (!softif_neigh)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
>
> - =A0 =A0 =A0 curr_softif_neigh =3D softif_neigh_get_selected(bat_priv);
> - =A0 =A0 =A0 if (!curr_softif_neigh)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> -
> + =A0 =A0 =A0 curr_softif_neigh =3D softif_neigh_vid_get_selected(bat_pri=
v, vid);
> =A0 =A0 =A0 =A0if (curr_softif_neigh =3D=3D softif_neigh)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
>
> @@ -299,33 +491,16 @@ static void softif_batman_recv(struct sk_buff *skb,=
 struct net_device *dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 softif_neigh->addr, ETH_ALEN) < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
>
> - =A0 =A0 =A0 /* switch to new 'smallest neighbor' */
> - =A0 =A0 =A0 if ((curr_softif_neigh) &&
> - =A0 =A0 =A0 =A0 =A0 (memcmp(softif_neigh->addr, curr_softif_neigh->addr=
,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ETH_ALEN) < 0)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bat_dbg(DBG_ROUTES, bat_priv,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Changing mesh exit point f=
rom %pM (vid: %d) "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "to %pM (vid: %d).\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0curr_softif_neigh->addr,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0curr_softif_neigh->vid,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0softif_neigh->addr, soft=
if_neigh->vid);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 softif_neigh_select(bat_priv, softif_neigh)=
;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> - =A0 =A0 =A0 }
> -
> =A0 =A0 =A0 =A0/* close own batX device and use softif_neigh as exit node=
 */
> - =A0 =A0 =A0 if ((!curr_softif_neigh) &&
> - =A0 =A0 =A0 =A0 =A0 (memcmp(softif_neigh->addr,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 primary_if->net_dev->dev_addr, ETH_=
ALEN) < 0)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bat_dbg(DBG_ROUTES, bat_priv,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Setting mesh exit point to=
 %pM (vid: %d).\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 softif_neigh->addr, softif_=
neigh->vid);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 softif_neigh_select(bat_priv, softif_neigh)=
;
> + =A0 =A0 =A0 if (!curr_softif_neigh) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 softif_neigh_vid_select(bat_priv, softif_ne=
igh, vid);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 /* switch to new 'smallest neighbor' */
> + =A0 =A0 =A0 if (memcmp(softif_neigh->addr, curr_softif_neigh->addr, ETH=
_ALEN) < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 softif_neigh_vid_select(bat_priv, softif_ne=
igh, vid);
> +
> =A0out:
> =A0 =A0 =A0 =A0kfree_skb(skb);
> =A0 =A0 =A0 =A0if (softif_neigh)
> @@ -420,8 +595,8 @@ int interface_tx(struct sk_buff *skb, struct net_devi=
ce *soft_iface)
> =A0 =A0 =A0 =A0 * if we have a another chosen mesh exit node in range
> =A0 =A0 =A0 =A0 * it will transport the packets to the mesh
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 curr_softif_neigh =3D softif_neigh_get_selected(bat_priv);
> - =A0 =A0 =A0 if ((curr_softif_neigh) && (curr_softif_neigh->vid =3D=3D v=
id))
> + =A0 =A0 =A0 curr_softif_neigh =3D softif_neigh_vid_get_selected(bat_pri=
v, vid);
> + =A0 =A0 =A0 if (curr_softif_neigh)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto dropped;
>
> =A0 =A0 =A0 =A0/* TODO: check this for locks */
> @@ -529,8 +704,8 @@ void interface_rx(struct net_device *soft_iface,
> =A0 =A0 =A0 =A0 * if we have a another chosen mesh exit node in range
> =A0 =A0 =A0 =A0 * it will transport the packets to the non-mesh network
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 curr_softif_neigh =3D softif_neigh_get_selected(bat_priv);
> - =A0 =A0 =A0 if (curr_softif_neigh && (curr_softif_neigh->vid =3D=3D vid=
)) {
> + =A0 =A0 =A0 curr_softif_neigh =3D softif_neigh_vid_get_selected(bat_pri=
v, vid);
> + =A0 =A0 =A0 if (curr_softif_neigh) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0skb_push(skb, hdr_size);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unicast_packet =3D (struct unicast_packet =
*)skb->data;
>
> @@ -667,7 +842,6 @@ struct net_device *softif_create(char *name)
>
> =A0 =A0 =A0 =A0bat_priv->primary_if =3D NULL;
> =A0 =A0 =A0 =A0bat_priv->num_ifaces =3D 0;
> - =A0 =A0 =A0 bat_priv->softif_neigh =3D NULL;
>
> =A0 =A0 =A0 =A0ret =3D sysfs_add_meshif(soft_iface);
> =A0 =A0 =A0 =A0if (ret < 0)
> diff --git a/types.h b/types.h
> index 947bafc..9ae507a 100644
> --- a/types.h
> +++ b/types.h
> @@ -146,14 +146,13 @@ struct bat_priv {
> =A0 =A0 =A0 =A0atomic_t bcast_queue_left;
> =A0 =A0 =A0 =A0atomic_t batman_queue_left;
> =A0 =A0 =A0 =A0char num_ifaces;
> - =A0 =A0 =A0 struct hlist_head softif_neigh_list;
> - =A0 =A0 =A0 struct softif_neigh __rcu *softif_neigh;
> =A0 =A0 =A0 =A0struct debug_log *debug_log;
> =A0 =A0 =A0 =A0struct kobject *mesh_obj;
> =A0 =A0 =A0 =A0struct dentry *debug_dir;
> =A0 =A0 =A0 =A0struct hlist_head forw_bat_list;
> =A0 =A0 =A0 =A0struct hlist_head forw_bcast_list;
> =A0 =A0 =A0 =A0struct hlist_head gw_list;
> + =A0 =A0 =A0 struct hlist_head softif_neigh_vids;
> =A0 =A0 =A0 =A0struct list_head vis_send_list;
> =A0 =A0 =A0 =A0struct hashtable_t *orig_hash;
> =A0 =A0 =A0 =A0struct hashtable_t *hna_local_hash;
> @@ -167,6 +166,7 @@ struct bat_priv {
> =A0 =A0 =A0 =A0spinlock_t vis_hash_lock; /* protects vis_hash */
> =A0 =A0 =A0 =A0spinlock_t vis_list_lock; /* protects vis_info::recv_list =
*/
> =A0 =A0 =A0 =A0spinlock_t softif_neigh_lock; /* protects soft-interface n=
eigh list */
> + =A0 =A0 =A0 spinlock_t softif_neigh_vid_lock; /* protects soft-interfac=
e vid list */
> =A0 =A0 =A0 =A0int16_t num_local_hna;
> =A0 =A0 =A0 =A0atomic_t hna_local_changed;
> =A0 =A0 =A0 =A0struct delayed_work hna_work;
> @@ -270,12 +270,21 @@ struct recvlist_node {
> =A0 =A0 =A0 =A0uint8_t mac[ETH_ALEN];
> =A0};
>
> -struct softif_neigh {
> +struct softif_neigh_vid {
> =A0 =A0 =A0 =A0struct hlist_node list;
> - =A0 =A0 =A0 uint8_t addr[ETH_ALEN];
> - =A0 =A0 =A0 unsigned long last_seen;
> + =A0 =A0 =A0 struct bat_priv *bat_priv;
> =A0 =A0 =A0 =A0short vid;
> =A0 =A0 =A0 =A0atomic_t refcount;
> + =A0 =A0 =A0 struct softif_neigh __rcu *softif_neigh;
> + =A0 =A0 =A0 struct rcu_head rcu;
> + =A0 =A0 =A0 struct hlist_head softif_neigh_list;
> +};
> +
> +struct softif_neigh {
> + =A0 =A0 =A0 struct hlist_node list;
> + =A0 =A0 =A0 uint8_t addr[ETH_ALEN];
> + =A0 =A0 =A0 unsigned long last_seen;
> + =A0 =A0 =A0 atomic_t refcount;
> =A0 =A0 =A0 =A0struct rcu_head rcu;
> =A0};
>
> --
> 1.7.2.3
>
>
