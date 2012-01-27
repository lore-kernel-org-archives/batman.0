Return-Path: <andrew@lunn.ch>
Date: Fri, 27 Jan 2012 16:19:14 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20120127151914.GB19664@lunn.ch>
References: <1327677116-22645-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1327677116-22645-1-git-send-email-lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: encourage batman to take
 shorter routes by changing the default hop penalty
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

On Fri, Jan 27, 2012 at 11:11:55PM +0800, Marek Lindner wrote:
> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> ---
>  soft-interface.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/soft-interface.c b/soft-interface.c
> index 2ffdc74..7548762 100644
> --- a/soft-interface.c
> +++ b/soft-interface.c
> @@ -836,7 +836,7 @@ struct net_device *softif_create(const char *name)
>  	atomic_set(&bat_priv->gw_sel_class, 20);
>  	atomic_set(&bat_priv->gw_bandwidth, 41);
>  	atomic_set(&bat_priv->orig_interval, 1000);
> -	atomic_set(&bat_priv->hop_penalty, 10);
> +	atomic_set(&bat_priv->hop_penalty, 30);

Hi Marek

Do you have any performance analysis to show this is really helpful
and not harmful?

I've seen indoor results where i had to reduce the hop penalty,
otherwise BATMAN was taking a short path which worked badly. By
reducing the hop penalty, so encouraging it to take more hops, i got
usable routes.

I see the danger here this could break working networks, so maybe it
needs justification?

Thanks
	Andrew
