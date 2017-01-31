Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 31 Jan 2017 12:07:24 +0100
Message-ID: <1710363.lgBWTzDvpW@bentobox>
In-Reply-To: <20170129051428.12179-1-linus.luessing@c0d3.blue>
References: <20170129051428.12179-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart165098126.lIlg0IgBDr";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: decrease maximum fragment
	size
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

--nextPart165098126.lIlg0IgBDr
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sonntag, 29. Januar 2017 06:14:28 CET Linus L=FCssing wrote:
[...]
> However, currently "Fragmentation v2" does not support re-fragmentation.
> Which means that once a packet is split into two packets of 1400 + x
> bytes for instance and the next hop provides an interface with an even
> smaller MTU of 1280 bytes, then the larger fragment is lost.
[...]

Beside this change, did you try to make the fragments more equally sized?
Here is just some really ugly and untested pseudo code:

    @@ -454,7 +454,7 @@ int batadv_frag_send_packet(struct sk_buff *skb,
     	struct sk_buff *skb_fragment;
     	unsigned int mtu =3D neigh_node->if_incoming->net_dev->mtu;
     	unsigned int header_size =3D sizeof(frag_header);
    -	unsigned int max_fragment_size, max_packet_size;
    +	unsigned int max_fragment_size, num_fragments;
     	int ret;
    =20
     	/* To avoid merge and refragmentation at next-hops we never send
    @@ -462,10 +462,17 @@ int batadv_frag_send_packet(struct sk_buff *skb,
     	 */
     	mtu =3D min_t(unsigned int, mtu, BATADV_FRAG_MAX_FRAG_SIZE);
     	max_fragment_size =3D mtu - header_size;
    -	max_packet_size =3D max_fragment_size * BATADV_FRAG_MAX_FRAGMENTS;
    +
    +	if (skb->len =3D=3D 0)
    +		return -EINVAL;
    +
    +#define ceil_div(x, y) (1 + ((x - 1) / y))
    +	num_fragments =3D ceil_div(skb->len, max_fragment_size);
    +	max_fragment_size =3D ceil_div(skb->len, num_fragments);
    +#undef ceil_div
    =20
     	/* Don't even try to fragment, if we need more than 16 fragments */
    -	if (skb->len > max_packet_size) {
    +	if (num_fragments > BATADV_FRAG_MAX_FRAGMENTS) {
     		ret =3D -EAGAIN;
     		goto free_skb;
     	}

Kind regards,
	Sven
--nextPart165098126.lIlg0IgBDr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAliQb+wACgkQXYcKB8Em
e0ZSmg//cGAnZrEieCW86wK6d1Cr7/UMd07qPnXjfoJI+thGuA+eDvurqa6lD9j7
eMjcCJqHxQL/79v6O1ZXs2aDOJ5LHRuhV7X59byLs5dvs0cFlQDYepETiJM8G2y+
2loCrzXGFIhhZjdIR14uheimVyRTRpsSI26piVMwZl65y+b/9YDTUzKQfgWoGduG
5nM6me71uf213oRRLMJs69ksrJmg+tqBt5h+HH7BxI/CmAOEI9IPKywZtkUa+NLu
H1s0k3xfM4IfwaiMgBG6fhpTDJ5h/LIPNEX3nLTbLNXU+u8EUDXruaS7eMQj3wPG
OKJa6pemhJM8AbqwR49VlJ3cJ/KiKzxFjugPUM6S0ObmxdcFxIwHNKmzPhRWFhGs
2BOQSal/iofS9gAvQ2iHRx+M2oLs3srW527VnGlGunCJGdzZiz72BY4P6O9VGHIi
L7VpH1vFE63AYsdf3cmWEPaevZwdZYjHAiGYi70NKxoMGKWWtt8DuKLywSIHNUV2
yaSP+yZQpRsOsFKYIrp4wZ3RAsR/MxUSPXIbCC4oe9NLJ1SAZKAbmZn9fwIOr202
J77o9N6fXKO8hsHHYXfV9f4HjZFgLN1I/rI9Vz972s9z0aEBv4u5SkFwDXnq2/De
xYztSaAgXKOeNh2w7xcvDa6tGadk1t8vHfkNGGMRoBJoOjK6qmY=
=yFqi
-----END PGP SIGNATURE-----

--nextPart165098126.lIlg0IgBDr--

