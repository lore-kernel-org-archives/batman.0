Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 16 Mar 2013 19:10:18 +0800
References: <65e1eabaa1dae3e9003482b35ae1d012939ab07b.1363385881.git.mschiffer@universe-factory.net>
 <01f2a6ce4ab512c60760ce0275100750c5cd59bc.1363431558.git.mschiffer@universe-factory.net>
In-Reply-To: <01f2a6ce4ab512c60760ce0275100750c5cd59bc.1363431558.git.mschiffer@universe-factory.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201303161910.18263.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: fix compat for Debian
	Wheezy kernel v3.2.39
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

On Saturday, March 16, 2013 18:59:55 Matthias Schiffer wrote:
> @@ -174,10 +174,7 @@ static inline void skb_reset_mac_len(struct sk_buff
> *skb) 
>  #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 4, 0)
>  
> -static inline void eth_hw_addr_random(struct net_device *dev)
> -{
> -       random_ether_addr(dev->dev_addr);
> -}
> +#define eth_hw_addr_random(dev) random_ether_addr((dev)->dev_addr)
>  
>  #endif /* < KERNEL_VERSION(3, 4, 0) */

How about re-defining the function name and keep the static inline ? There are 
numerous examples of this in the compat.h file, for instance 
batadv_this_cpu_add().

We also might want a comment there that we do this for Debian compat. 

Cheers,
Marek
