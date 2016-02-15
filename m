Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 15 Feb 2016 09:18:07 +0100
Message-ID: <2708667.9PEbVjxvIc@prime>
In-Reply-To: <OF4C91F5B8.1DBDF49E-ONC1257F57.004C552D-C1257F57.004C60E3@phoenixcontact.com>
References: <OF4C91F5B8.1DBDF49E-ONC1257F57.004C552D-C1257F57.004C60E3@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1963681.RgNP8UenBn";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 4/4] batman-adv: free skb when dropping
	broadcast packet received from another backbone gw
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

--nextPart1963681.RgNP8UenBn
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi Andreas,

On Friday 12 February 2016 14:54:15 Andreas Pape wrote:
> From 1cf69fc5b7ffac3193ad8fa4439586c865c5acab Mon Sep 17 00:00:00 2001
> From: Andreas Pape <apape@phoenixcontact.com>
> Date: Fri, 12 Feb 2016 14:00:53 +0100
> Subject: [PATCH 4/4] batman-adv: free skb when dropping broadcast packet
> received from another backbone gw
> 
> skb should be freed in batadv_recv_bcast_packet if packet shall be dropped
> due to
> reception from another backbone gateway of the same backbone.
> 
> Signed-off-by: Andreas Pape <apape@phoenixcontact.com>
> ---
>  net/batman-adv/routing.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
> index 4dd646a..128ed28 100644
> --- a/net/batman-adv/routing.c
> +++ b/net/batman-adv/routing.c
> @@ -1104,8 +1104,10 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
>         /* don't hand the broadcast up if it is from an originator
>          * from the same backbone.
>          */
> -       if (batadv_bla_is_backbone_gw(skb, orig_node, hdr_size))
> -               goto out;
> +       if (batadv_bla_is_backbone_gw(skb, orig_node, hdr_size)) {
> +               kfree_skb(skb);
> +               goto rx_success;
> +       }

I disagree. In the original code, we return NET_RX_DROP, which makes the 
calling code already free the skb. Check batadv_batman_skb_recv() in main.c. 

Cheers,
    Simon

--nextPart1963681.RgNP8UenBn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWwYm/AAoJEKEr45hCkp6hlDQQAIsuZQZn0Slj/CYqq8bgkDn4
DKUheTFs8cmQTFyAldCltItjfZHM9HJ2FsGkRUMbWBrwT17x4kpq7cSLOUAunsPi
kJMWF43iGrNvL1wZUEcoUkU2dnDeswZiIBDUBpYE62myRcAXTgi0aRt4twpvFH6A
t2Gt+iVHr69Uhcwy62voLfVoWrtxvy0v1C/6XUbmpJg+YOjzFNgQ1iGHgYeXaOOD
oBBZjzhUfVzPqVt1xeHpcnvfBFIEviUSvs+WaEhuOlkxXNCokrzFD3+Z9Vz1jidx
VBnsY6TnO0zTH8ME6fEKF30SNQ6/L3aJICTHPCrAX5hyq49zhPAHgDFAYZEGduQZ
UBm0u5TJo7Wnjij1uyFh2ZMHyCDWkkS0y6CEZiI70F2IxbnwD4Sv5WVmU8i/VcCB
PymTPuXrmmQgl+OXPivTNoNb+36mvTL10lZt7Fnn+Zj398aNm7R3IjiVtmFtxGOO
+hVv7lGzs3uODdW7Uf9YBjeOPZWevullJoiED+kvUey7T6ZJ3weJ/90cUm6DPt1b
VEZu18B8EAqeOW/gq6ux+x4rvxoHm5cQO+9Xjwd5jYMtd6ZXBjtv4yqUIWJdKfln
57Tx+/zrTj9LAbqor57wLJw2vOOBbQHCVGAT84sk53NnmNb6nEaEIRZIEqK4OFiH
H/PuCeBL3E7ZVhFgpzyt
=mxTM
-----END PGP SIGNATURE-----

--nextPart1963681.RgNP8UenBn--

