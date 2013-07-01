Return-Path: <ordex@autistici.org>
Date: Mon, 1 Jul 2013 21:49:03 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130701194902.GB3065@ritirata.org>
References: <1372507359-2075-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="St7VIuEGZ6dlpu13"
Content-Disposition: inline
In-Reply-To: <1372507359-2075-1-git-send-email-linus.luessing@web.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: refine API calls for unicast
 transmissions of SKBs
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


--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 29, 2013 at 02:02:39PM +0200, Linus L=C3=BCssing wrote:
> +/**
> + * batadv_send_skb_generic_tt - send an skb to a translation table node

I don't really like the expression "translation table node"..it looks like =
we
have different type of nodes...What about a simple"to a destination using t=
he
Translation Table" ? you can go on a new line with the short description, if
needed.

> + * @bat_priv: the bat priv with all the soft interface information
> + * @skb: payload to send
> + * @packet_type: the batman unicast packet type to use
> + * @packet_subtype: the unicast 4addr packet subtype (only relevant for =
unicast
> + *  4addr packets)
> + * @vid: the vid to be used to search the translation table
> + *
> + * Look up the destination node for the destination address in the ether=
net
> + * header via the translation table.

What about substituting "destination node" with "recipient node" to avoid
repeating destination?

> + *
> + * Wrap the given skb into a batman-adv unicast or unicast-4addr header
> + * depending on whether BATADV_UNICAST or BATADV_UNICAST_4ADDR was suppl=
ied
> + * as packet_type.
> + *
> + * Then send this frame to the according destination node.

Since the above is a list of steps performed by the function, I'd rather re=
move
the blank lines you've added between the paragraphs.

[...]

>  /**
> - * batadv_send_unicast_skb - send the skb encapsulated in a unicast pack=
et
> + * batadv_send_skb_tt - send an skb to a translation table node

same as above

>   * @bat_priv: the bat priv with all the soft interface information
>   * @skb: the payload to send
>   * @vid: the vid to be used to search the translation table
>   *
> + * Look up the destination node for the destination address in the ether=
net
> + * header via the translation table.
> + *

same as above

> + * Wrap the given skb into a batman-adv unicast header.
> + *
> + * Then send this frame to the according destination node.
> + *

same as above

>  /**
> - * batadv_send_4addr_unicast_skb - send the skb encapsulated in a unicas=
t 4addr
> - *  packet
> + * batadv_send_skb_tt_4addr - send an skb to a translation table node

same as above

>   * @bat_priv: the bat priv with all the soft interface information
>   * @skb: the payload to send
>   * @packet_subtype: the unicast 4addr packet subtype to use
>   * @vid: the vid to be used to search the translation table
>   *
> + * Look up the destination node for the destination address in the ether=
net
> + * header via the translation table.
> + *
> + * Wrap the given skb into a batman-adv unicast-4addr header.
> + *
> + * Then send this frame to the according destination node.
> + *

same as above

>   * Returns 1 in case of error or 0 otherwise.
>   */
> -static inline int batadv_send_skb_unicast_4addr(struct batadv_priv *bat_=
priv,
> -						struct sk_buff *skb,
> -						int packet_subtype,
> -						unsigned short vid)
> +static inline int batadv_send_skb_tt_4addr(struct batadv_priv *bat_priv,
> +					   struct sk_buff *skb,
> +					   int packet_subtype,
> +					   unsigned short vid)
>  {
> -	return batadv_send_skb_generic_unicast(bat_priv, skb,
> -					       BATADV_UNICAST_4ADDR,
> -					       packet_subtype, vid);
> +	return batadv_send_skb_generic_tt(bat_priv, skb,
> +					  BATADV_UNICAST_4ADDR,
> +					  packet_subtype, vid);
>  }
> =20

I like this new API :)
If you are ok with my suggestions then you can also add=20

Acked-by: Antonio Quartulli <ordex@autistici.org>

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJR0d0uAAoJEADl0hg6qKeObRUP/RDSKvQZ1eux5snICde52Yko
Cs9yQg7AwvtyVrSNcFxYTBn+s5j1pZoP2yUEert+ev6dVmhoTsfb409vGqa5Fii2
5ATnwRgXid071WJG127kbFWvk4NnVUcdNmWz9Wm2xyQab/UAL4y/9ZrMGMTOqqtl
MxuyhhGrj4ZL5aL3gxnDDMVB6T9uPXVC2kAcSGPnfCQM8XX32ZeE+k/VoLUTwYnz
MnpFnUa9T/z+SY5qxeU5W2HMCm/ng5XaoPU5TZ0m4IBaqpRAJxP6E2qXnNuP8M14
OPLqvzsVYSYi6rGIjs5pEgbSDMA9DUsUH8oacO+XqUmS7ETOCe/xHvjDCbAYCCRJ
3rxWDEk19p1moxE1RJ4IJjtHTLidPmUyhFrCeRlb2Sd9Q8lrs/qRCUPzvZ/4SkUZ
S4qLwXCFnzIXk2NdxpDYhojXYAyT4cDhl93qN4UlNHa0UT6feC9qDas3fdnPOgwd
T66xLOmGffogmGPhjGUUUjtTlxxfl2cz4/UJtMx+kZU80FaHOBdEaALgnESfNj8o
6KFb6GdP0njo5W93CQGQHCTvUM8l3VqsANxhhypfxss3yXhM+qeGGKCYTIpffw9b
I+tnvC0GSqraMLIzMit8S3H0nF9nU0ZHKkZqQn6KSD7H3QsC2PJJGZVQK9+NvE7Y
N6d1ARm3MeqdrZZnExim
=hu7q
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--
