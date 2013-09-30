Return-Path: <linus.luessing@web.de>
Date: Mon, 30 Sep 2013 22:06:49 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20130930200649.GD7002@Linus-Debian>
References: <1373242365-763-1-git-send-email-mihail.costea2005@gmail.com>
 <1373242365-763-5-git-send-email-mihail.costea2005@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1373242365-763-5-git-send-email-mihail.costea2005@gmail.com>
Subject: Re: [B.A.T.M.A.N.] [RFC 5/6] batman-adv: Generalize snooping
 mechanism in order to suport NDP too
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
Cc: mihail.costea2005@gmail.com

Hi Mihail,

On Mon, Jul 08, 2013 at 03:12:44AM +0300, mihail.costea2005@gmail.com wrote:
> From: Mihail Costea <mihail.costea90@gmail.com>
>  /**
> - * batadv_dat_snoop_outgoing_pkt_reply - snoop the ARP reply and fill the DHT
> + * batadv_dat_snoop_outgoing_pkt_reply - snoop the ARP reply / NA and fill
> + * the DHT
>   * @bat_priv: the bat priv with all the soft interface information
>   * @skb: packet to check
>   */
>  void batadv_dat_snoop_outgoing_pkt_reply(struct batadv_priv *bat_priv,
>  					 struct sk_buff *skb)
>  {
--- snip ---
> +	/* not a solicited advertisement (see snooping mechanism) */
> +	if (ip_dst) {
> +		batadv_dat_entry_add(bat_priv, ip_dst, dat_pair_type.data_type,
> +				     hw_dst, vid);
> +		batadv_dat_send_data(bat_priv, skb, ip_dst,
> +				     dat_pair_type.data_type,
> +				     BATADV_P_DAT_DHT_PUT);
> +	}
>  }

I'm currently wondering about the unsolicited neighbor
advertisement case. So far, your concept/patchset does not seem
to apply any optimizations for those packets, does it? They are
still flooded unconditionally, right?

What do you think, would it make sense to prevent unsolicited
neighbor advertisements from being forwarded into the mesh
network? Or would that create certain issues?

Cheers, Linus
