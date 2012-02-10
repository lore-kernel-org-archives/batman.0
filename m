Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 10 Feb 2012 22:32:00 +0800
References: <1328830902-11574-1-git-send-email-ordex@autistici.org>
	<1328830902-11574-8-git-send-email-ordex@autistici.org>
In-Reply-To: <1328830902-11574-8-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201202102232.01329.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv5 7/9] batman-adv: Distributed ARP Table
	- add compile option
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

On Friday, February 10, 2012 07:41:40 Antonio Quartulli wrote:
> @@ -23,6 +23,8 @@
>  export CONFIG_BATMAN_ADV_DEBUG=n
>  # B.A.T.M.A.N. bridge loop avoidance:
>  export CONFIG_BATMAN_ADV_BLA=y
> +# B.A.T.M.A.N. distributed ARP table:
> +export CONFIG_BATMAN_ADV_DAT=n

Any particular reason why you wish to disable it by default ?

> --- a/distributed-arp-table.c
> +++ b/distributed-arp-table.c
> @@ -30,10 +30,13 @@
>  #include "hard-interface.h"
>  #include "originator.h"
>  #include "send.h"
> +#include "soft-interface.h"
>  #include "types.h"
>  #include "translation-table.h"
>  #include "unicast.h"

Why changing an include in this patch ?


> --- a/distributed-arp-table.h
> +++ b/distributed-arp-table.h
> @@ -22,9 +22,12 @@
>  #ifndef _NET_BATMAN_ADV_ARP_H_
>  #define _NET_BATMAN_ADV_ARP_H_
> 
> +#ifdef CONFIG_BATMAN_ADV_DAT
> +
>  #include "main.h"
> 
>  #include <linux/if_arp.h>
> +#include <linux/netdevice.h>

Another include change ?


> --- a/hard-interface.c
> +++ b/hard-interface.c
> @@ -119,9 +119,11 @@ static void primary_if_update_addr(struct bat_priv
> *bat_priv, if (!primary_if)
>  		goto out;
> 
> +#ifdef CONFIG_BATMAN_ADV_DAT
>  	bat_priv->dht_hash = (dat_addr_t)
>  				choose_orig(primary_if->net_dev->dev_addr,
>  					    DAT_ADDR_MAX);
> +#endif

A general dat_init()/dat_free() structure would be better than adding defines 
everywhere.


> --- a/send.c
> +++ b/send.c
> @@ -30,8 +30,6 @@
>  #include "gateway_common.h"
>  #include "originator.h"
> 
> -#include <net/arp.h>
> -
>  static void send_outstanding_bcast_packet(struct work_struct *work);

More changing includes ..

The README update is missing in this patch.

Cheers,
Marek
