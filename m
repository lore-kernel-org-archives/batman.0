Return-Path: <joe@perches.com>
Message-ID: <1358185000.19400.15.camel@joe-AO722>
From: Joe Perches <joe@perches.com>
Date: Mon, 14 Jan 2013 09:36:40 -0800
In-Reply-To: <1358120480-25960-16-git-send-email-ordex@autistici.org>
References: <1358120480-25960-1-git-send-email-ordex@autistici.org>
 <1358120480-25960-16-git-send-email-ordex@autistici.org>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 15/15] batman-adv: unbloat batadv_priv if
 debug is not enabled
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
To: Antonio Quartulli <ordex@autistici.org>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>, davem@davemloft.net

On Mon, 2013-01-14 at 09:41 +1000, Antonio Quartulli wrote:
> diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
[]
> @@ -284,12 +284,16 @@ struct batadv_priv {
>  	atomic_t gw_bandwidth;		/* gw bandwidth */
>  	atomic_t orig_interval;		/* uint */
>  	atomic_t hop_penalty;		/* uint */
> +#ifdef CONFIG_BATMAN_ADV_DEBUG
>  	atomic_t log_level;		/* uint */
> +#endif
>  	atomic_t bcast_seqno;
>  	atomic_t bcast_queue_left;
>  	atomic_t batman_queue_left;
>  	char num_ifaces;
> +#ifdef CONFIG_BATMAN_ADV_DEBUG
>  	struct batadv_debug_log *debug_log;
> +#endif
>  	struct kobject *mesh_obj;
>  	struct dentry *debug_dir;
>  	struct hlist_head forw_bat_list;

How about moving one of these so
there's only one #ifdef block.


