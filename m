Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun, 12 Sep 2010 22:43:59 +0200
References: <1284317791-4744-1-git-send-email-segooon@gmail.com>
In-Reply-To: <1284317791-4744-1-git-send-email-segooon@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1580855.oHMeUH8upn";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201009122244.00861.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] staging: batman-adv: check kmalloc()
	return value
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
Cc: devel@driverdev.osuosl.org, Vasiliy Kulikov <segooon@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>, Marek Lindner <lindner_marek@yahoo.de>

--nextPart1580855.oHMeUH8upn
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Vasiliy Kulikov wrote:
> kmalloc() may fail, if so drop current packet.

Thanks for your patch. The indention is right, but it adds just another bug=
=20
(locking related).

> Signed-off-by: Vasiliy Kulikov <segooon@gmail.com>
> ---
>  Compile tested.
>=20
>  drivers/staging/batman-adv/routing.c |    6 ++++--
>  drivers/staging/batman-adv/unicast.c |    8 ++++++--
>  drivers/staging/batman-adv/unicast.h |    2 +-
>  3 files changed, 11 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/staging/batman-adv/routing.c
> b/drivers/staging/batman-adv/routing.c index e12fd99..e545260 100644
> --- a/drivers/staging/batman-adv/routing.c
> +++ b/drivers/staging/batman-adv/routing.c
> @@ -1232,8 +1232,10 @@ int recv_ucast_frag_packet(struct sk_buff *skb,
> struct batman_if *recv_if)
>=20
>  		orig_node->last_frag_packet =3D jiffies;
>=20
> -		if (list_empty(&orig_node->frag_list))
> -			create_frag_buffer(&orig_node->frag_list);
> +		if (list_empty(&orig_node->frag_list)) {
> +			if (create_frag_buffer(&orig_node->frag_list))
> +				return NET_RX_DROP;
> +		}
>=20
>  		tmp_frag_entry =3D
>  			search_frag_packet(&orig_node->frag_list,

You must spin_unlock_irqrestore before you return from that function.

Best regards,
	Sven

--nextPart1580855.oHMeUH8upn
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMjTuPAAoJEF2HCgfBJntGO/sP/3Z4RUEiVlcraL7QtwzyTEUr
ixxT4ZvoX9qkVvyJQA7xpU5eKHNI98GjbrJ/cbkmxIU0OT9kGwRTlZDVadgKpA9c
jfdyz908wAZrfevLnjybMtnfHnYL0IWUWLETgSS1GiPq5zsZkb0lp0FSPktYE2nt
/vMZURL0oRTkpIOqTdPjqwBKWy1nzEbpVdbzPpSBI+sTxKu2DiO6KTpqzEVw8b1+
grjGjoCIcft1B5XQ6FRdwKvddxvDGuoKMox/JqkDTqvpL9Iza6daCXf1nTUTNwoD
vCbRkI49VKPjeYpAu+6qxtqBu5Hlv1kmeWgcc6Ml1RPd0F9DgeG9cFzp0DgYNP9W
O8KpoiXzjxT2WO5TVtJUThU5bgC6D36/z6z6omujkoUUgDiCxDlUvOgTs5VRhs5D
NQsTW0vxP3S52+oFYZJNcpj7csmpHWIqDTQ6BQZTDls9m5jS47IYoZzyeepRsUDb
pk7em5A20C9GDKhO8dOlNShU2ws2t7ylsU2OqO93mJwcY8TH3Tzf3D1otxCElp+J
An33yvFaGdHmt/zS7q7hMYXVApT6N/8KWXZLYqxCC1NOz19yrfKTSp5EP13MuRPm
o/lrEL9VZ1QKXBZyHQ8dJjw/BusVHB1lJ/pj4vtXIerVBDPnqvMq07ZaWtuXz2Zh
Nx0Q/+uWqk6hSGTrufRO
=4L/4
-----END PGP SIGNATURE-----

--nextPart1580855.oHMeUH8upn--
