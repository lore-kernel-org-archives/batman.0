Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 1 May 2010 15:33:39 +0200
References: <1272719410-406-1-git-send-email-andrew@lunn.ch>
	<1272719410-406-4-git-send-email-andrew@lunn.ch>
In-Reply-To: <1272719410-406-4-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4040009.B7kLr0Ti5o";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201005011533.41592.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/4] batman-adv: whitespace fixes from
	mainline.
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
Cc: lindner_marek@yahoo.de, b.a.t.m.a.n@lists.open-mesh.net

--nextPart4040009.B7kLr0Ti5o
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Andrew Lunn wrote:
> The mainline driver has some whitespace patches which are not in
> maint. This patch brings imports them.
>=20
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Please be aware that this one conflicts heavily with=20
 * [PATCH-maint 1/2] batman-adv: Fix whitespace problems criticized by chec=
kpatch.pl
 * [PATCH-maint 2/2v2] batman-adv: Reduce max characters on a line to 80

Only following part seems to be new:

> diff --git a/send.c b/send.c
> index caec6ef..8413ddc 100644
> --- a/send.c
> +++ b/send.c
> @@ -128,7 +128,8 @@ static void send_packet_to_if(struct forw_packet
> *forw_packet, if (batman_if->if_status !=3D IF_ACTIVE)
>  		return;
>=20
> -	packet_num =3D buff_pos =3D 0;
> +	packet_num =3D 0;
> +	buff_pos =3D 0;
>  	batman_packet =3D (struct batman_packet *)
>  		(forw_packet->packet_buff);
>=20

Best regards,
	Sven

--nextPart4040009.B7kLr0Ti5o
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJL3C20AAoJEF2HCgfBJntGNWIQALIOGNV4cnZopwd41gQzKC2i
xa4xjXWNnpYTjImUQLDQ1tBYyX8saUVcUVk5TOvgxwVSup3g82+0Xcejam+Y6Bq/
mOphIGYnFkwk3/164a5xQeAVohDzDM7AiuxWxz2DixDFRPqwN7aoV8nR9APmfWXs
M2JEIFLakI80KCSJ/GFwx3foKpvH34CbFjXO1qnAkSGmZGQFDTd8c8gJ1HriwdIw
kITmBk8kHok5MbIsX5li2oUma0RBv+P2b8hqocxhxvF4hAp8c0VFMvVBPfhbzBqD
dhU4Tb/lMj8VIeH0+Q8zL0LnUKmt39cK2tiply+akSX/+qAMXP1m5ztLfYA7nDCH
g8ktYC6ZXm2oh8Im4CMjL3qXCPbQ84YOlm9NDyAaHzhXdnigUO2PXAMhLFw9BJoK
A4bHiblaRxOytNIk51PTgzZux3dahdmCcxLzp5LcG5QvKYVlknWe7q9gFALMhPNG
jt5rGKmI6s0riQcCZSyTN3T0f46cYaYYcFzr5OHM0hiuMxYDKc3mlNNalaEDJ/hd
bfwFueOPesp3TkaF9xXvZ0uuqsJNX5Tb4FLNjzJ5m3s8DF8R5eDexqEJegnBHV5I
mAy0KKznr3ENAnUtVgDDmtQQ2ImKnHWvwc0MjOiBGpvKw1MwSSdaRjMrp6bveXK8
zp1Cy0eldU/BoqQRjo6R
=aOLr
-----END PGP SIGNATURE-----

--nextPart4040009.B7kLr0Ti5o--
