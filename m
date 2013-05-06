Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 6 May 2013 11:31:00 +0800
References: <1366727676-23233-1-git-send-email-ordex@autistici.org>
 <1366727676-23233-7-git-send-email-ordex@autistici.org>
In-Reply-To: <1366727676-23233-7-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201305061131.01113.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 5/7] batman-adv: make the Distributed ARP
	Table vlan aware
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

On Tuesday, April 23, 2013 22:34:34 Antonio Quartulli wrote:
>  /**
> + * batadv_dat_get_vid - extract the VLAN identifier from skb if any
> + * @skb: the buffer containing the packet to extract the VID from
> + * @hdr_size: the size of the batman-adv header encapsulating the packet
> + *
> + * If the packet contained in skb is vlan tagged then this function
> returns the + * VID with the BATADV_VLAN_HAS_TAG flag. Otherwise returns
> BATADV_NO_FLAGS + */
> +static unsigned short batadv_dat_get_vid(struct sk_buff *skb, int
> *hdr_size) +{
> +       struct ethhdr *ethhdr;
> +       struct vlan_ethhdr *vhdr;
> +       unsigned short vid;
> +
> +       ethhdr = (struct ethhdr *)skb->data + *hdr_size;
> +
> +       if (ntohs(ethhdr->h_proto) != ETH_P_8021Q)
> +               return BATADV_NO_FLAGS;
> +
> +       vhdr = (struct vlan_ethhdr *)ethhdr;
> +       vid = ntohs(vhdr->h_vlan_TCI) & VLAN_VID_MASK;
> +       vid |= BATADV_VLAN_HAS_TAG;
> +       /* ARP parsing functions jump forward of hdr_size + ETH_HLEN.
> +        * If the header contained in the packet is a VLAN one (which is
> longer) +        * hdr_size is updated so that the functions will still
> jump the +        * correct amount of bytes
> +        */
> +       *hdr_size += VLAN_HLEN;
> +
> +       return vid;
> +}

This is a very useful function. Why do you make it DAT specific ? The other 
patches contain the same vid extraction code over and over again. It would 
make more sense if you added this function with your first patch and make 
everybody use it.

Cheers,
Marek
