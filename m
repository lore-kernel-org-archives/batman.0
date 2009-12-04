Return-Path: <gwirth79@gmail.com>
Message-ID: <4B194EDE.2070703@gmail.com>
Date: Fri, 04 Dec 2009 10:03:10 -0800
From: Gus Wirth <gwirth79@gmail.com>
MIME-Version: 1.0
References: <20091204101245.GB32517@lunn.ch>
In-Reply-To: <20091204101245.GB32517@lunn.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [patch] batman-adv: Use printk(%pM) for MAC
	addresses
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.net

On 12/04/2009 02:12 AM, Andrew Lunn wrote:
> printk() since kernel version 2.6.29 has supported printing MAC
> addresses directly, as an extension to the %p processing. This patch
> makes use of this for printk() and bat_dbg(). This will remove the
> overhead of using addr_to_string() which is normally never actually
> output.
>
> For kernels older than 2.6.29 the printk support from 2.6.31 has been
> imported into batman-adv and will be used for formatting the output
> before passing it onto the native printk() function.

[snip]

> Index: routing.c
> ===================================================================
> --- routing.c	(revision 1490)
> +++ routing.c	(working copy)
> @@ -79,32 +79,24 @@
>   			 struct neigh_node *neigh_node,
>   			 unsigned char *hna_buff, int hna_buff_len)
>   {
> -	char orig_str[ETH_STR_LEN], neigh_str[ETH_STR_LEN];
> -	char router_str[ETH_STR_LEN];
> -
> -	addr_to_string(orig_str, orig_node->orig);
> -
>   	/* route deleted */
>   	if ((orig_node->router != NULL)&&  (neigh_node == NULL)) {
>
> -		bat_dbg(DBG_ROUTES, "Deleting route towards: %s\n",
> -			orig_str);
> +		bat_dbg(DBG_ROUTES, "Deleting route towards: %pMs\n",
> +			orig_node->orig);

There is an extra "s" after the the replacement %pM.

Gus
