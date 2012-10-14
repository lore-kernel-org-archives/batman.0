Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 14 Oct 2012 22:57:29 +0800
References: <1349787887-26501-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1349787887-26501-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201210142257.29499.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: enable fast client detection
	using unicast_4addr packets
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

On Tuesday, October 09, 2012 21:04:47 Antonio Quartulli wrote:
> @@ -1061,9 +1063,12 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
>  
>         /* packet for me */
>         if (batadv_is_my_mac(unicast_packet->dest)) {
> -               if (is4addr)
> +               if (is4addr) {
>                         batadv_dat_inc_counter(bat_priv,
>                                                unicast_4addr_packet->subtyp
> e); +                       orig_addr = unicast_4addr_packet->src;
> +                       orig_node = batadv_orig_hash_find(bat_priv,
> orig_addr); +               }

Last time I checked batadv_orig_hash_find() increased a refcounter ...

Cheers,
Marek
