Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 26 Aug 2013 11:29:18 +0800
References: <1376376232-2178-1-git-send-email-ordex@autistici.org>
 <1376376232-2178-8-git-send-email-ordex@autistici.org>
In-Reply-To: <1376376232-2178-8-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201308261129.18352.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 7/9] batman-adv: adapt the neighbor
	purging routine to use the new API functions
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

On Tuesday, August 13, 2013 14:43:50 Antonio Quartulli wrote:
> --- a/originator.c
> +++ b/originator.c
> @@ -380,6 +380,8 @@ batadv_purge_orig_neighbors(struct batadv_priv
> *bat_priv, bool neigh_purged = false;
>         unsigned long last_seen;
>         struct batadv_hard_iface *if_incoming;
> +       struct batadv_algo_ops *bao = bat_priv->bat_algo_ops;
> +       uint32_t neigh_metric, best_metric = UINT_MAX;

Albeit being not wrong I'd rather initialize best_metric with zero. It was 
confusing when reading the first time.

Cheers,
Marek
