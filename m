Return-Path: <ordex@autistici.org>
Date: Wed, 3 Jul 2013 08:31:04 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130703063104.GE2325@ritirata.org>
References: <1372809377-32042-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="at6+YcpfzWZg/htY"
Content-Disposition: inline
In-Reply-To: <1372809377-32042-1-git-send-email-linus.luessing@web.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: refine API calls for
 unicast transmissions of SKBs
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


--at6+YcpfzWZg/htY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Wed, Jul 03, 2013 at 01:56:17AM +0200, Linus L=C3=BCssing wrote:
> diff --git a/distributed-arp-table.c b/distributed-arp-table.c
> index f2543c2..12e84f7 100644
> --- a/distributed-arp-table.c
> +++ b/distributed-arp-table.c
> @@ -1026,11 +1026,11 @@ bool batadv_dat_snoop_incoming_arp_request(struct=
 batadv_priv *bat_priv,
>  	 * that a node not using the 4addr packet format doesn't support it.
>  	 */
>  	if (hdr_size =3D=3D sizeof(struct batadv_unicast_4addr_packet))
> -		err =3D batadv_send_skb_unicast_4addr(bat_priv, skb_new,
> -						    BATADV_P_DAT_CACHE_REPLY,
> -						    vid);
> +		err =3D batadv_send_skb_via_tt_4addr(bat_priv, skb_new,
> +						   BATADV_P_DAT_CACHE_REPLY,
> +						   vid);
>  	else
> -		err =3D batadv_send_skb_unicast(bat_priv, skb_new, vid);
> +		err =3D batadv_send_skb_via_tt(bat_priv, skb_new, vid);
> =20
>  	if (!err) {

now that the functions do not return 0 or 1 anymore this check should be ch=
anged
to "ret !=3D DROP". We can't assume that the SUCCESS define is 0.

>  		batadv_inc_counter(bat_priv, BATADV_CNT_DAT_CACHED_REPLY_TX);
> diff --git a/send.c b/send.c
> index b631355..29b42fe 100644
> --- a/send.c
> +++ b/send.c
> @@ -235,36 +235,32 @@ out:
>  }
> =20
>  /**
> - * batadv_send_generic_unicast_skb - send an skb as unicast
> + * batadv_send_skb_unicast - encapsulate and send an skb via unicast
>   * @bat_priv: the bat priv with all the soft interface information
>   * @skb: payload to send
>   * @packet_type: the batman unicast packet type to use
>   * @packet_subtype: the unicast 4addr packet subtype (only relevant for =
unicast
>   *  4addr packets)
> + * @orig_node: the originator to send the packet to
>   * @vid: the vid to be used to search the translation table
>   *
> - * Returns 1 in case of error or 0 otherwise.
> + * Wrap the given skb into a batman-adv unicast or unicast-4addr header
> + * depending on whether BATADV_UNICAST or BATADV_UNICAST_4ADDR was suppl=
ied
> + * as packet_type. Then send this frame to the given orig_node and relea=
se a
> + * reference to this orig_node.
> + *
> + * Return NET_RX_DROP in case of error or NET_RX_SUCCESS otherwise.

This function is in the TX path, therefore you should use NET_XMIT_SUCCESS/=
DROP
rather than their RX version.

Same comments apply to the other functions.

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--at6+YcpfzWZg/htY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJR08UnAAoJEADl0hg6qKeOM4oP/02KYenka7bgr+FaDtOq0rCH
ExGiyCpBvhexpDROWVkIqm1ZL/Bj3CPlOhdPI29vuuiM8AhEha/kZ5oza1xuJzcl
+CMmflkEgSfgVKPyqrNrufweYDdlyRB0notC2FICbIfEoDF4EK4AQti8v1PYtb5d
WHsZv+2J61Bs5TRL8LSMRzACf/s3mTm88raT9jzBwaQU0b4r/iTe4DOXoYsXwyAn
DfAbsxHWchlmq+gelH/jtq81IQMacFLj+WA1e3vxRUGggO5qnWctI2WdE1IAgcyy
eg/c8uK/mdTVL0TCQMOFGrjcFge8LRZtPUEbeqzsX1mZ1pEJdly+ggk8v65UMHHt
7vckTCQ+lWdc+bV3hB+wI6SWPUn/hk9Rkk76gpwOSYO2x2Eyb/8xzWZe7tAefKWH
6JecY3CNFIXJv6csIPSgHaPiE2thj1clYtgKwOZ+cTtkaYny6GnxLp2x65XEX5lK
JE/q5EdgHjhezxTD6m+uRwj17jRF05gEZXcu/iG08FerqztuWc3208q172wRyxLh
N54Ad1NhkhXUOgCHtjbUg2BwEOgmlT0t1cMlQLPflR+SzudTJ2fV0GhaKFGaWnAG
XpsUV8lT26PdgzAtGUeObXaQ3pGOCuL/cOR1PybeWCAajNlcWEmUx1h69+W7HG3q
W+t7W4MfnYjw3kdjhWAc
=E8Df
-----END PGP SIGNATURE-----

--at6+YcpfzWZg/htY--
