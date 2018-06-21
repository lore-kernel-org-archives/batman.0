Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 21 Jun 2018 13:17:17 +0200
Message-ID: <7091683.OAeTSXQntU@bentobox>
In-Reply-To: <20180621103555.3933-1-linus.luessing@c0d3.blue>
References: <20180621103555.3933-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2262989.yplPF9UeyN";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v5] batman-adv: Snoop DHCPACKs for DAT
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

--nextPart2262989.yplPF9UeyN
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Donnerstag, 21. Juni 2018 12:35:55 CEST Linus L=FCssing wrote:
[...]
> diff --git a/include/uapi/linux/batadv_packet.h b/include/uapi/linux/bata=
dv_packet.h
> index 894d8d2f..6a48f36c 100644
> --- a/include/uapi/linux/batadv_packet.h
> +++ b/include/uapi/linux/batadv_packet.h
> @@ -630,6 +630,46 @@ struct batadv_tvlv_mcast_data {
>  	__u8 reserved[3];
>  };
> =20
> +enum batadv_bootpop {
> +	BATADV_BOOTREPLY	=3D 2,
> +};
> +
> +enum batadv_boothtype {
> +	BATADV_HTYPE_ETHERNET	=3D 1,
> +};
> +
> +enum batadv_dhcpoptioncode {
> +	BATADV_DHCP_OPT_PAD		=3D 0,
> +	BATADV_DHCP_OPT_MSG_TYPE	=3D 53,
> +	BATADV_DHCP_OPT_END		=3D 255,
> +};
> +
> +enum batadv_dhcptype {
> +	BATADV_DHCPACK		=3D 5,
> +};
> +
> +/* { 99, 130, 83, 99 } */
> +#define BATADV_DHCP_MAGIC 1669485411
> +
> +struct batadv_dhcp_packet {
> +	__u8 op;
> +	__u8 htype;
> +	__u8 hlen;
> +	__u8 hops;
> +	__be32 xid;
> +	__be16 secs;
> +	__be16 flags;
> +	__be32 ciaddr;
> +	__be32 yiaddr;
> +	__be32 siaddr;
> +	__be32 giaddr;
> +	__u8 chaddr[16];
> +	__u8 sname[64];
> +	__u8 file[128];
> +	__be32 magic;
> +	__u8 options[0];
> +};
> +
>  #pragma pack()

Still in the wrong file. This is not a batman-adv packet type.

Kind regards,
	Sven

--nextPart2262989.yplPF9UeyN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlsriT0ACgkQXYcKB8Em
e0ZrkhAAqfQQw5WqvlIV9+ZJ5fTKM82nFxHcom7H/krSsFhqEYB7p+nWlrKnsFUZ
Dc3jIrJvOp3KmXfhzHxTjcajDyIqL7T4Az8hZy+kJNuQFNYOltHCTv33MFU2jfmc
e2hFPPdLdE8cnQaLlzeG9BcG1HKrWCL+U8bTFxOO1gKU+tJA76iJc2cruAg7Iyo7
MLY+KPXGOq3uMOlNNt6JKOba4Mpk8bF1e20aJxijny0HDIIW4ZwnvhRigDBV9/ZF
e6xXVTb0dMFhIZsEEeee69JTEy9s3aje9IxN6fJQenvLqSklIOl0aO5CiMLV5xU0
wsBb1pPpLKE010PsvD7PfTrr0IlG/rmi7abmKJk5zAe5a87Sy7gLMFCKf02kWtPj
wUdmIX+gEHXoZpkoy0KX3MZiitSWPEUb+bxZwtAZgc866wXFRTqOUcysIpcPYPzz
8pgZS6aT7I1wGOwje42Km4cQYPXiNwOIQKVKEGRtc5JPQ7cFMnHkEu5gHPF9rxvD
A9QTB6DNRTakjshFBIsYQ1Lwx2MsNhH4fIFfXX9J23vg9xsrLGKIz8lVnmpFVnKg
VnWL2dbfuxkR0XY4aUCwrFqIhnHkL7BpkYmOyf1VA4WlRweW6iwIZYQUWhl/8zOx
p5xR2eOO/B2t6b1+SXXt+WHHWHfxlb4MGdpXqJb2C0B5oaUQXcI=
=F4dh
-----END PGP SIGNATURE-----

--nextPart2262989.yplPF9UeyN--

