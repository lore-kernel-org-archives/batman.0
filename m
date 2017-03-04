Return-Path: <mschiffer@universe-factory.net>
References: <13175888.lmslI35NF1@sven-edge>
 <20170304153331.22420-1-sven@narfation.org>
 <20170304153331.22420-2-sven@narfation.org>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Message-ID: <255fda13-663c-e435-8db7-1cf11a7e66fd@universe-factory.net>
Date: Sat, 4 Mar 2017 17:00:34 +0100
MIME-Version: 1.0
In-Reply-To: <20170304153331.22420-2-sven@narfation.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="kxnfwtHlCUphlNG4GfcnsOdxGOIsNcINE"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint 2/3] batman-adv: Keep fragments
 equally sized
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kxnfwtHlCUphlNG4GfcnsOdxGOIsNcINE
Content-Type: multipart/mixed; boundary="0raOaR4mo8I1OgHrr0DhPKXg3NSKD3jPT";
 protected-headers="v1"
From: Matthias Schiffer <mschiffer@universe-factory.net>
To: Sven Eckelmann <sven@narfation.org>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
Message-ID: <255fda13-663c-e435-8db7-1cf11a7e66fd@universe-factory.net>
Subject: Re: [B.A.T.M.A.N.] [PATCH maint 2/3] batman-adv: Keep fragments
 equally sized
References: <13175888.lmslI35NF1@sven-edge>
 <20170304153331.22420-1-sven@narfation.org>
 <20170304153331.22420-2-sven@narfation.org>
In-Reply-To: <20170304153331.22420-2-sven@narfation.org>

--0raOaR4mo8I1OgHrr0DhPKXg3NSKD3jPT
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/04/2017 04:33 PM, Sven Eckelmann wrote:
> The batman-adv fragmentation packets have the design problem that they
> cannot be refragmented and cannot handle padding by the underlying link=
=2E
> The latter often leads to problems when networks are incorrectly config=
ured
> and don't use a common MTU.
>=20
> The sender could for example fragment a 1257 byte frame (plus inner
> ethernet header (14) and batadv unicast header (10)) to fit in a 1280 b=
ytes
> large MTU of the underlying link. This would create a 1280 large frame
> (fragment 2) and a 41 bytes large frame (fragment 1). The extra 40 byte=
s
> are the fragment header (20) added to each fragment.
>=20
> Let us assume that the next hop is then not able to transport 1280 byte=
s to
> its next hop. The 1280 byte large packet will be dropped but the 41 byt=
es
> large packet will still be forwarded to its destination.
>=20
> Or let us assume that the underlying hardware requires that each frame =
has
> a minimum size (e.g. 60 bytes). Then it will pad the 41 bytes frame to =
60
> bytes. The receiver of the 60 bytes frame will no longer be able to
> correctly assemble the two frames together because it is not aware that=
 19
> bytes of the 60 bytes frame are padding and don't belong to the reassem=
bled
> frame.

Just nitpicking, but for Ethernet the 14byte header counts into frame siz=
e,
so it's actually a 55 byte frame that is padded to 60 bytes. This means
that for a given hardif MTU (and 2 fragments), there is a range of
precisely 5 byte lengths that will trigger the issue, which explains how =
it
could stay undetected for so long.

Matthias

