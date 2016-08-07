Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 07 Aug 2016 11:34:51 +0200
Message-ID: <2601978.hr0dLHCiFY@sven-edge>
In-Reply-To: <1470519973-22972-2-git-send-email-linus.luessing@c0d3.blue>
References: <1470519973-22972-1-git-send-email-linus.luessing@c0d3.blue>
 <1470519973-22972-2-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2026593.5zBBbKB3b0";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v4 2/2] batman-adv: Simple (re)broadcast
	avoidance
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

--nextPart2026593.5zBBbKB3b0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Samstag, 6. August 2016 23:46:13 CEST Linus L=FCssing wrote:
[...]
> * substituted fancy skb_inner_mac_header stuff with boring forw_packet->o=
wn :)
[...]
> --- a/net/batman-adv/soft-interface.c
> +++ b/net/batman-adv/soft-interface.c
> @@ -315,6 +315,8 @@ send:
>  		if (batadv_dat_snoop_outgoing_arp_request(bat_priv, skb))
>  			brd_delay =3D msecs_to_jiffies(ARP_REQ_DELAY);
> =20
> +		skb_reset_inner_mac_header(skb);
> +
>  		if (batadv_skb_head_push(skb, sizeof(*bcast_packet)) < 0)
>  			goto dropped;
> =20

Looks like you've missed something.

Kind regards,
	Sven
--nextPart2026593.5zBBbKB3b0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXpwC7AAoJEF2HCgfBJntGj04QAIG1BSs7hnoJYyKOV0k0/xjT
4hmp4JtMvDHSdkVLsEFPXPKQVC6alcar4IOv3E7dLIOiIeCo1MFyrxky35TrGOD/
+3F7A1k+gwVn/1kIQOakzMxQ1z9Y/kFS3HIoMYTDzvUIsE4/rK7woGDgsxEEyvCm
tMWLThUeWC5CC/bWSYBPtzonyf4ylPiU9sm6oM6GwEvhPur0/W5LOf+nWAxmRRn0
kLX32iyVoNSObO53JWRt225BS8Z4d6aGN4Dh+3ODnaIeUuml8yunzRcQRkkOqIP+
N8coxFXaED1eM1EH00jcYumYI+apmH+XXIcrMPT7brj7d4g5/W5OpFR0rWgxSkEh
2j3WyvHg/3eUiNRBY4JY8IxGBR3/DOwBj/AfxsYUPxsaeWqs1grvchd0wo+aAq3s
CcQwomyOLgVSMKi6yTT1OB7zChicH0MaHA6Zd4Yeyr1hJ41w1iKHWSAyYATwzOr6
QpZVq+BE0h/HgN/dmz3dU2Ke0QYMZVbKHhJDdZQpTThjVg6S3OwlGytM7zqzi27v
hJazc2jEric89j6E2ZCgzZXHOpzn1hWQvc1dbvqIUzAF3EeZqRYDja9A7VUbvNCG
0yvNKVtQ2fhM6ycS7S0MZp1px4O8gbt51/LgwCTfjEaSgVqnqeH4t1C6uRioXWFJ
aenBTuIAN9HDrbyp/0mf
=tmOZ
-----END PGP SIGNATURE-----

--nextPart2026593.5zBBbKB3b0--

