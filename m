Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 01 Jul 2016 15:49:54 +0200
Message-ID: <1655869.LYQpVbDg6l@prime>
In-Reply-To: <1465557064-24406-3-git-send-email-apape@phoenixcontact.com>
References: <1465557064-24406-1-git-send-email-apape@phoenixcontact.com>
 <1465557064-24406-3-git-send-email-apape@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1477788.LR91K0U2Xh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v5 2/6] batman-adv: speed up dat by
	snooping received ip traffic
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

--nextPart1477788.LR91K0U2Xh
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Andreas,

as suggested by yourself and according to the discussion, please drop t=
his=20
patch from the patchset on the next resend. It may be better to resend =
it=20
separately when the concerns are cleared.

Thanks!
    Simon

On Friday 10 June 2016 13:11:00 Andreas Pape wrote:
> Speeding up dat address lookup is achieved by snooping all incoming i=
p
> traffic. This especially increases the propability in bla setups that=

> a gateway into a common backbone network already has a fitting dat en=
try
> to answer incoming ARP requests directly coming from the backbone
> network thus further reducing ARP traffic in the mesh.
>=20
> Signed-off-by: Andreas Pape <apape@phoenixcontact.com>
> ---
>  net/batman-adv/distributed-arp-table.c |   55
> ++++++++++++++++++++++++++++++++ net/batman-adv/distributed-arp-table=
.h | =20
>  9 +++++-
>  net/batman-adv/soft-interface.c        |    3 ++
>  3 files changed, 66 insertions(+), 1 deletions(-)
>=20
> diff --git a/net/batman-adv/distributed-arp-table.c
> b/net/batman-adv/distributed-arp-table.c index b752f8d..998a4b8 10064=
4
> --- a/net/batman-adv/distributed-arp-table.c
> +++ b/net/batman-adv/distributed-arp-table.c
> @@ -27,6 +27,7 @@
>  #include <linux/if_arp.h>
>  #include <linux/if_ether.h>
>  #include <linux/if_vlan.h>
> +#include <linux/ip.h>
>  #include <linux/in.h>
>  #include <linux/jiffies.h>
>  #include <linux/kernel.h>
> @@ -362,6 +363,60 @@ out:
>  =09=09batadv_dat_entry_put(dat_entry);
>  }
>=20
> +/**
> + * batadv_dat_entry_check - check and update a dat entry
> + * @bat_priv: the bat priv with all the soft interface information
> + * @skb: socket buffer
> + * @vid: VLAN identifier
> + *
> + * snoops incoming socket buffer for dat cache updates, if dat is en=
abled.
> + * Can be called from other modules.
> + */
> +void batadv_dat_entry_check(struct batadv_priv *bat_priv, struct sk_=
buff
> *skb, +=09=09=09    unsigned short vid)
> +{
> +=09struct vlan_ethhdr *vhdr =3D NULL, tmp_vhdr;
> +=09struct ethhdr *ethhdr =3D NULL;
> +=09struct iphdr *iphdr =3D NULL, tmp_iphdr;
> +
> +=09if (!atomic_read(&bat_priv->distributed_arp_table))
> +=09=09return;
> +
> +=09ethhdr =3D eth_hdr(skb);
> +
> +=09switch (ntohs(ethhdr->h_proto)) {
> +=09case ETH_P_IP:
> +=09=09iphdr =3D skb_header_pointer(skb, ETH_HLEN, sizeof(tmp_iphdr),=

> +=09=09=09=09=09   &tmp_iphdr);
> +=09=09break;
> +=09case ETH_P_8021Q:
> +=09=09vhdr =3D skb_header_pointer(skb, 0, sizeof(tmp_vhdr),
> +=09=09=09=09=09  &tmp_vhdr);
> +=09=09if (!vhdr)
> +=09=09=09return;
> +=09=09if (ntohs(vhdr->h_vlan_encapsulated_proto) !=3D ETH_P_IP)
> +=09=09=09return;
> +=09=09iphdr =3D skb_header_pointer(skb, sizeof(tmp_vhdr),
> +=09=09=09=09=09   sizeof(tmp_iphdr),
> +=09=09=09=09=09   &tmp_iphdr);
> +=09=09break;
> +=09}
> +
> +=09if (!iphdr)
> +=09=09return;
> +=09/* don't add source address 0.0.0.0, which can occur during
> +=09 * dhcp discover or request.
> +=09 */
> +=09if (ntohl(iphdr->saddr) =3D=3D 0)
> +=09=09return;
> +
> +=09batadv_dbg(BATADV_DBG_DAT, bat_priv,
> +=09=09   "Snooped IP address: %pI4 %pM (vid: %d)\n",
> +=09=09   &iphdr->saddr, ethhdr->h_source,
> +=09=09   BATADV_PRINT_VID(vid));
> +=09batadv_dat_entry_add(bat_priv, iphdr->saddr, ethhdr->h_source, vi=
d);
> +}
> +
>  #ifdef CONFIG_BATMAN_ADV_DEBUG
>=20
>  /**
> diff --git a/net/batman-adv/distributed-arp-table.h
> b/net/batman-adv/distributed-arp-table.h index 813ecea..cf1b93c 10064=
4
> --- a/net/batman-adv/distributed-arp-table.h
> +++ b/net/batman-adv/distributed-arp-table.h
> @@ -80,7 +80,8 @@ batadv_dat_init_own_addr(struct batadv_priv *bat_pr=
iv,
>  int batadv_dat_init(struct batadv_priv *bat_priv);
>  void batadv_dat_free(struct batadv_priv *bat_priv);
>  int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offs=
et);
> -
> +void batadv_dat_entry_check(struct batadv_priv *bat_priv, struct sk_=
buff
> *skb, +=09=09=09    unsigned short vid);
>  /**
>   * batadv_dat_inc_counter - increment the correct DAT packet counter=

>   * @bat_priv: the bat priv with all the soft interface information
> @@ -173,6 +174,12 @@ static inline void batadv_dat_inc_counter(struct=

> batadv_priv *bat_priv, {
>  }
>=20
> +static inline
> +void batadv_dat_entry_check(struct batadv_priv *bat_priv, struct sk_=
buff
> *skb, +=09=09=09    unsigned short vid)
> +{
> +}
> +
>  #endif /* CONFIG_BATMAN_ADV_DAT */
>=20
>  #endif /* _NET_BATMAN_ADV_DISTRIBUTED_ARP_TABLE_H_ */
> diff --git a/net/batman-adv/soft-interface.c
> b/net/batman-adv/soft-interface.c index 81665b1..a86748f 100644
> --- a/net/batman-adv/soft-interface.c
> +++ b/net/batman-adv/soft-interface.c
> @@ -442,6 +442,9 @@ void batadv_interface_rx(struct net_device *soft_=
iface,
>  =09=09goto dropped;
>  =09}
>=20
> +=09/* Snoop incoming traffic for dat update */
> +=09batadv_dat_entry_check(bat_priv, skb, vid);
> +
>  =09/* skb->dev & skb->pkt_type are set here */
>  =09skb->protocol =3D eth_type_trans(skb, soft_iface);
>=20
> --
> 1.7.0.4
>=20
>=20
>=20
> ..................................................................
> PHOENIX CONTACT ELECTRONICS GmbH
>=20
> Sitz der Gesellschaft / registered office of the company: 31812 Bad P=
yrmont
> USt-Id-Nr.: DE811742156
> Amtsgericht Hannover HRB 100528 / district court Hannover HRB 100528
> Gesch=C3=A4ftsf=C3=BChrer / Executive Board: Roland Bent, Dr. Martin =
Heubeck
> ___________________________________________________________________
> Diese E-Mail enth=C3=A4lt vertrauliche und/oder rechtlich gesch=C3=BC=
tzte
> Informationen. Wenn Sie nicht der richtige Adressat sind oder diese E=
=2DMail
> irrt=C3=BCmlich erhalten haben, informieren Sie bitte sofort den Abse=
nder und
> vernichten Sie diese Mail. Das unerlaubte Kopieren, jegliche anderwei=
tige
> Verwendung sowie die unbefugte Weitergabe dieser Mail ist nicht gesta=
ttet.
> ---------------------------------------------------------------------=
=2D-----
> ------------------------- This e-mail may contain confidential and/or=

