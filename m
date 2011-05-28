Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 28 May 2011 14:07:10 +0200
References: <1306572183-25950-1-git-send-email-sven@narfation.org>
	<1306583129-4854-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1306583129-4854-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1705626.eKNDhyNvZM";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201105281407.15153.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH-marek] batman-adv: Unify the first 3
	bytes in each packet
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <lindner_marek@yahoo.de>

--nextPart1705626.eKNDhyNvZM
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Saturday 28 May 2011 13:45:29 Marek Lindner wrote:
> @@ -99,16 +100,19 @@ struct icmp_packet_rr {
>  struct unicast_packet {
>  	uint8_t  packet_type;
>  	uint8_t  version;  /* batman version field */
> -	uint8_t  dest[6];
>  	uint8_t  ttl;
> +	uint8_t  reserved;
> +	uint8_t  dest[6];
>  } __packed;
>=20
>  struct unicast_frag_packet {
>  	uint8_t  packet_type;
>  	uint8_t  version;  /* batman version field */
> -	uint8_t  dest[6];
>  	uint8_t  ttl;
> +	uint8_t  reserved;
> +	uint8_t  dest[6];
>  	uint8_t  flags;
> +	uint8_t  align;
>  	uint8_t  orig[6];
>  	uint16_t seqno;
>  } __packed;

Why dont you use the reserverd part for the flags which are currently not i=
n=20
unicast? Then you could also remove that other align byte. It would still b=
e=20
possible to add flags to unicast packets when necessary.

> @@ -116,18 +120,20 @@ struct unicast_frag_packet {
>  struct bcast_packet {
>  	uint8_t  packet_type;
>  	uint8_t  version;  /* batman version field */
> -	uint8_t  orig[6];
>  	uint8_t  ttl;
> +	uint8_t  reserved;
> +	uint8_t  orig[6];
>  	uint32_t seqno;
>  } __packed;

Wouldn't that lead to an unaligned seqno?

Kind regards,
	Sven

--nextPart1705626.eKNDhyNvZM
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJN4OVxAAoJEF2HCgfBJntGoFQP/iapuP3go73Vh/cMDKTaLKOY
hVNPBWNATJmeKAJcNcHrPD6zxVLPuDnqXYya2cA64Q0EcLYg4mUK6ZtePLObnKGw
GjahULH450yZBZlcz16SKwb7UIXdZX/mn1n5u4zLpGtGM+mW/CSfO06YIlqOTd0R
n4wtliWoTHhh13qsFegrHp5VaeVoYKiqPDL2nIXpQ3BNVbHlMZRKqDWQlTstWswk
l0i0phygR/dU92DMZ4b34iMDa8kMeqFDjJzQ2GWyaOWBcHiZuXST/BhOOW2HZyRe
PIVbB4LdA7L0rE7Trqvu99wtNksqOmJHmeLPQD+zOtMVvO4dDX5MVdIqZBcrv3y9
A7qVOBX32ss38FPrZHtx9vlbt8/wolrdI4u4YmYIVvU4b/OeQ0nnaSh2Ansbf7+Z
s0aZi8ofry1EnwDQShLgdlaSX7Fzpg7MXJMzwsz7KmQkN/Tq6trbeth9nO7daO2G
3/1fbObi57jTJaKk+QCZcvhzN6C9E63hqrc0wbFJQCCw7ti4Zf5cHrBFlffSd3CZ
UVCGGoIse8BVXh93p8lqVPdurFaZv157sTP5ERp7vs+UtuMGlTv8spS4VkVNtCRL
PT43ndTrQAg72nvx7MC3ZWuW3yL0trpf/0vswa2wea5Gpp1LAABF6YiaF452NDyh
rlpPr5uqFtSvHfdQVUp9
=osfG
-----END PGP SIGNATURE-----

--nextPart1705626.eKNDhyNvZM--
