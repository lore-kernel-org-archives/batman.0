Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 21 Aug 2016 08:47:28 +0200
Message-ID: <1483845.W7oKTuDr2p@sven-edge>
In-Reply-To: <20160821032534.11074-1-linus.luessing@c0d3.blue>
References: <20160821032534.11074-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart13145420.oLnsMXk0r1";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH (maint?) 1/3] batamn-adv: fix elp packet
	data reservation
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

--nextPart13145420.oLnsMXk0r1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sonntag, 21. August 2016 05:25:32 CEST Linus L=FCssing wrote:
[...]
> @@ -334,8 +333,9 @@ int batadv_v_elp_iface_enable(struct batadv_hard_ifac=
e *hard_iface)
>  		goto out;
> =20
>  	skb_reserve(hard_iface->bat_v.elp_skb, ETH_HLEN + NET_IP_ALIGN);
> -	elp_buff =3D skb_push(hard_iface->bat_v.elp_skb, BATADV_ELP_HLEN);
> -	elp_packet =3D (struct batadv_elp_packet *)elp_buff;
> +	skb_put(hard_iface->bat_v.elp_skb, BATADV_ELP_HLEN);
> +	elp_packet =3D (struct batadv_elp_packet *)
> +			hard_iface->bat_v.elp_skb->data;
>  	memset(elp_packet, 0, BATADV_ELP_HLEN);
> =20
>  	elp_packet->packet_type =3D BATADV_ELP;
>=20

I don't get right now why you did the of split the skb_put into two differe=
nt
"ugly" lines (skb_put + the elp_packet assignment without elp_buff). I fear=
=20
that this weird (non)-alignment you've created will bite us when the patch =
is=20
submitted upstream.

Maybe you can tell us more about why this removal of elp_buff is necessary.

Btw. please use the prefix "batman-adv" in the subject and not "batamn-adv"=
 ;)

And it is at the moment not important whether it goes into next or
maint. Both will be submitted by Simon to net.git because we are currently
completely off with our timing (compared to the upstream submissions).
I personally would go for maint.

Kind regards,
	Sven

--nextPart13145420.oLnsMXk0r1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJXuU6AAAoJEF2HCgfBJntGpE8P/2tuYA2tsGbGPlDE1Q9IV8Rm
gWTIWb8jZKM6c7wn78pEIru0ff/u0AZwfqnkA0RhFhGJJ4QB/ut71H2UIPkHx/8c
jbAojQxiYcPd6xQt9opFAwv+0W7Jve05ETFTn+BXMQbosHlDDuS9dlSxeEqtj97p
D14ORWcTz5fALTgFUgFMFwKeFKfG+0cDmXE036KJS1dHP3mYws5JcB5rnfXOe++o
WbVYoQUO4VvZW3eRx8Xib3kncCXLuiHH0PIfS0Idl2GKa72mFbcRwPGsdJP8aGt6
CrlobFlZdkuVi9WYbdkVY5ZDplRRm5YfaOyQcvAJSv9YoiZqA7D26UCA5YjEHv9s
u/N6AsNLijSFCvIHJE4GmOSXkXN8IN5TzTnyPOQFcke92Tw8GM+GUbnX716h0Mx5
3F4OewsmkKAleZNR2vLuABvHJT/VPAmH1VqoiwKgbz6ngV7StT8i9xRNEklrLChb
8+Z6nMeIewtwY14pQ+qOym6r01US806p8R5c36nIKN7bICQC1uo6qWjCPwv5y7Lz
ZUENR87oAjTrpY2taRkSugxqxRIdyqcriIHnsNuQfZ+n/8jAWb0JQQIlIij/qfV5
tE5WPsPIprlRfV4WGXMNWWsS+AMVxlzPoECqX15wtUzKry8y5YaVK+cXo0oXgy2F
7YPZL9VOycJ8PMoHiBXW
=uqbq
-----END PGP SIGNATURE-----

--nextPart13145420.oLnsMXk0r1--

