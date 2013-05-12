Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 12 May 2013 15:25:10 +0800
References: <1367927642-3223-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1367927642-3223-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201305121525.11172.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: access
	h_vlan_encapsulated_proto properly
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

On Tuesday, May 07, 2013 19:54:02 Antonio Quartulli wrote:
> In the gateway code in case of VLAN tagged frame the ethhdr
> pointer is moved forward by 4 bytes so that the offset of
> h_proto in struct ethhdr matches the real
> h_vlan_encapsulated_proto address in the skb.
> 
> This trick is correct but the code is not easy to understand
> and may lead to bugs in case of re-use of ethhdr for other
> purposes.
> 
> Use a standalone protocol variable and assign it accordingly
> to the header type

How about adding the key word "refactoring" somewhere into the subject line or 
the commit message ?


> @@ -626,23 +626,29 @@ bool batadv_gw_is_dhcp_target(struct sk_buff *skb,
> unsigned int *header_len) struct iphdr *iphdr;
>  	struct ipv6hdr *ipv6hdr;
>  	struct udphdr *udphdr;
> +	uint16_t proto;
> 
>  	/* check for ethernet header */
>  	if (!pskb_may_pull(skb, *header_len + ETH_HLEN))
>  		return false;
>  	ethhdr = (struct ethhdr *)skb->data;
> +	proto = ntohs(ethhdr->h_proto);
>  	*header_len += ETH_HLEN;
> 
>  	/* check for initial vlan header */
> -	if (ntohs(ethhdr->h_proto) == ETH_P_8021Q) {
> +	if (proto == ETH_P_8021Q) {
> +		struct vlan_ethhdr *vhdr;
> +

While we are refactoring I suggest to not ntohs() the protocol every time but 
the protocol constants. The compiler will replace the constants with the 
appropriate number during the compilation, thus saving us from a runtime 
operation every time we check a packet.

Cheers,
Marek
