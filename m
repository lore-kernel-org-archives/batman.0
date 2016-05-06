Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 06 May 2016 11:53:06 +0200
Message-ID: <2070567.oGaoHu8Rmk@sven-edge>
In-Reply-To: <1462525107-19750-3-git-send-email-apape@phoenixcontact.com>
References: <1462525107-19750-1-git-send-email-apape@phoenixcontact.com>
 <1462525107-19750-3-git-send-email-apape@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1726607.ftnllYezOn";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 2/6] batman-adv: speed up dat by
	snooping received ip traffic
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart1726607.ftnllYezOn
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 06 May 2016 10:58:23 Andreas Pape wrote:
> diff --git a/net/batman-adv/soft-interface.c
> b/net/batman-adv/soft-interface.c index 81665b1..1f1742a 100644
> --- a/net/batman-adv/soft-interface.c
> +++ b/net/batman-adv/soft-interface.c
> @@ -28,6 +28,7 @@
>  #include <linux/fs.h>
>  #include <linux/if_ether.h>
>  #include <linux/if_vlan.h>
> +#include <linux/ip.h>
>  #include <linux/jiffies.h>
>  #include <linux/kernel.h>
>  #include <linux/kref.h>

Haven't really looked at your patchset but was just interested in this new 
function. But I didn't came to look at it because I saw this weird include. 
Doesn't seem to make sense here at all when you look at the rest of the 
changes in this file:

> @@ -442,6 +443,9 @@ void batadv_interface_rx(struct net_device *soft_iface,
>  		goto dropped;
>  	}
> 
> +	/* Snoop incoming traffic for dat update */
> +	batadv_dat_entry_check(bat_priv, skb, vid);
> +
>  	/* skb->dev & skb->pkt_type are set here */
>  	skb->protocol = eth_type_trans(skb, soft_iface);

Kind regards,
	Sven
--nextPart1726607.ftnllYezOn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXLGmCAAoJEF2HCgfBJntGzukP/1a5mKFbZujCY4ry8uyWA+Lt
GDL1s44BP9M4iduNWuRcEU7vifAPc3NfTBUEV3/SPHN/Nf3U5lEVxBDqJj3/cBab
qOBc6L40kIzet/6rRfQGuLigkroCtPkTAz6HQZO4LkI5zAuqPjtJb6WbOQ6YKsVX
ArPbj1g3ZeJA8urbLKipMimF4v78qBUUGNmlZ7w9gGArqy7RLoR1QQug4sbm4Tke
F0/rn6Zwg5n/m3yGFNUtkS1NwifOJlsGc7LoGwCbzjiZrBpWNM0daz2pvNYXn+1T
2H54yP3EMec0Hpmngy/3eHRVNH+Z0I+qJzpsPzAk5XWBLEm7AhFHzJfQYv1HSRuR
pkAgOYIY+gBAfXTtHdV0Xp0VVbSYaIJyMnUOonCnR3SRIz4WYFdM/gk9WZzVlHcz
hsPdqJWNGxCRQL4vbADldbbPX5yPZuCjesQQJntchD6IceHlv9ZrDnkLr/BKyZWy
VZT+8weSAa6El44nDifKHHlHd+AqUI54fu1jErz1KAIq5M2iT+v6A1cZIUfGua/y
ffLEldjbQw9hYWAEZ2K9Lvt4GrLL74OZCdGuGCseSBUxQ0bTSO2XojkVWx4KP6he
+oVuKN8W6VRXPpIedhVI5+G4k9pDo2w3o2LYUXwH7xY9oqVl3Smtaibuy1NwYiWI
phRVNKF+aWgjZxgvM88w
=das9
-----END PGP SIGNATURE-----

--nextPart1726607.ftnllYezOn--

