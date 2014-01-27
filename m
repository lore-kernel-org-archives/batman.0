Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 27 Jan 2014 15:38:12 +0800
Message-ID: <2269233.xVshGbV36T@diderot>
In-Reply-To: <1390166566-8315-2-git-send-email-linus.luessing@web.de>
References: <1390166566-8315-1-git-send-email-linus.luessing@web.de>
 <1390166566-8315-2-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2222268.EQQIIRZXsa";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv6 1/2] batman-adv: use vlan_/eth_hdr()
	instead of skb->data in interface_tx path
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


--nextPart2222268.EQQIIRZXsa
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sunday 19 January 2014 22:22:45 Linus L=FCssing wrote:
> Our .ndo_start_xmit handler (batadv_interface_tx()) can rely on havin=
g
> the skb mac header pointer set correctly since the following commit
> present in kernels >=3D 3.9:
>=20
> "net: reset mac header in dev_start_xmit()" (6d1ccff627)
>=20
> Therefore we can safely use eth_hdr() and vlan_eth_hdr() instead of
> skb->data now, which spares us some ugly type casts.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@web.de>
> ---
>  bridge_loop_avoidance.c |    2 +-
>  compat.h                |   11 +++++++++++
>  gateway_client.c        |    6 +++---
>  send.c                  |    2 +-
>  soft-interface.c        |    8 ++++----
>  5 files changed, 20 insertions(+), 9 deletions(-)

Applied in revision f9170f2.

Thanks,
Marek

--nextPart2222268.EQQIIRZXsa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJS5gzrAAoJEFNVTo/uthzAamQH/iCejdotEvS263vEfUjMXhK3
C2bnoHYtgMyA6xEyUH9ZjfVtPJEvn3Ss+sa1cwh5oIDVmM+UjQxH3EBRbdwH2djg
hNkUb2jOb/Y4v3MQD6heRNE1BXNxDaw0tJzZraF5IhbPhPdiYVLLRnDKT68wVqN/
g2q5AWX8M1IXQhyiVyixwRZ6zk+97WDd3mPs+MPcqXdZIvKJOeggV5Yq91vYeo40
dmAqHCv+3RXztKwMNxA19w0k2q01z1Ca2ma2577UpAPgQAmSnsYWdjNRw0MMe3w8
V0MtenuIzmwF3P8XMoUSvikGATc2xOpVhnap+DJ62M9yae68FJR6Yxd+/loTPw4=
=GuD5
-----END PGP SIGNATURE-----

--nextPart2222268.EQQIIRZXsa--

