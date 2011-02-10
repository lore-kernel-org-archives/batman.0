Return-Path: <linus.luessing@web.de>
Date: Thu, 10 Feb 2011 14:03:03 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20110210130303.GD13038@Sellars>
References: <201102091918.42080.lindner_marek@yahoo.de>
	<1297275550-12420-2-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1297275550-12420-2-git-send-email-lindner_marek@yahoo.de>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: remove extra layer
 between hash and hash element - hash bucket
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

> diff --git a/batman-adv/compat.h b/batman-adv/compat.h
> index a76d0be..29a3203 100644
> --- a/batman-adv/compat.h
> +++ b/batman-adv/compat.h
> @@ -270,4 +270,12 @@ int bat_seq_printf(struct seq_file *m, const char *f, ...);
>  
>  #endif /* < KERNEL_VERSION(2, 6, 33) */
>  
> +#define hlist_first_rcu(head) (*((struct hlist_node **)(&(head)->first)))
> +#define hlist_next_rcu(node) (*((struct hlist_node **)(&(node)->next)))
> +
> +#define __hlist_for_each_rcu(pos, head) \
> +	for (pos = rcu_dereference(hlist_first_rcu(head)); \
> +	pos && ({ prefetch(pos->next); 1; }); \
> +	pos = rcu_dereference(hlist_next_rcu(pos)))
> +
>  #endif /* _NET_BATMAN_ADV_COMPAT_H_ */
Isn't there a #define with < KERNEL_VERSION(2, 6, 37) missing?
(Haven't checked much else about this patch yet)

Cheers, Linus
