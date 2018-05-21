Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 21 May 2018 16:48:55 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20180521144854.GO7162@otheros>
References: <20180518014754.23644-1-mareklindner@neomailbox.ch>
 <20180518014754.23644-7-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180518014754.23644-7-mareklindner@neomailbox.ch>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 6/7] batman-adv: ELP - use tp meter to
 estimate the throughput if otherwise not available
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

On Fri, May 18, 2018 at 09:47:53AM +0800, Marek Lindner wrote:
> +/**
> + * batadv_v_elp_tp_start() - start a tp meter session for a neighbor
> + * @neigh: neighbor to run tp meter on
> + */
> +static void batadv_v_elp_tp_start(struct batadv_hardif_neigh_node *neigh)
> +{
> +	struct batadv_hard_iface *hard_iface = neigh->if_incoming;
> +	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
> +
> +	neigh->bat_v.tp_meter_running = true;
> +	batadv_tp_start(bat_priv, neigh->addr, neigh, 10, NULL, BATADV_TP_ELP);
> +}

This seems racy here? We have no ordering constraints between
the assigment and batadv_tp_start() which might lead to...

> @@ -152,6 +192,25 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
>  			return throughput * 10;
>  	}
>  
> +fallback_throughput:
> +	last_tp_run_jiffies = jiffies - neigh->bat_v.last_tp_meter_run;
> +	last_tp_run_msecs = jiffies_to_msecs(last_tp_run_jiffies);
> +
> +	/* check the tp_meter_running flag before checking the timestamp to
> +	 * avoid a race condition where a new tp meter session is scheduled
> +	 * right after the previous tp meter session has completed
> +	 */
> +	if (!neigh->bat_v.tp_meter_running &&
> +	    last_tp_run_msecs > BATADV_ELP_TP_RUN_INTERVAL)
> +		batadv_v_elp_tp_start(neigh);

...multiple instances potentially being started at the same time here?
