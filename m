Return-Path: <ordex@autistici.org>
Date: Wed, 8 Feb 2012 20:53:03 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120208195302.GF21844@ritirata.org>
References: <1328727958-16119-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="84ND8YJRMFlzkrP4"
Content-Disposition: inline
In-Reply-To: <1328727958-16119-1-git-send-email-martin@hundeboll.net>
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: Add filtering of OGM messages
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@hundeboll.net>


--84ND8YJRMFlzkrP4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Martin,

On Wed, Feb 08, 2012 at 08:05:58PM +0100, Martin Hundeb=C3=B8ll wrote:
>  static int route_unicast_packet(struct sk_buff *skb,
>  				struct hard_iface *recv_if);
> @@ -259,6 +260,10 @@ int recv_bat_ogm_packet(struct sk_buff *skb, struct =
hard_iface *hard_iface)
> =20
>  	ethhdr =3D (struct ethhdr *)skb_mac_header(skb);
> =20
> +	/* Packet is filtered by user */
> +	if (filter_addr_drop(bat_priv, ethhdr->h_source))
> +		return NET_RX_DROP;
> +
>  	/* packet with broadcast indication but unicast recipient */
>  	if (!is_broadcast_ether_addr(ethhdr->h_dest))
>  		return NET_RX_DROP;

nice infrastructure :-)
But dropping the OGM at this point, doesn;t seem to be a good choice imho.
Actually the first OGM will pass through (because there is no orig_node str=
uct
to check for filter), then all the other OGMs will be dropped up to the orig
purge timeout. At that point the orig_node structure will be deleted and so=
 we
will have another OGM passing through and then a period of silence.

I hope I am not wrong :-)

What about moving the filter operation so that at least the last_valid fiel=
d is
updated? Another option could be to take a different approach..like letting=
 all
the OGM pass through but skipping the orig_node when checking for a possible
next-hop...

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--84ND8YJRMFlzkrP4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJPMtKeAAoJEFMQTLzJFOZFL2UH/iq23ClB4JJgrCzSGnR5KdEE
RIH+a0DhosCJ1Qbt2xiUH46aIYXE1btQ/0FIiAzY/uC7MrnGbaUySaEs+GAwfWf4
wJy3PUIPgAfDyWqI6FeEYeS35Ux4HFP9Svso/ZKleGfxp0gzM6pWBnTrZJkLm7BS
3lqMsidqgVtdE1o2CsykZq1HCgjlpugsVXR/azgz8EFTbbTBSoP0SryX6/hjUzyE
qoWnA4Tn1ji4EWFdzwvaEFbhF5DGVNlhplpfSUF3a2kwl3tS33iLhlHj/VdElWpE
UuzVGuQ8RrB5fHvAjMtRXFOlH8S6jISkFpNoMQskFrqNxdP00wA/Onc/LdE3xGw=
=tUnl
-----END PGP SIGNATURE-----

--84ND8YJRMFlzkrP4--
