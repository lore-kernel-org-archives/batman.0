Return-Path: <mihail.costea90@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1368793673-27539-1-git-send-email-mihail.costea2005@gmail.com>
References: <1368793673-27539-1-git-send-email-mihail.costea2005@gmail.com>
Date: Fri, 17 May 2013 15:33:30 +0300
Message-ID: <CAP5XTDM=v+U4E1f3w15UtFJVjm=GsFWxptDKnQovTYr+xoTMiw@mail.gmail.com>
From: Mihail Costea <mihail.costea90@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] [RFC 1/4] batman-adv: renamed
 batadv_dat_snoop_*_arp_* functions to batadv_dat_snoop_*_msg_*
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

Hi,

For now is only for RFC, because there is a problem with the
calculation of router and override flags (see comments in RFC 3/4).

The code is based on the patch sent 2 weeks ago (the one with the
generalization).

There is no hurry with the review, because in 1 week I leave the
country and it will take another 1-2 weeks to get the laptop.
But, if the review is done and we need to discuss on the list (which I
think it should happen for the problem above and maybe other problems
too), I'll be available almost any time :) (with the exception of 3
days after my flight). Just that I will restart coding after I get the
new laptop.

Thanks,
Mihail

On 17 May 2013 15:27, Mihail <mihail.costea2005@gmail.com> wrote:
> From: "mihail.costea90@gmail.com" <mihail.costea90@gmail.com>
>
> Renamed snooping functions in order to suggest that they should work on
> more protocols than ARP.
>
> Signed-off-by: Mihail Costea <mihail.costea90@gmail.com>
> Signed-off-by: Stefan Popa <Stefan.A.Popa@intel.com>
> Reviewed-by: Stefan Popa <Stefan.A.Popa@intel.com>
>
> ---
>  distributed-arp-table.c |   16 ++++++++--------
>  distributed-arp-table.h |   16 ++++++++--------
>  routing.c               |   12 ++++++------
>  soft-interface.c        |    6 +++---
>  4 files changed, 25 insertions(+), 25 deletions(-)
>
> diff --git a/distributed-arp-table.c b/distributed-arp-table.c
> index af670d3..b2ca7e0 100644
> --- a/distributed-arp-table.c
> +++ b/distributed-arp-table.c
> @@ -978,7 +978,7 @@ out:
>  }
>
>  /**
> - * batadv_dat_snoop_outgoing_arp_request - snoop the ARP request and try to
> + * batadv_dat_snoop_outgoing_msg_request - snoop the ARP request and try to
>   * answer using DAT
>   * @bat_priv: the bat priv with all the soft interface information
>   * @skb: packet to check
> @@ -987,7 +987,7 @@ out:
>   * otherwise. In case of a positive return value the message has to be enqueued
>   * to permit the fallback.
>   */
> -bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
> +bool batadv_dat_snoop_outgoing_msg_request(struct batadv_priv *bat_priv,
>                                            struct sk_buff *skb)
>  {
>         uint16_t type = 0;
> @@ -1060,7 +1060,7 @@ out:
>  }
>
>  /**
> - * batadv_dat_snoop_incoming_arp_request - snoop the ARP request and try to
> + * batadv_dat_snoop_incoming_msg_request - snoop the ARP request and try to
>   * answer using the local DAT storage
>   * @bat_priv: the bat priv with all the soft interface information
>   * @skb: packet to check
> @@ -1068,7 +1068,7 @@ out:
>   *
>   * Returns true if the request has been answered, false otherwise.
>   */
> -bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
> +bool batadv_dat_snoop_incoming_msg_request(struct batadv_priv *bat_priv,
>                                            struct sk_buff *skb, int hdr_size)
>  {
>         uint16_t type;
> @@ -1130,11 +1130,11 @@ out:
>  }
>
>  /**
> - * batadv_dat_snoop_outgoing_arp_reply - snoop the ARP reply and fill the DHT
> + * batadv_dat_snoop_outgoing_msg_reply - snoop the ARP reply and fill the DHT
>   * @bat_priv: the bat priv with all the soft interface information
>   * @skb: packet to check
>   */
> -void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
> +void batadv_dat_snoop_outgoing_msg_reply(struct batadv_priv *bat_priv,
>                                          struct sk_buff *skb)
>  {
>         uint16_t type;
> @@ -1167,13 +1167,13 @@ void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
>                              BATADV_P_DAT_DHT_PUT);
>  }
>  /**
> - * batadv_dat_snoop_incoming_arp_reply - snoop the ARP reply and fill the local
> + * batadv_dat_snoop_incoming_msg_reply - snoop the ARP reply and fill the local
>   * DAT storage only
>   * @bat_priv: the bat priv with all the soft interface information
>   * @skb: packet to check
>   * @hdr_size: size of the encapsulation header
>   */
> -bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
> +bool batadv_dat_snoop_incoming_msg_reply(struct batadv_priv *bat_priv,
>                                          struct sk_buff *skb, int hdr_size)
>  {
>         uint16_t type;
> diff --git a/distributed-arp-table.h b/distributed-arp-table.h
> index 557bab9..28c062b 100644
> --- a/distributed-arp-table.h
> +++ b/distributed-arp-table.h
> @@ -31,13 +31,13 @@
>  #define BATADV_DAT_DATA_MAX_LEN 16
>
>  void batadv_dat_status_update(struct net_device *net_dev);
> -bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
> +bool batadv_dat_snoop_outgoing_msg_request(struct batadv_priv *bat_priv,
>                                            struct sk_buff *skb);
> -bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
> +bool batadv_dat_snoop_incoming_msg_request(struct batadv_priv *bat_priv,
>                                            struct sk_buff *skb, int hdr_size);
> -void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
> +void batadv_dat_snoop_outgoing_msg_reply(struct batadv_priv *bat_priv,
>                                          struct sk_buff *skb);
> -bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
> +bool batadv_dat_snoop_incoming_msg_reply(struct batadv_priv *bat_priv,
>                                          struct sk_buff *skb, int hdr_size);
>  bool batadv_dat_drop_broadcast_packet(struct batadv_priv *bat_priv,
>                                       struct batadv_forw_packet *forw_packet);
> @@ -105,28 +105,28 @@ static inline void batadv_dat_status_update(struct net_device *net_dev)
>  }
>
>  static inline bool
> -batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
> +batadv_dat_snoop_outgoing_msg_request(struct batadv_priv *bat_priv,
>                                       struct sk_buff *skb)
>  {
>         return false;
>  }
>
>  static inline bool
> -batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
> +batadv_dat_snoop_incoming_msg_request(struct batadv_priv *bat_priv,
>                                       struct sk_buff *skb, int hdr_size)
>  {
>         return false;
>  }
>
>  static inline bool
> -batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
> +batadv_dat_snoop_outgoing_msg_reply(struct batadv_priv *bat_priv,
>                                     struct sk_buff *skb)
>  {
>         return false;
>  }
>
>  static inline bool
> -batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
> +batadv_dat_snoop_incoming_msg_reply(struct batadv_priv *bat_priv,
>                                     struct sk_buff *skb, int hdr_size)
>  {
>         return false;
> diff --git a/routing.c b/routing.c
> index 7c372f1..1c43f55 100644
> --- a/routing.c
> +++ b/routing.c
> @@ -967,10 +967,10 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
>                         orig_node = batadv_orig_hash_find(bat_priv, orig_addr);
>                 }
>
> -               if (batadv_dat_snoop_incoming_arp_request(bat_priv, skb,
> +               if (batadv_dat_snoop_incoming_msg_request(bat_priv, skb,
>                                                           hdr_size))
>                         goto rx_success;
> -               if (batadv_dat_snoop_incoming_arp_reply(bat_priv, skb,
> +               if (batadv_dat_snoop_incoming_msg_reply(bat_priv, skb,
>                                                         hdr_size))
>                         goto rx_success;
>
> @@ -1015,10 +1015,10 @@ int batadv_recv_ucast_frag_packet(struct sk_buff *skb,
>                 if (!new_skb)
>                         return NET_RX_SUCCESS;
>
> -               if (batadv_dat_snoop_incoming_arp_request(bat_priv, new_skb,
> +               if (batadv_dat_snoop_incoming_msg_request(bat_priv, new_skb,
>                                                           hdr_size))
>                         goto rx_success;
> -               if (batadv_dat_snoop_incoming_arp_reply(bat_priv, new_skb,
> +               if (batadv_dat_snoop_incoming_msg_reply(bat_priv, new_skb,
>                                                         hdr_size))
>                         goto rx_success;
>
> @@ -1159,9 +1159,9 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
>         if (batadv_bla_is_backbone_gw(skb, orig_node, hdr_size))
>                 goto out;
>
> -       if (batadv_dat_snoop_incoming_arp_request(bat_priv, skb, hdr_size))
> +       if (batadv_dat_snoop_incoming_msg_request(bat_priv, skb, hdr_size))
>                 goto rx_success;
> -       if (batadv_dat_snoop_incoming_arp_reply(bat_priv, skb, hdr_size))
> +       if (batadv_dat_snoop_incoming_msg_reply(bat_priv, skb, hdr_size))
>                 goto rx_success;
>
>         /* broadcast for me */
> diff --git a/soft-interface.c b/soft-interface.c
> index a6ab9e4..9e8fd44 100644
> --- a/soft-interface.c
> +++ b/soft-interface.c
> @@ -232,7 +232,7 @@ static int batadv_interface_tx(struct sk_buff *skb,
>                  * packet, instead we first wait for DAT to try to retrieve the
>                  * correct ARP entry
>                  */
> -               if (batadv_dat_snoop_outgoing_arp_request(bat_priv, skb))
> +               if (batadv_dat_snoop_outgoing_msg_request(bat_priv, skb))
>                         brd_delay = msecs_to_jiffies(ARP_REQ_DELAY);
>
>                 if (batadv_skb_head_push(skb, sizeof(*bcast_packet)) < 0)
> @@ -271,10 +271,10 @@ static int batadv_interface_tx(struct sk_buff *skb,
>                                 goto dropped;
>                 }
>
> -               if (batadv_dat_snoop_outgoing_arp_request(bat_priv, skb))
> +               if (batadv_dat_snoop_outgoing_msg_request(bat_priv, skb))
>                         goto dropped;
>
> -               batadv_dat_snoop_outgoing_arp_reply(bat_priv, skb);
> +               batadv_dat_snoop_outgoing_msg_reply(bat_priv, skb);
>
>                 ret = batadv_unicast_send_skb(bat_priv, skb);
>                 if (ret != 0)
> --
> 1.7.10.4
>



-- 
Mihail Costea
