Return-Path: <kuba@kernel.org>
Date: Tue, 19 Oct 2021 12:06:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH] batman-adv: use eth_hw_addr_set() instead of
 ether_addr_copy()
Message-ID: 
 <20211019120654.6dee21b5@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20211019163927.1386289-1-kuba@kernel.org>
References: <20211019163927.1386289-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: sven@narfation.org
Cc: netdev@vger.kernel.org, mareklindner@neomailbox.ch, b.a.t.m.a.n@lists.open-mesh.org, a@unstable.cc, sw@simonwunderlich.de

On Tue, 19 Oct 2021 09:39:27 -0700 Jakub Kicinski wrote:
> Commit 406f42fa0d3c ("net-next: When a bond have a massive amount
> of VLANs...") introduced a rbtree for faster Ethernet address look
> up. To maintain netdev->dev_addr in this tree we need to make all
> the writes to it got through appropriate helpers.
> 
> Convert batman from ether_addr_copy() to eth_hw_addr_set():
> 
>   @@
>   expression dev, np;
>   @@
>   - ether_addr_copy(dev->dev_addr, np)
>   + eth_hw_addr_set(dev, np)
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Extending CC list.

> diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
> index 0604b0279573..7ee09337fc40 100644
> --- a/net/batman-adv/soft-interface.c
> +++ b/net/batman-adv/soft-interface.c
> @@ -134,7 +134,7 @@ static int batadv_interface_set_mac_addr(struct net_device *dev, void *p)
>  		return -EADDRNOTAVAIL;
>  
>  	ether_addr_copy(old_addr, dev->dev_addr);
> -	ether_addr_copy(dev->dev_addr, addr->sa_data);
> +	eth_hw_addr_set(dev, addr->sa_data);
>  
>  	/* only modify transtable if it has been initialized before */
>  	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)

