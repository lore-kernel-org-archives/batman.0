Return-Path: <linus.luessing@web.de>
MIME-Version: 1.0
Message-ID: <trinity-97d57b03-203f-4915-9bec-fcae5d01e618-1363490537768@3capp-webde-bs08>
From: =?UTF-8?Q?=22Linus_L=C3=BCssing=22?= <linus.luessing@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 Mar 2013 04:22:17 +0100 (CET)
In-Reply-To: <1363487457-5413-1-git-send-email-linus.luessing@web.de>
References: <1363487457-5413-1-git-send-email-linus.luessing@web.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix general protection fault
 in batadv_tt_global_del_orig()
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
To: =?UTF-8?Q?=22Linus_L=C3=BCssing=22?= <linus.luessing@web.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

Hrm, forget it, this patch isn't sufficient...

batadv_nc_free() is schedul=
ing batadv_orig_node_free_rcu()s, too. And actually, batadv_tt_free() itsel=
f does so, too, before it frees its global TT hash... which can backfire af=
ter the global TT hash freeing...

Ok, a more invasive patch to properly fi=
x this issue is needed.

> Gesendet: Sonntag, 17. M=C3=A4rz 2013 um 03:30 U=
hr
> Von: "Linus L=C3=BCssing" <linus.luessing@web.de>
> An: b.a.t.m.a.n@li=
sts.open-mesh.org
> Cc: "Linus L=C3=BCssing" <linus.luessing@web.de>
> Betr=
eff: [PATCH] batman-adv: Fix general protection fault in batadv_tt_global_d=
el_orig()
>
> On shutdown a race condition where we access a just freed glo=
bal TT hash
> might occure:
>
> batadv_mesh_free()->batadv_originator_free(=
) schedules the
> batadv_orig_node_free_rcu().
>
> Before batadv_orig_node_=
free_rcu() is executed (which happens on the
> rcu_barrier() call in batadv=
_exit() the latest),
> batadv_mesh_free()->batadv_tt_free()->batadv_tt_glob=
al_table_free()->
> batadv_hash_destroy(hash)->kfree(hash)
> is called, fre=
eing the global tt hash.
>
> When batadv_orig_node_free_rcu()->batadv_tt_gl=
obal_del_orig() now gets
> executed it tries to access this just freed glob=
al tt hash, causing a
> kernel panic.
>
> This patch tries to fix this by w=
aiting for any just scheduled
> batadv_orig_node_free_rcu() to finish via a=
n extra rcu_barrier() call
> before freeing the global TT hash.
>
> Signed-=
off-by: Linus L=C3=BCssing <linus.luessing@web.de>
> ---
> Ref: #169
>
>  m=
ain.c |    5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/main=
.c b/main.c
> index 62b1f89..0afc171 100644
> --- a/main.c
> +++ b/main.c
>=
 @@ -164,6 +164,11 @@ void batadv_mesh_free(struct net_device *soft_iface)
=
>
>  	batadv_gw_node_purge(bat_priv);
>  	batadv_originator_free(bat_priv);=

> +
> +	/* Wait for any batadv_orig_node_free_rcu() to finish,
> +	 * they=
 access the soon to be freed global TT hash */
> +	rcu_barrier();
> +
>  	b=
atadv_nc_free(bat_priv);
>
>  	batadv_tt_free(bat_priv);
> --
> 1.7.10.4
>
=
>
