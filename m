Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 26 Aug 2013 09:44:17 +0800
References: <1376376232-2178-1-git-send-email-ordex@autistici.org>
 <1376376232-2178-5-git-send-email-ordex@autistici.org>
In-Reply-To: <1376376232-2178-5-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201308260944.17336.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 4/9] batman-adv: add bat_metric_get API
	function
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

On Tuesday, August 13, 2013 14:43:47 Antonio Quartulli wrote:
> +static uint32_t batadv_iv_ogm_metric_get(struct batadv_neigh_node
> *neigh_node) +{
> +	if (!neigh_node)
> +		return 0;
> +
> +	return neigh_node->bat_iv.tq_avg;
> +}

Kernel doc ?


> diff --git a/types.h b/types.h
> index 0141261..2b5b1c1 100644
> --- a/types.h
> +++ b/types.h
> @@ -1002,6 +1002,7 @@ struct batadv_algo_ops {
>  	void (*bat_primary_iface_set)(struct batadv_hard_iface *hard_iface);
>  	void (*bat_ogm_schedule)(struct batadv_hard_iface *hard_iface);
>  	void (*bat_ogm_emit)(struct batadv_forw_packet *forw_packet);
> +	uint32_t (*bat_metric_get)(struct batadv_neigh_node *neigh_node);
>  	/* orig_node handling API */
>  	void (*bat_orig_print)(struct batadv_priv *priv, struct seq_file *seq);
>  };

Kernel doc ?

Cheers,
Marek
