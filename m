Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 4 May 2013 20:39:17 +0800
References: <1366727676-23233-1-git-send-email-ordex@autistici.org>
 <1366727676-23233-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1366727676-23233-2-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201305042039.17821.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/7] batman-adv: add the VLAN ID
	attribute to the TT entry
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

On Tuesday, April 23, 2013 22:34:29 Antonio Quartulli wrote:
>  /**
>   * batadv_send_unicast_skb - send the skb encapsulated in a unicast packet
>   * @bat_priv: the bat priv with all the soft interface information
>   * @skb: the payload to send
> + * @vid: the vid to be used to search the translation table
>   */
>  static inline int batadv_send_skb_unicast(struct batadv_priv *bat_priv,

Returns ?


> @@ -61,14 +63,16 @@ static inline int batadv_send_skb_unicast(struct 
batadv_priv *bat_priv,
>   * @bat_priv: the bat priv with all the soft interface information
>   * @skb: the payload to send
>   * @packet_subtype: the batman 4addr packet subtype to use
> + * @vid: the vid to be used to search the translation table
>   */
>  static inline int batadv_send_skb_4addr_unicast(struct batadv_priv 
*bat_priv,

Returns ?


> +/**
> + * batadv_tt_local_add - add a new client to the local table or update it
> if + * already exists
> + * @soft_iface: netdev struct of the mesh interface
> + * @addr: the mac address of the client to add
> + * @vid: VLAN identifier
> + * @ifindex: index of the interface where the client is connected to
> (useful to + * identify wireless clients)
> + */

Multi-line kernel doc should be indented by a space.


> +/**
> + * batadv_choose_tt - return the index of the tt entry in the hash table
> + * @data: pointer to the tt_common_entry object to map
> + * @size: the size of the hash table
> + */
> +static inline uint32_t batadv_choose_tt(const void *data, uint32_t size)

Returns ?


> +/**
> + * batadv_tt_local_add - add a new client to the local table or update it 
if
> + * already exists
> + * @soft_iface: netdev struct of the mesh interface
> + * @addr: the mac address of the client to add
> + * @vid: VLAN identifier
> + * @ifindex: index of the interface where the client is connected to 
(useful to
> + * identify wireless clients)
> + */

Space indentation in the title ..


> +/**
> + * batadv_tt_global_del - remove a client from the global table
> + * @bat_priv: the bat priv with all the soft interface information
> + * @orig_node: an originator serving this client
> + * @addr: the mac address of the client
> + * @vid: VLAN identifier
> + * @message: a message explaining the reason for deleting the client to 
print
> + * for debugging purpose
> + */
>  static void batadv_tt_global_del(struct batadv_priv *bat_priv,
>                                  struct batadv_orig_node *orig_node,
> -                                const unsigned char *addr,
> +                                const unsigned char *addr, unsigned short 
vid,
>                                  const char *message, bool roaming)

Kernel doc for roaming is missing and a space as well.  :)


Cheers,
Marek
