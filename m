Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 4 May 2013 20:42:44 +0800
References: <1366727676-23233-1-git-send-email-ordex@autistici.org>
 <1366727676-23233-5-git-send-email-ordex@autistici.org>
In-Reply-To: <1366727676-23233-5-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201305042042.44881.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 4/7] batman-adv: make the GW component
	vlan-featured
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

On Tuesday, April 23, 2013 22:34:32 Antonio Quartulli wrote:
> @@ -635,7 +635,8 @@ bool batadv_gw_is_dhcp_target(struct sk_buff *skb,
> unsigned int *header_len) }
>  
>  bool batadv_gw_out_of_range(struct batadv_priv *bat_priv,
> -                           struct sk_buff *skb, struct ethhdr *ethhdr)
> +                           struct sk_buff *skb, struct ethhdr *ethhdr,
> +                           unsigned short vid)

Kernel doc ?

Cheers,
Marek
