Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 21 May 2018 17:01:14 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20180521150114.GP7162@otheros>
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
> diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
> index 0a9bee88..148f23ad 100644
> --- a/net/batman-adv/types.h
> +++ b/net/batman-adv/types.h
> @@ -583,6 +583,20 @@ struct batadv_hardif_neigh_node_bat_v {
>  
>  	/** @metric_work: work queue callback item for metric update */
>  	struct work_struct metric_work;
> +
> +	/**
> +	 * @tp_meter_running: tp meter measurements towards this neighbor in
> +	 * progress
> +	 */
> +	unsigned char tp_meter_running:1;

I'm currently wondering: Would it make sense to prevent parallel
tp meter execution not only to a specific neighbor but parallel
executions on a hard-interface in general?
