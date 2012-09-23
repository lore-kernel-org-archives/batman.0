Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 23 Sep 2012 17:15:28 +0800
References: <20120916101250.GA7087@ritirata.org>
 <1347930068-7045-1-git-send-email-linus.luessing@web.de>
In-Reply-To: <1347930068-7045-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201209231715.28695.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: Fix symmetry check / route
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

On Tuesday, September 18, 2012 09:01:08 Linus L=C3=BCssing wrote:
> @@ -743,7 +744,8 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_pri=
v,
>         if (router && (neigh_node->tq_avg =3D=3D router->tq_avg)) {
>                 orig_node_tmp =3D router->orig_node;
>                 spin_lock_bh(&orig_node_tmp->ogm_cnt_lock);
> -               sum_orig =3D
> orig_node_tmp->bcast_own_sum[if_incoming->if_num]; +               if_num
> =3D router->if_incoming->if_num;
> +               sum_orig =3D orig_node_tmp->bcast_own_sum[if_num];
>                 spin_unlock_bh(&orig_node_tmp->ogm_cnt_lock);
> =20
>                 orig_node_tmp =3D neigh_node->orig_node;

Good catch! May I suggest another modifcation to make this section easier t=
o=20
understand ? It won't change any behavior it just makes it easier to see wh=
ere=20
if_num is coming from.

Cheers,
Marek
