Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 14 Jul 2012 09:04:55 +0200
Message-ID: <4617557.uTg8l34TUo@sven-desktop.home.narfation.org>
In-Reply-To: <1342222910-20627-2-git-send-email-ordex@autistici.org>
References: <1342222910-20627-1-git-send-email-ordex@autistici.org>
	<1342222910-20627-2-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3126526.PNS9c0rirv";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCHv9 1/8] batman-adv: add UNICAST_4ADDR
	packet type
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


--nextPart3126526.PNS9c0rirv
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

Hi,

just some things that came to my mind after reading Ben Hutchings patch.

On Saturday 14 July 2012 01:41:43 Antonio Quartulli wrote:
> +/**
> + * batadv_prepare_unicast_packet - encapsulate an skb with a unicast header
> + *
> + * @skb: the skb containing the payload to encapsulate
> + * @orig_node: the destination node
> + *
> + * Returns false if the payload could not be encapsulated or true otherwise
> + */

http://www.kernel.org/doc/Documentation/kernel-doc-nano-HOWTO.txt

No blank line between "function_name(:)? (- short description)?" and
"@parameterx(space)*: (description of parameter x)?)*"


> +struct batadv_unicast_4addr_packet {
> +       struct batadv_unicast_packet u;
> +       uint8_t src[ETH_ALEN];
> +       uint8_t subtype;
> +} __packed;
> +

Where is the kerneldoc for "struct batadv_unicast_4addr_packet"?


> +/**
> + * batadv_dht_select_candidates - given a key, selects the candidates which the
> + * DHT message has to be sent to. An originator O is selected if and only if
> + * its DHT_ID value is one of three closest values (from the LEFT, with wrap
> + * around if needed) then the hash value of the key. ip_dst is the key.
> + *
> + * @bat_priv: the bat priv with all the soft interface information
> + * @ip_dst: ipv4 to look up in the DHT
> + *
> + * Returns the candidate array of size DHT_CANDIDATE_NUM
> + */
> +static struct batadv_dht_candidate *
> +batadv_dht_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst)
> +{

Please use the correct order:

/**
 * function_name(:)? (- short description)?
(* @parameterx(space)*: (description of parameter x)?)*
(* a blank line)?
 * (Description:)? (Description of function)?
 * (section header: (section description)? )*
(*)?*/

And I think we should add () for function names and prepend
"struct " for structs, ...

Kind regards,
	Sven
--nextPart3126526.PNS9c0rirv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQARoXAAoJEF2HCgfBJntG2AgQAMqUz04uUMlLsXGkea7rYppG
QMUHKLNX8Q1lc8zUNIHHLC00aSe0xKxPlWwY/gzCm1XUnH/YumwMKcgCU5HHIhsi
v0n/XSJlOHBXzgl/2IF1ABe8GXJlPBPC2r8LO+atAensJI0SftWkHZgtsEqJEzCq
dsTfViSfnMDQ/4X4n/sajWaLAqIOsbTHdsnH9bnxoy8XprdhXAg+sjyvjViUSxOJ
RzPU9CUqwK9gzoUjaWhPp8G6tYfMlSXuZkxXIPwcDH3RT81W8JiRbimzAcVHQQsl
9KAuiZtY/xDErdCgkgnP2SnvgHdGofJgvsoGTbkvkdDK6A2UwZ9DUtpVVp3gnqEa
wwsTFlquWpGF4PO5q3r0RyX3vIewd1WNpl3N7iiKBeCfOmwU00UlcnYJaGOgDwm8
K0JxIibatq2rua+afo7MfJZkAopPWodCuiASp5h6o35D9iqOwRgiquGxNO9Q5fC3
hmXR0avJG/qRmO7nR0B2eRnd1mo/IkVaWgAMm4cvLFIaWHlSlrEuOyHTNLeIq5nB
x7wYlNBitwEUKIRdGgsJSynVEWBuQkb/iNQ4+IEzn7boaY+ZXr/Hf1o0bm9nzTRN
/RNdkvDYBzgvJzN9Vf3iFyReNNL9aAK/XC6bktO6jjvE+ci4DMWC7yN3RrvQOGLJ
gRXH6a7SDDmvOQFOIkP0
=Trpw
-----END PGP SIGNATURE-----

--nextPart3126526.PNS9c0rirv--