> privileged information. If you are not the intended recipient (or hav=
e
> received this e-mail in error) please notify the sender immediately a=
nd
> destroy this e-mail. Any unauthorized copying, disclosure, distributi=
on or
> other use of the material or parts thereof is strictly forbidden.
> ___________________________________________________________________

--nextPart1477788.LR91K0U2Xh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXdnUCAAoJEKEr45hCkp6hmrQP/jP1itvAHW2qx90ABYi/zfWp
GNBw1DRPUn23D96FRlxT/HpJNHpktGEbW94IiHD9CWtlrbZjBV8CCsQSxuymIOhY
bp5w6Ob5bCVVg8Cy5VbZuqJCVppiW0xqS/uV0KZ+jZeEA0CK531OshZrmhtLV/6S
BvBYe5hHiMgzw62DKsjnVTjwHw9yj2NppUZfe51osig2wuRXopqXfihPNnVIYOE2
oBrZz7TOVBTEGdG54q4U+Uk2r78CCRnL3I3otQ8fAfrtJJGW6pDzQCoV5XZocHOF
BTI8Ka4lfnUT4KD2Z85Ut+0/nouDCjVJKwBZ5Lo7XWjVVZMAG1+RlKxxxzweOZKa
bFdMiRytAu1ml6aLn24tXntt4zHwNQmpW94JyG0dljTT6aIqu/QMHfhkuPX2M/6w
VuXadHuCZ0YhdBAOQR9hlz1IjeeFPJM5BaNXKqG48W0EUJl+54O7TFVz8ePpIDBv
diRS7982TQXJ/oPcxBzE8sREg3dvOH8nO3eL0rWnQ5Ls8+sfyP0S8gsPj85Zz5/b
78XJ7yh1MGkrWbqe+urBo4WGryeDiNEsePdupMvE9xfD5fKkSsjgh3IcIE3e72Ee
3xuZbzqPBc7gM4i8yfSFf3BQLOtY1kxowsebhLNRuwVMqLv//lJ9zjdv2eX69Bax
BzI5NnLL5oaEa4Ad8rjl
=YaYH
-----END PGP SIGNATURE-----

--nextPart1477788.LR91K0U2Xh--

