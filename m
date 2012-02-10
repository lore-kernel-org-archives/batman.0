Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 10 Feb 2012 22:25:18 +0800
References: <1328830902-11574-1-git-send-email-ordex@autistici.org>
	<1328830902-11574-6-git-send-email-ordex@autistici.org>
In-Reply-To: <1328830902-11574-6-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201202102225.18785.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv5 5/9] batman-adv: Distributed ARP Table
	- add snooping functions for ARP messages
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

On Friday, February 10, 2012 07:41:38 Antonio Quartulli wrote:
>  static inline void bat_dbg_arp(struct bat_priv *bat_priv,
>                                struct sk_buff *skb, uint16_t type) {
> -       char buf[30];
> -       const char *type_str[] = { "REQUEST", "REPLY", "RREQUEST",
> "RREPLY", -                                     "InREQUEST", "InREPLY",
> "NAK" }; -
> -       if (type >= 1 && type <= ARRAY_SIZE(type_str))
> -               scnprintf(buf, sizeof(buf), "%s", type_str[type - 1]);
> -       else
> -               scnprintf(buf, sizeof(buf), "UNKNOWN (%hu)", type);
> -
> -       bat_dbg(DBG_ARP, bat_priv, "ARP message of type %s recognised "
> -               "[src: %pM-%pI4 dst: %pM-%pI4]\n", buf, ARP_HW_SRC(skb),
> -               &ARP_IP_SRC(skb), ARP_HW_DST(skb), &ARP_IP_DST(skb));
> +       bat_dbg(DBG_ARP, bat_priv, "ARP MSG = [src: %pM-%pI4 dst:
> %pM-%pI4]\n", +               ARP_HW_SRC(skb), &ARP_IP_SRC(skb),
> ARP_HW_DST(skb), +               &ARP_IP_DST(skb));
>  }

Removing something that was just added in the previous patch is bad style and 
unlikely to be accepted.

Cheers,
Marek
