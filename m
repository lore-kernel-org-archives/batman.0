Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 02 Jul 2016 09:40:28 +0200
Message-ID: <10954700.qxK432G6xk@sven-edge>
In-Reply-To: <1467432591-28023-1-git-send-email-linus.luessing@c0d3.blue>
References: <1467432591-28023-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2155296.GIduKFuHgn";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Add wrapper for ARP
	reply creation
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

--nextPart2155296.GIduKFuHgn
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Saturday 02 July 2016 06:09:50 Linus L=FCssing wrote:
[...]
> +
> +=09if (vid & BATADV_VLAN_HAS_TAG)
> +=09=09skb =3D vlan_insert_tag(skb, htons(ETH_P_8021Q),
> +=09=09=09=09      vid & VLAN_VID_MASK);
> +
> +=09skb_reset_mac_header(skb);
> +
> +=09return skb;
> +}

vlan_insert_tag can return NULL when an error happens. Thus simply doin=
g
a skb_reset_mac_header on it without checking skb's value for !NULL is =
a
bad idea.

But you can simply move the skb_reset_mac_header (when it is really
necessary) in front of the 'if (vid & BATADV_VLAN_HAS_TAG)'.

Doing it in front would result in (written as absolute values - in
reality mac_header is an offset):

    skb->mac_header =3D skb->data
    skb->data -=3D VLAN_HLEN
    skb->mac_header -=3D VLAN_HLEN

Writing it after the vlan_insert_tag would result in:

    skb->data -=3D VLAN_HLEN
    skb->mac_header -=3D VLAN_HLEN
    skb->mac_header =3D skb->data

Both calculations should result in skb->mac_header =3D=3D skb->data

Kind regards,
=09Sven
--nextPart2155296.GIduKFuHgn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXd2/sAAoJEF2HCgfBJntGVQ0P/1VnQUDQfYf6hrMT1+jz4sS8
Dcr7X/plZObHNQqLzHONi2Ob8kdBAf3/qHJYVFhqEYeonWX9UV4XlTePI+0BMJt3
KxluavGAR1r2adqSu2+hnF7Tp7KeZ6xRwDEb5Wxir2jcsG9DrLD2A8fxMIyTnZ3k
xzcZsxTlGOBFlTxmwdEHJnltksW1KA/xIHJRaJlafwljhfUR0HMvmaSAl2AzkzxO
Sh4UkTX3k+tH6ZtcXPNfxkkeByoar553bjBUpwzQg1/Em3joIsdNKbtmCvhZOlJP
MW+IqXqO24+wmaOxlD/bQE+WZccLOrfnHL6CAub3GmV/qMM9mg7Xhur1VXES/Ge5
5nxvcBLJu8ptCrh8XCYxMY2zljEaQOyV1ibjW8D3zgMB5ONZpVrL8+Aen4tZC42S
isKxwOq8e8Ke5lsVjDrt9pN1uLi4hMxNabYOIsVtVf/FT5fMTX6sjK0oo3GHli0H
GN3wX7e99A2w4N5EI3KmYEERQb2D/TgBqwGJTCwUGZkQ4OuLATM4dNOBXXvc3kbt
WlGA/qT9BqSewNJg+gpLkkGrL2lCmNN11sWHTrCXdtkkwh5aAHAxbYtYHYaqR1HN
EVb+h7E8YYQeY7A8V7KPB3+IAz3IB22pZlqp3ZoCig6gGu+pG+MGvYsYEv76HVip
n2ikeD2inT0O7FB7UjgD
=pmwO
-----END PGP SIGNATURE-----

--nextPart2155296.GIduKFuHgn--

