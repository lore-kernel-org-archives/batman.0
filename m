Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 30 Dec 2018 14:51:12 +0100
Message-ID: <1976755.cJCZaRukfj@sven-edge>
In-Reply-To: <20181229031040.7207-1-linus.luessing@c0d3.blue>
References: <20181229031040.7207-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4673303.sXWeHaK0yk";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v7] batman-adv: Snoop DHCPACKs for DAT
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

--nextPart4673303.sXWeHaK0yk
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Saturday, 29 December 2018 04.10.40 CET Linus L=C3=BCssing wrote:
> +#define BATADV_DHCP_YIADDR_LEN sizeof(((struct batadv_dhcp_packet *)0)->=
chaddr)
> +#define BATADV_DHCP_CHADDR_LEN sizeof(((struct batadv_dhcp_packet *)0)->=
chaddr)

Why do you use chaddr to calculate the size of yiaddr? yiaddr is only 4 byt=
e=20
and chaddr is 16 byte. Looks to me like you have a potential stack overflow=
 in=20
batadv_dat_dhcp_get_yiaddr because of that.

And you have a lot of code which calls skb_header_pointer again and again +=
 a=20
lot of offset calculations. So it has to potentially traverse all the=20
fragments again and again. I have seen:

* op
* htype
* hlen
* magic
* TLV options parts
* yiaddr
* chaddr

Do you see any potential in combining some of them in batadv_dat_check_dhcp=
=20
(e.g. op, htype, hlen)?

> +/**
> + * batadv_dat_check_dhcp_ack() - examine packet for valid DHCP message
> > + * @skb: the packet to check
> + * @proto: ethernet protocol hint (behind a potential vlan)
> + * @ip_src: a buffer to store the IPv4 source address in
> + * @chaddr: a buffer to store the DHCP Client Hardware Address in
> + * @yiaddr: a buffer to store the DHCP Your IP Address in
> + *
> + * Checks whether the given skb is a valid DHCPACK. And if so, stores the
> + * IPv4 server source address (ip_src), client MAC address (chaddr) and =
client
> + * IPv4 address (yiaddr) in the provided buffers.
> +
> + * Caller needs to ensure that the skb network header is set correctly.
> + *
> + * Return: True if the skb is a valid DHCPACK. False otherwise.
> + */

There seems to be a missing "*" in the line before the line "Caller needs t=
o=20
ensure that the skb network header"


Missing header in distributed-arp-table.c:

* asm/unaligned.h

> --- a/net/batman-adv/distributed-arp-table.c
> +++ b/net/batman-adv/distributed-arp-table.c
[...]
> @@ -42,9 +43,11 @@
>  #include <linux/spinlock.h>
>  #include <linux/stddef.h>
>  #include <linux/string.h>
> +#include <linux/udp.h>
>  #include <linux/workqueue.h>
>  #include <net/arp.h>
>  #include <net/genetlink.h>
> +#include <net/ip.h>
>  #include <net/netlink.h>
>  #include <net/sock.h>
>  #include <uapi/linux/batman_adv.h>

And "net/ip.h" also doesn't seem to be used in distributed-arp-table.c



But the biggest problem is that it doesn't build:

    /usr/bin/make -C /home/build_test/build_env/linux-build/linux-4.9.148 M=
=3D/home/build_test/build_env/tmp.9CjwRXIj4f PWD=3D/home/build_test/build_e=
nv/tmp.9CjwRXIj4f REVISION=3D CONFIG_BATMAN_ADV=3Dm CONFIG_BATMAN_ADV_DEBUG=
=3Dn CONFIG_BATMAN_ADV_DEBUGFS=3Dy CONFIG_BATMAN_ADV_BLA=3Dn CONFIG_BATMAN_=
ADV_DAT=3Dn CONFIG_BATMAN_ADV_NC=3Dy CONFIG_BATMAN_ADV_MCAST=3Dy CONFIG_BAT=
MAN_ADV_TRACING=3Dy CONFIG_BATMAN_ADV_BATMAN_V=3Dy INSTALL_MOD_DIR=3Dupdate=
s/  modules
    [...]
    /home/build_test/build_env/tmp.9CjwRXIj4f/net/batman-adv/routing.c:1046=
:17: error: undefined identifier 'batadv_dat_snoop_incoming_dhcp_ack'
    /home/build_test/build_env/tmp.9CjwRXIj4f/net/batman-adv/routing.c:1283=
:9: error: undefined identifier 'batadv_dat_snoop_incoming_dhcp_ack'
    /home/build_test/build_env/tmp.9CjwRXIj4f/net/batman-adv/routing.c: In =
function =E2=80=98batadv_recv_unicast_packet=E2=80=99:
    /home/build_test/build_env/tmp.9CjwRXIj4f/net/batman-adv/routing.c:1046=
:3: error: implicit declaration of function =E2=80=98batadv_dat_snoop_incom=
ing_dhcp_ack=E2=80=99 [-Werror=3Dimplicit-function-declaration]
       batadv_dat_snoop_incoming_dhcp_ack(bat_priv, skb, hdr_size);

Looks like distributed-arp-table.h is missing a stub function for=20
batadv_dat_snoop_incoming_dhcp_ack when CONFIG_BATMAN_ADV_DAT is not set.

Kind regards,
	Sven
--nextPart4673303.sXWeHaK0yk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlwozVAACgkQXYcKB8Em
e0ahYw//e7FwiObbru89Kbn+C8WkfrE+mgm80dtAnwsKHJOJ2oAJg2pTiuR9CQvx
jHW0tMD2edicN/iHtVj3rTHZPGbpSTrUHP2CqMEUJw9BeHCmDZgPfcs5wAfmUJjW
OJCFH8OjiPLRcorGO2X6k0K+LK3Lo9KXp3liXAbRUeKbjPsm0XKVfMOl6G6Clej8
rE+JkgUCNJ1XF3XEYYRejXK7K/uMjwvf4t7IpQSADRZ+Yfhtn8Q6+oMIlyxv+ncP
gocRa1+51sMHTwOrOdtE+AxczFuUlRKAAm+GtNjbOrisQZwBE7aaT/XehxuCLHuy
/3gNVs0EzS66QAKnPjfQIer+IQDkeXVbblKOrqEzdV0sDkoyh4zMNtjJOcETXbZC
s3YxzpvLREGluGE4csuPwBey/Lac0sCnUcRTtXMwVe0om3P0LpIVT7vUZROuNa/4
lKpjp6YnTOB7vhKS8PUZkFvnoBba1bXlA0zn4FJxFvSIvePA5mTqV6kBDSX1Fj8e
H67F2P1sF9b8LExS1NZlaek3lahdGrStXbLFCZ880LkIkaXLVHpPui4Zcd/XtAoV
e1k5ghvVY3wPFuQbgXBxWK12KSyF5zGBgmdWKi3WwcsVbwz7cFOxzg1MIVgsWfbw
k5i3H+ZGvCTee4D9ECMZ2pi67q0habfBk/QNLVXPd0g6W2FbWo0=
=suEl
-----END PGP SIGNATURE-----

--nextPart4673303.sXWeHaK0yk--



