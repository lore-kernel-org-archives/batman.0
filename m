Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 26 Jan 2011 16:02:32 +0100
References: <1296052208-6041-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1296052208-6041-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1296056402.ubY8xGh7Z5";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201101261602.38873.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: add raw wifi packet
	decapsulation support
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

--nextPart1296056402.ubY8xGh7Z5
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Wednesday 26 January 2011 15:30:08 Marek Lindner wrote:
> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> ---
> +	buff_len -=3D PRISM_HEADER_LEN;
> +	packet_buff +=3D PRISM_HEADER_LEN;
> +
> +	/* we assume a minimum size of 38 bytes
> +	 * (802.11 data frame + LLC)
> +	 * before we calculate the real size */
> +	if (buff_len <=3D 38)
> +		return;
> +
> +	wifi_hdr =3D (struct ieee80211_hdr *)packet_buff;
> +	fc =3D wifi_hdr->frame_control;
> +
> +	/* not carrying payload */
> +	if ((fc & IEEE80211_FCTL_FTYPE) !=3D IEEE80211_FTYPE_DATA)
> +		return;

Didn't we say yesterday that we must either use ntohs or only read the firs=
t=20
byte of the framecontrol? The last option which comes to my mind is to defi=
ne=20
IEEE80211_FCTL_FTYPE and IEEE80211_FTYPE_DATA for big and little endian=20
independently.

The same for
IEEE80211_FCTL_TODS 0x0100
IEEE80211_FCTL_FROMDS 0x0200
IEEE80211_FCTL_PROTECTED 0x4000
IEEE80211_STYPE_QOS_DATA 0x0080

Your current version should only work on little endian systems. I would=20
suggest following version:

#define IEEE80211_FCTL_FTYPE 0x0c00
#define IEEE80211_FTYPE_DATA 0x0800
#define IEEE80211_FCTL_TODS 0x0001
#define IEEE80211_FCTL_FROMDS 0x0002
#define IEEE80211_FCTL_PROTECTED 0x0040
#define IEEE80211_STYPE_QOS_DATA 0x8000

fc =3D ntohs(wifi_hdr->frame_control);


> +       if (fc & IEEE80211_STYPE_QOS_DATA)
> +               hdr_len +=3D 2;

Here are you testing only on bit. Are you sure that the other 3 bits aren't=
=20
interesting? At least one combination isn't well defined by the 802.11=20
standard from 2007 and some others are null data types.

Best regards,
	Sven

--nextPart1296056402.ubY8xGh7Z5
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJNQDeLAAoJEF2HCgfBJntGt9EP/1+3lPetHTXAi4tH1yySirvt
Hfh3Aknerk5J766BIryhtR5+I7aECh6CseNOPftFdL1xr+hnNSQ6fy9YwVxpyhnZ
af8IEgTS9VaZV8VRY9jIMr+4HuERYSPUkQTBYjs12W43Lz6xfi6w479f6CU1rJJK
53ntoDuENtcH+L1FkymIbR19dbIjudFb3a72n47dpH3VVRl7x7RsgHYu0f7VpU/o
yBHBX623qoxLQYbbXwkGdLgGe5Vd4YlU6CDRCW6khhTq9WyIkYcd2VDK15IkeDmU
TioaoAWPqITf/51b1HfX6YCSa4dly3VEea3dqJi5nTvIwJtFGjQsggdYYyKvo3dj
XnyV26Ic7zubZjkjXIB3p0rY0+HnUFkvgpO/aeakzewwPKxcrOaMH6bvHVTwRNMk
ihgXy2ZiOmRqCI8eekVY8aHE1avWZtFcw9ud/ELbdwvUV8Hc760vuVrrQn0V/fZj
pwYYlpaD+juiHgbllqo+5TMzbEJZnR4y2s5FUj5A7VGR1oBeOSOD7fxjpwu4DNVy
3l5NgVBaxETqaFuDom70sx8zoHtgJcQaVpU5O/hK6O9S37d4fq2GJU2sPb6AuWH+
lmwGIvaibpq1lG5xiXudELRfSTwBlGhuMPyTUjoJPDfBMbVJypwy1lwdShuXvyzE
wFl3QotkK4END3tAnieV
=6pKJ
-----END PGP SIGNATURE-----

--nextPart1296056402.ubY8xGh7Z5--
