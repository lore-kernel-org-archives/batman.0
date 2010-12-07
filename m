Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 7 Dec 2010 15:51:21 +0100
References: <1291732778-27441-1-git-send-email-linus.luessing@ascom.ch>
	<1291732778-27441-5-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1291732778-27441-5-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3006143.ukOigRsXH1";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201012071551.31575.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 04/10] batman-adv: Send neighbor
	discovery packets
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
Cc: Linus =?iso-8859-1?q?L=FCssing?= <linus.luessing@ascom.ch>

--nextPart3006143.ukOigRsXH1
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tuesday 07 December 2010 15:39:32 Linus L=FCssing wrote:
> +	memcpy(skb_put(skb, packet_len), batman_if->ndp_packet_buff,
> +	       packet_len);
> +
> +	send_skb_packet(skb, batman_if, broadcast_addr);

> --- a/types.h
> +++ b/types.h
> @@ -47,6 +47,7 @@ struct batman_if {
>  	struct packet_type batman_adv_ptype;
>  	struct net_device *soft_iface;
>  	struct rcu_head rcu;
> +	unsigned char *ndp_packet_buff;

Good way to never get included in the linux kernel by David S. Miller.

Best regards,
	Sven

--nextPart3006143.ukOigRsXH1
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJM/knqAAoJEF2HCgfBJntGoZoQAJ9YM+BDxNGjSFiWznJpqDiI
IUJSjhqwxXEMMQH14Kdfd4wwBhp02wGELdFkReeOHHXBUiKyG4hoV3KC5vWvkQXQ
evGuZHUdfNyvHsGTLesjL6tt682dKKCgFNvbNIwV/6n1vaL+PqxRVr9CLn0zTI9l
/KHZ2pxDdw3rKkUK9TuP+gJb4c5Ea6esQzAxj+h4MhQQ/BiUxi1dc8+bvs0fvDvs
rqettM1WD3U7yNkf9jUPDKl9mFRhQg3xc1KyU0S3UuisfS7oDO9M23XF2Y1YfoZ3
djelUFKTsz9pDsICNrJtX01uV5sqnYQ6Lx8WI5GIZKFP76NVMGl8cVb+r8Jq0Yad
2OwpvjdVTluNhOYiq4fW29Xm+SClWI+y2V2+z2JzpC9eVHKPacNFsUMYI87HVr3j
Glof5sG5YcOSDUifaLdbkpiCj3+nkeQjCjvl1gDnU5W3/S0kEu6Cy3vWOXhrWslG
h7Yw4DaX5iszE3A7Ph1A0UKSitNxeZ/vXEo4zRKMWcyiPHWweRAiX/CaBo4UMF1K
9A0FEqO493vNHCwGtlu15tNbfkVc7NgV9CpCdLidtlVefTyg7seqrgTIY+JxkuRO
nSf8NyXumaQEkaYWjcLAhPGJWzRQUguc/vlyh20tCiLBv+Fc3SIq2jdjHlR8+SpG
FIjuMPbcHWD3GuM9NvlA
=S6Sk
-----END PGP SIGNATURE-----

--nextPart3006143.ukOigRsXH1--
