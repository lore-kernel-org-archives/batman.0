Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 20 Apr 2013 17:40:53 +0800
References: <1366401149-31600-1-git-send-email-siwu@hrz.tu-chemnitz.de>
 <1366401149-31600-4-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1366401149-31600-4-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201304201740.53565.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 3/6] batman-adv: reorder packet types
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

On Saturday, April 20, 2013 03:52:26 Simon Wunderlich wrote:
> @@ -892,6 +892,25 @@ static int batadv_check_unicast_ttvn(struct
> batadv_priv *bat_priv, return 1;
>  }
>  
> +int batadv_recv_unhandled_unicast_packet(struct sk_buff *skb,
> +                                        struct batadv_hard_iface *recv_if)
> +{
> +       struct batadv_unicast_packet *unicast_packet;
> +       struct batadv_priv *bat_priv = netdev_priv(recv_if->soft_iface);
> +       int check, hdr_size = sizeof(*unicast_packet);
> +
> +       check = batadv_check_unicast_packet(bat_priv, skb, hdr_size);
> +       if (check < 0)
> +               return NET_RX_DROP;
> +
> +       /* we don't know about this type, drop it. */
> +       unicast_packet = (struct batadv_unicast_packet *)skb->data;
> +       if (batadv_is_my_mac(bat_priv, unicast_packet->dest))
> +               return NET_RX_DROP;
> +
> +       return batadv_route_unicast_packet(skb, recv_if);
> +}

Kernel doc ?


Cheers,
Marek
