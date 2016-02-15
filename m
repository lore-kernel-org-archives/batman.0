Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 15 Feb 2016 09:33:02 +0100
Message-ID: <5969063.Lf5LH4TAYi@prime>
In-Reply-To: <OF8F259E43.DCC67654-ONC1257F57.004C278A-C1257F57.004C3956@phoenixcontact.com>
References: <OF8F259E43.DCC67654-ONC1257F57.004C278A-C1257F57.004C3956@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1825088.3mYHMOUlgF";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/4] batman-adv: Speed up dat by snooping
	received ip traffic
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart1825088.3mYHMOUlgF
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Friday 12 February 2016 14:52:34 Andreas Pape wrote:
> From cc88159dcf18f4b8310414d2d71635fad76bf5bb Mon Sep 17 00:00:00 2001
> From: Andreas Pape <apape@phoenixcontact.com>
> Date: Fri, 12 Feb 2016 11:03:10 +0100
> Subject: [PATCH 2/4] batman-adv: Speed up dat by snooping received ip
> traffic
> 
> This patch shall speed up dat by snooping all incoming ip traffic instead
> of only relying on ARP handling. This shall especially increase the
> probability
> that a gateway into a backbone network already has a fitting dat entry to
> answer
> incoming arp requests directly coming from the backbone network.
> 
> Signed-off-by: Andreas Pape <apape@phoenixcontact.com>
> ---
>  net/batman-adv/distributed-arp-table.c |   18 ++++++++++++++++++
>  net/batman-adv/distributed-arp-table.h |    8 +++++++-
>  net/batman-adv/soft-interface.c        |   21 ++++++++++++++++++++-
>  3 files changed, 45 insertions(+), 2 deletions(-)
> 
> diff --git a/net/batman-adv/distributed-arp-table.c
> b/net/batman-adv/distributed-arp-table.c
> index 93893bf..4e64e6c 100644
> --- a/net/batman-adv/distributed-arp-table.c
> +++ b/net/batman-adv/distributed-arp-table.c
> @@ -362,6 +362,24 @@ out:
>                 batadv_dat_entry_put(dat_entry);
>  }
> 
> +/**
> + * batadv_dat_entry_check - check and update a dat entry
> + * @bat_priv: the bat priv with all the soft interface information
> + * @ip: ipv4 to add/edit
> + * @mac_addr: mac address to assign to the given ipv4
> + * @vid: VLAN identifier
> + *
> + * checks additionally, if dat is enabled. can be called from other
> modules.
> + */
> +void batadv_dat_entry_check(struct batadv_priv *bat_priv, __be32 ip,
> +                                u8 *mac_addr, unsigned short vid)
> +{
> +       if(!atomic_read(&bat_priv->distributed_arp_table))
> +               return;
> +
> +       batadv_dat_entry_add(bat_priv, ip, mac_addr, vid);
> +}
> +
>  #ifdef CONFIG_BATMAN_ADV_DEBUG
> 
>  /**
> diff --git a/net/batman-adv/distributed-arp-table.h
> b/net/batman-adv/distributed-arp-table.h
> index 813ecea..a2ab16b 100644
> --- a/net/batman-adv/distributed-arp-table.h
> +++ b/net/batman-adv/distributed-arp-table.h
> @@ -80,7 +80,8 @@ batadv_dat_init_own_addr(struct batadv_priv *bat_priv,
>  int batadv_dat_init(struct batadv_priv *bat_priv);
>  void batadv_dat_free(struct batadv_priv *bat_priv);
>  int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offset);
> -
> +void batadv_dat_entry_check(struct batadv_priv *bat_priv, __be32 ip,
> +                                u8 *mac_addr, unsigned short vid);
>  /**
>   * batadv_dat_inc_counter - increment the correct DAT packet counter
>   * @bat_priv: the bat priv with all the soft interface information
> @@ -173,6 +174,11 @@ static inline void batadv_dat_inc_counter(struct
> batadv_priv *bat_priv,
>  {
>  }
> 
> +void batadv_dat_entry_check(struct batadv_priv *bat_priv, __be32 ip,
> +                                u8 *mac_addr, unsigned short vid)
> +{
> +}
> +
>  #endif /* CONFIG_BATMAN_ADV_DAT */
> 
>  #endif /* _NET_BATMAN_ADV_DISTRIBUTED_ARP_TABLE_H_ */
> diff --git a/net/batman-adv/soft-interface.c
> b/net/batman-adv/soft-interface.c
> index 0710379..41d7987 100644
> --- a/net/batman-adv/soft-interface.c
> +++ b/net/batman-adv/soft-interface.c
> @@ -28,6 +28,7 @@
>  #include <linux/fs.h>
>  #include <linux/if_ether.h>
>  #include <linux/if_vlan.h>
> +#include <linux/ip.h>
>  #include <linux/jiffies.h>
>  #include <linux/kernel.h>
>  #include <linux/kref.h>
> @@ -390,6 +391,7 @@ void batadv_interface_rx(struct net_device
> *soft_iface,
>         __be16 ethertype = htons(ETH_P_BATMAN);
>         struct vlan_ethhdr *vhdr;
>         struct ethhdr *ethhdr;
> +       struct iphdr *iphdr;
>         unsigned short vid;
>         bool is_bcast;
> 
> @@ -412,11 +414,28 @@ void batadv_interface_rx(struct net_device
> *soft_iface,
>         ethhdr = eth_hdr(skb);
> 
>         switch (ntohs(ethhdr->h_proto)) {
> +       case ETH_P_IP:
> +               iphdr = (struct iphdr *)(skb->data + ETH_HLEN);
> +               /* snoop incoming traffic for dat update using the source
> mac
> +                * and source ip to speed up dat.
> +                * Question: does this break the fundamental idea of
> dat????
> +                */

That is a really good question, although it doesn't belong in the code ;)

@Antonio, CC'ing you since this is more a design question/proposal and you may 
have thought about this yet.

Basically, doing this change means that we will put a lot of IP addresses in 
our cache which are not in our local network - typically, all Internet IP 
addresses along with the gateway backbone. Also these addresses will never be 
requested by ARP and are therefore practically just littering our cache. They 
are purged after 5 minutes so the impact may be reasonable, but still ...

Maybe there is a way to limit the entries to local networks? Also (and in 
general), should we have an upper limit how many entries we store in DAT? 
After applying this patch, doing a subnet ping scan can deplete the RAM in 
small routers I'm afraid. :)

(even now, that would be possible with fake ARP replies I guess)

Also, why don't you check the ip destination as well while at it?

Cheers,
      Simon





--nextPart1825088.3mYHMOUlgF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWwY0+AAoJEKEr45hCkp6hT8sP/R+0xccsXwDUV1SKdPc6S8D9
MYSL1bCGcKAWnKUa+32oTCzuYJ1xymxzjP949iArtGpB16k55HuDZdL3SgkF2PEQ
1hl35VhPNF49vCZ2zGGcr2muqy/+469MMmA86LzODUVQjyFVd1CEE+xlsyhldOhQ
C4/VApv4g380odvSqHJ6kM0Zwdy4NPZN2qsolCkzMPKd5yQkwIpP9A3pin/g/9Xr
J8JyzmxuDSd22DllbVS1piMFMVRWVPrExyYMaVpuZSjFAjfZ/eNpdYLA1laaBsea
dRP1OlhOpCnY4jxbpQYi+CBnyN826xneLi9zzL6Bm6wLgEBYCnXgSiTrUCmDdpc2
s6AwqfMI6r7eigTRM60eYCSROtWeF0w6RN+f7SzVu34tIBBagUs3xi03kGn4Ht+M
y18v0Bt6vfXtCMJOHsxb1A1OkfgXTnyPCDt7XHoc4hPG+gRtQ6LLp3J9wLEgXTRL
2iXjJ29KpsapfIbpdM+BTJi8uFZTnHvOcI9jomtt7adCZsncl9XzD4KnmLx9ElvK
CAHe07HDOiDVVYhvI3OgTTFsrQCa4aj+zZOwCiEr+aANLfL0sEOU+5HL7SfyQzo2
l46kigH50DBQqcqDbNLjO46yS2KU85BdW5BuXjFrrALblw3f7skofw7Tlwj2b43O
ibROzqg00HyEcjyr/3pb
=JY3V
-----END PGP SIGNATURE-----

--nextPart1825088.3mYHMOUlgF--

