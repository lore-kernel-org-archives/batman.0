Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 07 Nov 2012 20:17:08 +0100
Message-ID: <1403033.aGBWZgaJ6z@sven-desktop.home.narfation.org>
In-Reply-To: <1352315502-20324-4-git-send-email-ordex@autistici.org>
References: <1352315502-20324-1-git-send-email-ordex@autistici.org>
 <1352315502-20324-4-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2955775.Cma9ToWc4s";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 03/12] batman-adv: add UNICAST_4ADDR
	packet type
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: netdev@vger.kernel.org, davem@davemloft.net


--nextPart2955775.Cma9ToWc4s
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Wednesday 07 November 2012 20:11:33 Antonio Quartulli wrote:
> +/**
> + * struct batadv_unicast_4addr_packet - extended unicast packet
> + * @u: common unicast packet header
> + * @src: address of the source
> + * @subtype: packet subtype
> + */
> +struct batadv_unicast_4addr_packet {
> +       struct batadv_unicast_packet u;
> +       uint8_t src[ETH_ALEN];
> +       uint8_t subtype;
> +       uint8_t reserved;
> +       /* "4 bytes boundary + 2 bytes" long to make the payload after the
> +        * following ethernet header again 4 bytes boundary aligned
> +        */
> +};

This doesn't work as you think. Now you have 2 extra padding bytes at the end 
of the batadv_unicast_4addr_packet and therefore make the payload (IPv4 
header..) after the following ethernet header again wrongly aligned.

Kind regards,
	Sven
--nextPart2955775.Cma9ToWc4s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQmrO0AAoJEF2HCgfBJntG4MkQALhMzDQi+skMtKKX5xovkX53
61eeGZzwDUzhiV6z4YIsCVErZDb9kvTUYHD7hbeFHJcwCcGTIKBONH1IOetlD+cs
aM+fGA067U+x62V1V1TGMwz+mJ/wHFEnj4EGlAS9Xm5D2e22Wo1v1LlCaKCtS6Bp
CMEPOljXIMIs/dFfYK+DgV0U96eAA1ZyerkU8zlTgFqEetP2P1GhLUOh3F7ZFNmn
XRM+eJULUv+uQQm3UsbIglW0pg+5Ir/znjPebRI4G76NM6p/Qj2EbL+FLLfRjysN
L8eY2ExCsvXql0ipbILUTZLyiaS1q/wUksaJLTe2xe4jsaYGjoDqdFb2xq65L6ng
Cj23nQXTQKJhgZv6/ZourtcMAmfJpDpmTbJOyjj2AQlemD0bW2Nhe6jG5tZIMKv1
nl5ZfXnAlRDn2WypkxPJBAghLP9vQAENieO8QqLlodUR03SjjccyvuRruRWteGYZ
DMTHORVvLgFghr0SPfS6Ibg9UZTuBKZJSNfrQ+YzGVwDAzKoWfmqvhoJYpVsSvuz
xw3Zqh4dAQRZ++yTO16lMb/CPI4RColUTEZCfdTXQYXknlU5RILWJY06n7BLW+qd
f9NQgLfh3Eyu9+hf/tB3CaOOWAXPPlA+Cd+GefBaWLNKnT1PpOrjpPUMW4i8O+9c
nDht8TrMfYwynb3030ZS
=DSr6
-----END PGP SIGNATURE-----

--nextPart2955775.Cma9ToWc4s--

