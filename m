Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 30 Jul 2012 09:56:51 +0200
References: <1343602203-11584-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1343602203-11584-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201207300956.51449.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: use check_unicast_packet()
	in recv_roam_adv()
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

On Monday, July 30, 2012 00:50:03 Antonio Quartulli wrote:
> @@ -687,21 +687,9 @@ int batadv_recv_roam_adv(struct sk_buff *skb, struct
> batadv_hard_iface *recv_if) struct batadv_priv *bat_priv =
> netdev_priv(recv_if->soft_iface); struct batadv_roam_adv_packet
> *roam_adv_packet;
>  	struct batadv_orig_node *orig_node;
> -	struct ethhdr *ethhdr;
> -
> -	/* drop packet if it has not necessary minimum size */
> -	if (unlikely(!pskb_may_pull(skb,
> -				    sizeof(struct batadv_roam_adv_packet))))
> -		goto out;
> +	int hdr_size = sizeof(struct batadv_roam_adv_packet);

Shouldn't we do: int hdr_size = sizeof(*roam_adv_packet); ?


Regards,
Marek
