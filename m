Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 1 Nov 2011 11:52:45 +0100
References: <1320015072-10313-1-git-send-email-siwu@hrz.tu-chemnitz.de>
	<1320015072-10313-3-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1320015072-10313-3-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Message-Id: <201111011152.46222.lindner_marek@yahoo.de>
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [RFC 02/11] batman-adv: add basic bridge loop
	avoidance code
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

On Sunday, October 30, 2011 23:51:03 Simon Wunderlich wrote:
> +static const uint8_t announce_mac[6] = {0x43, 0x05, 0x43, 0x05, 0x00,
> 0x00};

All we ever use are 4 bytes - we could make this shorter. Otherwise please use 
ETH_ALEN. Please use ETH_ALEN throughout the code instead of 6.


> +       bat_dbg(DBG_BLA, bat_priv,
> +               "handle_announce(): ANNOUNCE vid %d (sent "
> +               "by %pM)... CRC = %04x (nw order)\n",
> +               vid, backbone_gw->orig, crc);

It is not network byte order anymore ..


+       /* TODO: we could cal something like tt_local_del() here. */

Why should we ?


> @@ -634,7 +640,7 @@ static int batman_skb_recv(struct sk_buff *skb, struct
> net_device *dev, case BAT_TT_QUERY:
>                 ret = recv_tt_query(skb, hard_iface);
>                 break;
> -               /* Roaming advertisement */
> +               /* bridge roop avoidance query */
>         case BAT_ROAM_ADV:
>                 ret = recv_roam_adv(skb, hard_iface);
>                 break;

Small typo here but why are you even changing the comment ?


>         atomic_t gw_reselect;
>         struct hard_iface __rcu *primary_if;  /* rcu protected pointer */
>         struct vis_info *my_vis_info;
> +       uint8_t own_orig[6];            /* cache primary hardifs address */
>  };

I'd call this "primary_addr" instead of "own_orig" to be consistent with 
"primary_if". Furthermore ETH_ALEN should be used for the length.


> +struct backbone_gw {
> +       uint8_t orig[ETH_ALEN];
> +       short vid;              /* used VLAN ID */
> +       struct hlist_node hash_entry;
> +       struct bat_priv *bat_priv;
> +       unsigned long lasttime; /* last time we heard of this backbone gw */
> +       atomic_t request_sent;
> +       atomic_t refcount;
> +       struct rcu_head rcu;
> +       uint16_t crc;           /* crc checksum over all claims */
> +} __packed;
> +
> +struct claim {
> +       uint8_t addr[ETH_ALEN];
> +       short vid;
> +       struct backbone_gw *backbone_gw;
> +       unsigned long lasttime; /* last time we heard of claim (locals only)
> */
> +       struct rcu_head rcu;
> +       atomic_t refcount;
> +       struct hlist_node hash_entry;
> +} __packed;

Why are these structs packed ?


Regards,
Marek
