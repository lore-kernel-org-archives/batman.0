Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sat, 4 Sep 2010 13:51:18 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20100904115118.GA7416@pandem0nium>
References: <1283425748-17603-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: <1283425748-17603-1-git-send-email-sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Revert
	"Adding	netfilter-bridge hooks"
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


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

committed in r1782,

Thanks
	Simon

On Thu, Sep 02, 2010 at 01:09:08PM +0200, Sven Eckelmann wrote:
> The netfilter hook seems to be misused and may not filter everything as
> expected. Also the ethernet bridge tables are not yet capable to
> understand batman-adv packet correctly.
>=20
> It was only added for testing purposes and can be removed again.
>=20
> Reported-by: Vasiliy Kulikov <segooon@gmail.com>
> Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
> ---
> I got the information that Linus Luessing acked that change and will
> provide that patch for testing purposes somewhere else.
>=20
> I prefer to get it reverted because it also made the patch
> "batman-adv: register the batman-adv packet type per interface"
> useless.
>=20
>  batman-adv/hard-interface.c |   72 +++++++++++++++++++------------------=
------
>  batman-adv/send.c           |    8 +---
>  2 files changed, 34 insertions(+), 46 deletions(-)
>=20
> diff --git a/batman-adv/hard-interface.c b/batman-adv/hard-interface.c
> index 063d34d..edbfddf 100644
> --- a/batman-adv/hard-interface.c
> +++ b/batman-adv/hard-interface.c
> @@ -30,7 +30,6 @@
>  #include "hash.h"
> =20
>  #include <linux/if_arp.h>
> -#include <linux/netfilter_bridge.h>
> =20
>  #include "compat.h"
> =20
> @@ -495,29 +494,46 @@ out:
>  	return NOTIFY_DONE;
>  }
> =20
> -static int batman_skb_recv_finish(struct sk_buff *skb)
> +/* receive a packet with the batman ethertype coming on a hard
> + * interface */
> +int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
> +	struct packet_type *ptype, struct net_device *orig_dev)
>  {
> +	struct bat_priv *bat_priv;
>  	struct batman_packet *batman_packet;
>  	struct batman_if *batman_if;
> -	struct bat_priv *bat_priv;
>  	int ret;
> =20
> -	batman_if =3D get_batman_if_by_netdev(skb->dev);
> -	if (!batman_if)
> +	batman_if =3D container_of(ptype, struct batman_if, batman_adv_ptype);
> +	skb =3D skb_share_check(skb, GFP_ATOMIC);
> +
> +	/* skb was released by skb_share_check() */
> +	if (!skb)
> +		goto err_out;
> +
> +	/* packet should hold at least type and version */
> +	if (unlikely(!pskb_may_pull(skb, 2)))
> +		goto err_free;
> +
> +	/* expect a valid ethernet header here. */
> +	if (unlikely(skb->mac_len !=3D sizeof(struct ethhdr)
> +				|| !skb_mac_header(skb)))
>  		goto err_free;
> =20
>  	if (!batman_if->soft_iface)
>  		goto err_free;
> =20
> +	bat_priv =3D netdev_priv(batman_if->soft_iface);
> +
> +	if (atomic_read(&bat_priv->mesh_state) !=3D MESH_ACTIVE)
> +		goto err_free;
> +
>  	/* discard frames on not active interfaces */
>  	if (batman_if->if_status !=3D IF_ACTIVE)
>  		goto err_free;
> =20
> -	bat_priv =3D netdev_priv(batman_if->soft_iface);
> -	if (atomic_read(&bat_priv->mesh_state) !=3D MESH_ACTIVE)
> -		goto err_free;
> -
>  	batman_packet =3D (struct batman_packet *)skb->data;
> +
>  	if (batman_packet->version !=3D COMPAT_VERSION) {
>  		bat_dbg(DBG_BATMAN, bat_priv,
>  			"Drop packet: incompatible batman version (%i)\n",
> @@ -563,42 +579,18 @@ static int batman_skb_recv_finish(struct sk_buff *s=
kb)
>  	}
> =20
>  	if (ret =3D=3D NET_RX_DROP)
> -		goto err_free;
> +		kfree_skb(skb);
> =20
> -	return 0;
> +	/* return NET_RX_SUCCESS in any case as we
> +	 * most probably dropped the packet for
> +	 * routing-logical reasons. */
> =20
> -err_free:
> -	kfree_skb(skb);
> -	return 0;
> -}
> -
> -/* receive a packet with the batman ethertype coming on a hard
> - * interface */
> -int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
> -	struct packet_type *ptype, struct net_device *orig_dev)
> -{
> -	skb =3D skb_share_check(skb, GFP_ATOMIC);
> -
> -	/* skb was released by skb_share_check() */
> -	if (!skb)
> -		return 0;
> -
> -	/* packet should hold at least type and version */
> -	if (unlikely(!pskb_may_pull(skb, 2)))
> -		goto err_free;
> -
> -	/* expect a valid ethernet header here. */
> -	if (unlikely(skb->mac_len !=3D sizeof(struct ethhdr) ||
> -	    !skb_mac_header(skb)))
> -		goto err_free;
> +	return NET_RX_SUCCESS;
> =20
> -	/* if netfilter/ebtables wants to block incoming batman
> -	 * packets then give them a chance to do so here */
> -	return NF_HOOK(PF_BRIDGE, NF_BR_LOCAL_IN, skb, dev,
> -		       NULL, batman_skb_recv_finish);
>  err_free:
>  	kfree_skb(skb);
> -	return 0;
> +err_out:
> +	return NET_RX_DROP;
>  }
> =20
>  struct notifier_block hard_if_notifier =3D {
> diff --git a/batman-adv/send.c b/batman-adv/send.c
> index 283c6bb..92eb421 100644
> --- a/batman-adv/send.c
> +++ b/batman-adv/send.c
> @@ -29,7 +29,6 @@
>  #include "vis.h"
>  #include "aggregation.h"
>  #include "gateway_common.h"
> -#include <linux/netfilter_bridge.h>
> =20
>  #include "compat.h"
> =20
> @@ -94,12 +93,9 @@ int send_skb_packet(struct sk_buff *skb,
> =20
>  	/* dev_queue_xmit() returns a negative result on error.	 However on
>  	 * congestion and traffic shaping, it drops and returns NET_XMIT_DROP
> -	 * (which is > 0). This will not be treated as an error.
> -	 * Also, if netfilter/ebtables wants to block outgoing batman
> -	 * packets then giving them a chance to do so here */
> +	 * (which is > 0). This will not be treated as an error. */
> =20
> -	return NF_HOOK(PF_BRIDGE, NF_BR_LOCAL_OUT, skb, NULL, skb->dev,
> -		       dev_queue_xmit);
> +	return dev_queue_xmit(skb);
>  send_skb_err:
>  	kfree_skb(skb);
>  	return NET_XMIT_DROP;
> --=20
> 1.7.1
>=20
>=20

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkyCMrYACgkQrzg/fFk7axZ6WwCfapJK6v8WoXQA2UcAPLlg+Ftk
2N0AoJoSqpPUBsr2hZKEeIxt6lRv/BIm
=+n62
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
