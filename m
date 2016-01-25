Return-Path: <a@unstable.cc>
Date: Mon, 25 Jan 2016 11:28:53 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160125032853.GA15121@prodigo.lan>
References: <1453312110-32683-1-git-send-email-andrew@lunn.ch>
 <1453312110-32683-3-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1453312110-32683-3-git-send-email-andrew@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/4] batman-adv: Create batman soft
 interfaces within correct netns.
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Wed, Jan 20, 2016 at 06:48:28PM +0100, Andrew Lunn wrote:
>  int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
> -				   const char *iface_name)
> +				   struct net *net, const char *iface_name)

Andrew,
minor style note here: instead of passing the namespace as argument, could we
just invoke dev_net() on hard_iface->net_dev inside
batadv_hardif_enable_interface() ?

>  {
>  	struct batadv_priv *bat_priv;
>  	struct net_device *soft_iface, *master;
> @@ -432,10 +433,10 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
>  	if (!atomic_inc_not_zero(&hard_iface->refcount))
>  		goto out;
>  
> -	soft_iface = dev_get_by_name(&init_net, iface_name);
> +	soft_iface = dev_get_by_name(net, iface_name);
>  
>  	if (!soft_iface) {
> -		soft_iface = batadv_softif_create(iface_name);
> +		soft_iface = batadv_softif_create(net, iface_name);
>  
>  		if (!soft_iface) {
>  			ret = -ENOMEM;


-- 
Antonio Quartulli
