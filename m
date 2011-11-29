Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 29 Nov 2011 14:41:23 +0800
References: <20111129060909.GA6098@elgon.mountain>
In-Reply-To: <20111129060909.GA6098@elgon.mountain>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201111291441.24078.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [patch] batman-adv: remove extra negation in
	gw_out_of_range()
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: netdev@vger.kernel.org, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>, kernel-janitors@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Dan Carpenter <dan.carpenter@oracle.com>

On Tuesday, November 29, 2011 14:09:09 Dan Carpenter wrote:
> There is a typo here where an extra '!' made the check to the opposite
> of what was intended.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/net/batman-adv/gateway_client.c
> b/net/batman-adv/gateway_client.c index 9373a14..24403a7 100644
> --- a/net/batman-adv/gateway_client.c
> +++ b/net/batman-adv/gateway_client.c
> @@ -695,7 +695,7 @@ bool gw_out_of_range(struct bat_priv *bat_priv,
>  	}
> 
>  	neigh_old = find_router(bat_priv, orig_dst_node, NULL);
> -	if (!!neigh_old)
> +	if (!neigh_old)
>  		goto out;
> 
>  	if (curr_tq_avg - neigh_old->tq_avg > GW_THRESHOLD)


Wow - you are right! Applied in our tree.

Thanks,
Marek
