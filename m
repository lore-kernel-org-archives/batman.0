Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 06 May 2016 12:03:57 +0200
Message-ID: <1774690.zXGivVJ4dJ@sven-edge>
In-Reply-To: <1462525107-19750-3-git-send-email-apape@phoenixcontact.com>
References: <1462525107-19750-1-git-send-email-apape@phoenixcontact.com>
 <1462525107-19750-3-git-send-email-apape@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart14340448.NX9F9Fvt01";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 2/6] batman-adv: speed up dat by
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

--nextPart14340448.NX9F9Fvt01
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

just some ideas (maybe not all of them are good):

[...]
> +       ethhdr = eth_hdr(skb);
> +
> +       switch (ntohs(ethhdr->h_proto)) {
> +       case ETH_P_IP:
> +               iphdr = skb_header_pointer(skb, ETH_HLEN, sizeof(tmp_iphdr),
> +                                          &tmp_iphdr);
> +               break;
> +       case ETH_P_8021Q:
> +               vhdr = skb_header_pointer(skb, 0, sizeof(tmp_vhdr),
> +                                         &tmp_vhdr);
> +               if (!vhdr)
> +                       break;

Do we need to continue here when there is no vhdr? Maybe just return.

> +               if (ntohs(vhdr->h_vlan_encapsulated_proto) == ETH_P_IP) {

Maybe the check here could be inverted to just return when this is not ETH_P_IP

> +                       iphdr = skb_header_pointer(skb, sizeof(tmp_vhdr),
> +                                                  sizeof(tmp_iphdr),
> +                                                  &tmp_iphdr);
> +               }
> +               break;
> +       }
> +
> +       if (iphdr) {

You could just modify the check to:

if (!iphdr)
	return;

Kind regards,
	Sven
--nextPart14340448.NX9F9Fvt01
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXLGwNAAoJEF2HCgfBJntGcvcQAIq6/WuW/zRdz9xLsPsfieb7
aKmmey2D7pypdnl9ZgSLkN9DifG//ZksWOK9dzHiYJpDEe+iprfZgRgnR35BbfBe
RYWpOOLt/vy2fP/8pvl07gnGr5a/fM3NwSfqeHCb6NNqEiT8JKVABC69tEwlh2vQ
CX6TW44b1VfRxW/TRu/eKMMu6Vgwjg/wkRNnFZt+aKq09Sm1SMfDb421fIfb/aER
4jXyreOCzSB5VesVDruV86zjeuB+CKZOUoMnrXbUoZqT+OwZ+DSRLm359+vGczip
/h/hJZpKh8UUBjKCH5rdrxl3j3uE5JR15VLUXsZkIpUsQ1O+Gdoy3m0uRQphcOSn
7ldeMxP4QXUwhogPocaWAFYV1qBR2LyOEP2jAEfhd5erFimnibmB8BvgoPo2zo2i
pwE8XJtHuqozQUFzHb0/pHWedYYYd453ly79wPCAGW8EhrFyufvhYpNGQb3B1akx
FrGp5RiVjy4b4hlecL/itqRM7V6c31y7y7VAocyyAw8qnYBALX6L1aM/Yd7SysL3
rPC8zg/g/mbwa1AWmRAliV2PntOlPfKPGfSigncOU9D7aIfpcNGAb4+Qi+mg7ylp
gu8NnHGLs6GU9IaC8zQNZN3OoV+f32j1um15rnp5+gBwaK8z9nwEg4H5IdLXEgug
tOKBsw98+xdv2ZrcWvl4
=Yp1T
-----END PGP SIGNATURE-----

--nextPart14340448.NX9F9Fvt01--

