Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 24 Feb 2014 08:36:45 +0800
Message-ID: <1702820.sOKJFjBZI7@diderot>
In-Reply-To: <1393196418-4001-1-git-send-email-antonio@meshcoding.com>
References: <1393196418-4001-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart51603874.ox4S7XNOsT";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix merge resolution
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--nextPart51603874.ox4S7XNOsT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 24 February 2014 00:00:18 Antonio Quartulli wrote:
> --- a/send.c
> +++ b/send.c
> @@ -255,8 +255,8 @@ int batadv_send_skb_unicast(struct batadv_priv
> *bat_priv, struct batadv_orig_node *orig_node,
>                             unsigned short vid)
>  {
> -       struct batadv_unicast_packet *unicast_packet;
>         struct ethhdr *ethhdr;
> +       struct batadv_unicast_packet *unicast_packet;
>         int ret = NET_XMIT_DROP;
>  
>         if (!orig_node)

Don't we want longer declarations before shorter declarations ?

Cheers,
Marek

--nextPart51603874.ox4S7XNOsT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTCpQgAAoJEFNVTo/uthzATTkH/Azh/QX6H70Yf64Zg/vTeUZ7
UV6AJ1UuEfzElfTSTkAu97HRN71RX+Lmt8cqrZJ/MwLpINUw2GFJjENFOE24foAJ
S0GtqQlAvbVkd+fcTMPj8pkGVooYh/bOlLvuGAWRJyvBKoNu7eYF8e8P0WZryLOV
0tykCZf0bhapGsYBCX+vq8tX89GmnvKDulg6ppX5DZqij8C0rN51sWMztI9TZb8B
UzXEf06U0RzNk1m/cnsn8DycUyUsYaGdOeT9ZGNWDNkGTIEXhRnrwwBh3NtfSN6G
udXEMwI+T6XjyYQDGGwLE3DxjMApa4wQPJzs5WiI4e1A37sjGpihOFBRT766NV4=
=EP63
-----END PGP SIGNATURE-----

--nextPart51603874.ox4S7XNOsT--

