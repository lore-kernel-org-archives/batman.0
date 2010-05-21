Return-Path: <ordex@ritirata.org>
Date: Fri, 21 May 2010 10:21:28 +0200
From: Antonio Quartulli <ordex@ritirata.org>
Message-ID: <20100521082127.GA7802@ritirata.org>
References: <20100517072041.GA23674@ritirata.org>
	<1274232349-10414-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1274232349-10414-1-git-send-email-linus.luessing@web.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Adding netfilter-bridge hooks
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

Hi all,

On Wed, May 19, 2010 at 03:25:49AM +0200, Linus L=FCssing wrote:
> batman-adv is receiving and sending the packets of its own ether type
> on a very early/low level. Therefore we need to add explicit hooks to
> give netfilter/ebtables a chance to filter them.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@web.de>
> Reported-by: Antonio Quartulli <ordex@ritirata.org>
> ---
>  batman-adv-kernelland/hard-interface.c |   17 +++++++++++++++--
>  batman-adv-kernelland/send.c           |    8 ++++++--
>  2 files changed, 21 insertions(+), 4 deletions(-)
>=20
> diff --git a/batman-adv-kernelland/hard-interface.c b/batman-adv-kernella=
nd/hard-interface.c
> index cc7fbae..6a64930 100644
> --- a/batman-adv-kernelland/hard-interface.c
> +++ b/batman-adv-kernelland/hard-interface.c
> @@ -28,9 +28,11 @@
>  #include "bat_sysfs.h"
>  #include "originator.h"
>  #include "hash.h"
> -#include "compat.h"
> =20
>  #include <linux/if_arp.h>
> +#include <linux/netfilter_bridge.h>
> +
> +#include "compat.h"
> =20
>  #define MIN(x, y) ((x) < (y) ? (x) : (y))
> =20
> @@ -433,6 +435,11 @@ out:
>  	return NOTIFY_DONE;
>  }
> =20
> +int batman_skb_recv_finish(struct sk_buff *skb)
> +{
> +	return NF_ACCEPT;
> +}
> +
>  /* receive a packet with the batman ethertype coming on a hard
>   * interface */
>  int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
> @@ -452,6 +459,13 @@ int batman_skb_recv(struct sk_buff *skb, struct net_=
device *dev,
>  	if (atomic_read(&module_state) !=3D MODULE_ACTIVE)
>  		goto err_free;
> =20
> +	/* if netfilter/ebtables wants to block incoming batman
> +	 * packets then give them a chance to do so here */
> +	ret =3D NF_HOOK(PF_BRIDGE, NF_BR_LOCAL_IN, skb, dev, NULL,
> +		      batman_skb_recv_finish);
> +	if (ret !=3D 1)
> +		goto err_out;
> +
>  	/* packet should hold at least type and version */
>  	if (unlikely(skb_headlen(skb) < 2))
>  		goto err_free;
> @@ -531,7 +545,6 @@ err_out:
>  	return NET_RX_DROP;
>  }
> =20
> -
>  struct notifier_block hard_if_notifier =3D {
>  	.notifier_call =3D hard_if_event,
>  };
> diff --git a/batman-adv-kernelland/send.c b/batman-adv-kernelland/send.c
> index 99d11fe..b0d3627 100644
> --- a/batman-adv-kernelland/send.c
> +++ b/batman-adv-kernelland/send.c
> @@ -29,6 +29,7 @@
>  #include "vis.h"
>  #include "aggregation.h"
>  #include "gateway_common.h"
> +#include <linux/netfilter_bridge.h>
> =20
>  #include "compat.h"
> =20
> @@ -93,9 +94,12 @@ int send_skb_packet(struct sk_buff *skb,
> =20
>  	/* dev_queue_xmit() returns a negative result on error.	 However on
>  	 * congestion and traffic shaping, it drops and returns NET_XMIT_DROP
> -	 * (which is > 0). This will not be treated as an error. */
> +	 * (which is > 0). This will not be treated as an error.
> +	 * Also, if netfilter/ebtables wants to block outgoing batman
> +	 * packets then giving them a chance to do so here */
> =20
> -	return dev_queue_xmit(skb);
> +	return NF_HOOK(PF_BRIDGE, NF_BR_LOCAL_OUT, skb, NULL, skb->dev,
> +		       dev_queue_xmit);
>  send_skb_err:
>  	kfree_skb(skb);
>  	return NET_XMIT_DROP;
> --=20
> 1.5.6.5

I gave a try to this patch, but I see something strange.
After enabling a simple ebtables rule:
ebtables -A INPUT -s MAC -j DROP
and
ebtables -A FORWARD -s MAC -j DROP (to be sure..)

I saw that batman ping was timing out, while the "originator list" (shown
with batctl o) is still filled with the other node entry...

I did something wrong?

Regards


--=20
Antonio Quartulli

Ognuno di noi, da solo, non vale nulla=20
Ernesto "Che" Guevara