>=20
> This can partly be avoided by splitting frames more equally. In this
> example, the 661 and 660 bytes large fragment frames could both potenti=
ally
> reach its destination without being to large or too small.
>=20
> Reported-by: Martin Weinelt <martin@darmstadt.freifunk.net>
> Fixes: db56e4ecf5c2 ("batman-adv: Fragment and send skbs larger than mt=
u")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Acked-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
> ---
>  net/batman-adv/fragmentation.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>=20
> diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentat=
ion.c
> index 11a23fd6..8f964bea 100644
> --- a/net/batman-adv/fragmentation.c
> +++ b/net/batman-adv/fragmentation.c
> @@ -404,7 +404,7 @@ bool batadv_frag_skb_fwd(struct sk_buff *skb,
>   * batadv_frag_create - create a fragment from skb
>   * @skb: skb to create fragment from
>   * @frag_head: header to use in new fragment
> - * @mtu: size of new fragment
> + * @fragment_size: size of new fragment
>   *
>   * Split the passed skb into two fragments: A new one with size matchi=
ng the
>   * passed mtu and the old one with the rest. The new skb contains data=
 from the
> @@ -414,11 +414,11 @@ bool batadv_frag_skb_fwd(struct sk_buff *skb,
>   */
>  static struct sk_buff *batadv_frag_create(struct sk_buff *skb,
>  					  struct batadv_frag_packet *frag_head,
> -					  unsigned int mtu)
> +					  unsigned int fragment_size)
>  {
>  	struct sk_buff *skb_fragment;
>  	unsigned int header_size =3D sizeof(*frag_head);
> -	unsigned int fragment_size =3D mtu - header_size;
> +	unsigned int mtu =3D fragment_size + header_size;
> =20
>  	skb_fragment =3D netdev_alloc_skb(NULL, mtu + ETH_HLEN);
>  	if (!skb_fragment)
> @@ -456,7 +456,7 @@ int batadv_frag_send_packet(struct sk_buff *skb,
>  	struct sk_buff *skb_fragment;
>  	unsigned int mtu =3D neigh_node->if_incoming->net_dev->mtu;
>  	unsigned int header_size =3D sizeof(frag_header);
> -	unsigned int max_fragment_size, max_packet_size;
> +	unsigned int max_fragment_size, num_fragments;
>  	int ret;
> =20
>  	/* To avoid merge and refragmentation at next-hops we never send
> @@ -464,10 +464,15 @@ int batadv_frag_send_packet(struct sk_buff *skb,
>  	 */
>  	mtu =3D min_t(unsigned int, mtu, BATADV_FRAG_MAX_FRAG_SIZE);
>  	max_fragment_size =3D mtu - header_size;
> -	max_packet_size =3D max_fragment_size * BATADV_FRAG_MAX_FRAGMENTS;
> +
> +	if (skb->len =3D=3D 0 || max_fragment_size =3D=3D 0)
> +		return -EINVAL;
> +
> +	num_fragments =3D (skb->len - 1) / max_fragment_size + 1;
> +	max_fragment_size =3D (skb->len - 1) / num_fragments + 1;
> =20
>  	/* Don't even try to fragment, if we need more than 16 fragments */
> -	if (skb->len > max_packet_size) {
> +	if (num_fragments > BATADV_FRAG_MAX_FRAGMENTS) {
>  		ret =3D -EAGAIN;
>  		goto free_skb;
>  	}
> @@ -507,7 +512,8 @@ int batadv_frag_send_packet(struct sk_buff *skb,
>  			goto put_primary_if;
>  		}
> =20
> -		skb_fragment =3D batadv_frag_create(skb, &frag_header, mtu);
> +		skb_fragment =3D batadv_frag_create(skb, &frag_header,
> +						  max_fragment_size);
>  		if (!skb_fragment) {
>  			ret =3D -ENOMEM;
>  			goto put_primary_if;
>=20



--0raOaR4mo8I1OgHrr0DhPKXg3NSKD3jPT--

--kxnfwtHlCUphlNG4GfcnsOdxGOIsNcINE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEZmTnvaa2aYgexS51Fu8/ZMsgHZwFAli65KIACgkQFu8/ZMsg
HZx6Ig//ehoRboSccyqEjk/ePIMhl7rBJdEm4vRkJCdB3QX43m+UuH+uClmTFrVC
pa8ShBOyuuvQrBpaHt9XWrT0aaqQgk44Nw/Y+gGUspPIZRdgEnms+K5KwTyCEceP
f8lKBmI9F/L8u2e9gj3RZqvmZqedXzluNgD8VT5LwMqReokjH0n/hTIXbHWPhSlm
kKGqoKMIPEGANbgmFMI/BETq5qwMUPm/iynhFMLuAqPPkF2ecpZz0M7gVivp4Mrp
oPaGQu5MZhpTJLE1JKgh5aL5OTUN9BO8DHXAk92Id54YXdKv+NlSf5/WOplkeUyZ
Nskp2dUPmJP6aXwB17xDfPod0Okkb5nzZNYuBZclgEYZEuc0flQGFpNfXCiSdsWc
o/MBaypB6rhelvfZWdzm537tAy88kx9IQ+ZdLzTv+zks1WejWsY5G0HKXX0wepRl
c3lbNbV5xSBAIUMJYuBsO5peNrx+qTUHhdFi4HxbD3kGWYCe2hFHPPZFudAdJsTn
ewGegAWbb30/lsppEoch/9fM7P6Y1NwJoyRDR2nNPBnOcrTfIdfoO2JHfmyNBrbk
dxOpip1lJCvsxiP7FNIecBQaYscM5OH75zwNBHomipUQY8JmfNVoe85cuhXjYJl+
8Dk3dCAFG/eNYihsh4B9sJx5Ce+WDXtOrM6TCbIjkr3wrZ/pj+E=
=+Inf
-----END PGP SIGNATURE-----

--kxnfwtHlCUphlNG4GfcnsOdxGOIsNcINE--
