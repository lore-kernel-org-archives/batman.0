Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 30 Mar 2013 23:01:29 +0800
References: <1364654967-25455-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1364654967-25455-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201303302301.29913.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: do not silently ignore wrong
	condition
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

On Saturday, March 30, 2013 22:49:27 Antonio Quartulli wrote:
> @@ -669,7 +669,7 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
>                 if (batadv_compare_eth(neigh_addr, ethhdr->h_source) &&
>                     tmp_neigh_node->if_incoming == if_incoming &&
>                     atomic_inc_not_zero(&tmp_neigh_node->refcount)) {
> -                       if (neigh_node)
> +                       if (WARN(neigh_node, "too many matching
> neigh_nodes") batadv_neigh_node_free_ref(neigh_node); neigh_node =
> tmp_neigh_node;
>                         continue;

I wasn't aware one could throw the warning right in the if-statement but for 
the sake of readability, please don't do that.

Cheers,
Marek
