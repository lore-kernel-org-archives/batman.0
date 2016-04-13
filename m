Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 13 Apr 2016 14:19:47 +0200
Message-ID: <1499929.cbPIaZeezG@prime>
In-Reply-To: <20160413121416.GA22733@lunn.ch>
References: <20160412204259.GK29895@lunn.ch> <2242031.raF8ugmCc9@prime>
 <20160413121416.GA22733@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6217036.CZYOelQGJQ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] skb->priority and fragments
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: b.a.t.m.a.n@lists.open-mesh.org, "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>

--nextPart6217036.CZYOelQGJQ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Andrew,

On Wednesday 13 April 2016 14:14:16 Andrew Lunn wrote:
> [...]
> > There are two cases:
> > 
> > 1.) On the original sender, both fragments could adopt the priority as you
> > suggest. The code probably doesn't take care of that yet, so that could be
> > fixed.
> 
> I will cook up a patch for this.

Excellent!

> > 2.) On routers on the way, the priority could only be set based on the
> > first fragment, since the second fragment will not have a valid header to
> > parse. And unless we remember the priority from the first fragment, we
> > have no way to know to which priority we should set the second fragment.
> 
> I don't think remembering works. It looks like it fragments from the
> tail towards the head. So we are not going to receive the IP header
> until we get the last fragment.
> 

Ah,  you are deeper into that. But my hunch was also that it would be messy, 
since we can't guarantee the order of the fragments anyway.

> > I believe case 1 can be fixed easily, for case 2 I don't have an idea
> > right
> > now. :)
> 
> There is one reasonable option i can think
> of. batadv_skb_set_priority() extracts three bits of priority
> information, either from the TOS bits, or the 801.q header.
> 
> The fragment header is:
> 
> struct batadv_frag_packet {
>         u8     packet_type;
>         u8     version;  /* batman version field */
>         u8     ttl;
> #if defined(__BIG_ENDIAN_BITFIELD)
>         u8     no:4;
>         u8     reserved:4;
> #elif defined(__LITTLE_ENDIAN_BITFIELD)
>         u8     reserved:4;
> 	u8     no:4;
> #else
> #error "unknown bitfield endianness"
> #endif
>         u8     dest[ETH_ALEN];
>         u8     orig[ETH_ALEN];
>         __be16 seqno;
> 	__be16 total_size;
> };
> 
> Place the priority information into 3 of the 4 reserved bits. The
> receiver can then set the skb->priority of the fragment before passing
> it to the hard interface.

Ah, yes that sounds like an excellent idea! I like that. The default should be 
zero right now, which would also fit. :)

Thanks!
     Simon
--nextPart6217036.CZYOelQGJQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXDjljAAoJEKEr45hCkp6hTg8P/0aRVfPdKFiJj8n7QlAV3ktr
3q4l9O1W6F5glAhO/sG/aI37P3Ery0MDJ376KaQmnqFEDUm04B2IwZXB7/+gS/e2
JqV2vyZ1PwD2dD/MmQaqbUA9KBqM8mYWtVW6IG6sBA8mwInCUO4OIr2XVvEl5DUY
uy4DYtAfdiMdwxZidyuoSB7OBivxEG6JDhRgd/8iIF43kiCaRsjKYE3apCSR9DT2
tXkmM8Bnt9ajmUkehJrSgeMdACW0/GI22x956PJqFh188SdW1I4L/4lVg282s+VZ
kekHX1PVzLXPNUJo/qWu5QRos9FcYmNZp2LOCc44Y7LTm4JJBU8CnXg2GKZa7kQV
Vf6jqSt/Qx9j11me6rAU5iTHICbNxXGmQjmvFr/WB6ZP/rAoiuC7WK30GXNG9/Pc
cxZhIYhnvBHhS1zCt2c62AHH7bfJ+Yq24eYDSmERC2Ep+B4v5IFeAkOXqUnIvxi5
eptKFgAU+c/pVq5Uwx7OjuTIx4mdfvJRtqb7vYU8f6FveQctGIps47EzNzmXq0nB
vXU940Cc4utyZLtdP2NEixCKZJOuOdvZs3g8oznoS9LR20twN1FIZRRAMYwysNNh
1k2ZnS1kx8iYNibvgPI0VuRHgd//kmU9vDc3pMIcX0mcbqLSV7SD00uWsHPdMAyo
zLsrkfk5w7maP84HmQOL
=3xNz
-----END PGP SIGNATURE-----

--nextPart6217036.CZYOelQGJQ--

