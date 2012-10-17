Return-Path: <martin@hundeboll.net>
Message-ID: <507ED8CC.1060901@hundeboll.net>
Date: Wed, 17 Oct 2012 18:11:56 +0200
From: =?ISO-8859-1?Q?Martin_Hundeb=F8ll?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <1350489584-10428-1-git-send-email-sven@narfation.org>
In-Reply-To: <1350489584-10428-1-git-send-email-sven@narfation.org>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: Add function to calculate
 crc32c for the skb payload
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
To: b.a.t.m.a.n@lists.open-mesh.org

On 2012-10-17 17:59, Sven Eckelmann wrote:
> +__be32 batadv_crc32(const struct sk_buff *skb, u8 *payload_ptr)
> +{
> +	u32 crc =3D 0;
> +	struct sk_buff *iter;
> +	size_t skip_len, read_len;
> +	const skb_frag_t *f;
> +	int i;
> +
> +	skip_len =3D payload_ptr - skb->data;
> +	read_len =3D skb_headlen(skb) - skip_len;
> +	if (read_len)
> +		crc =3D crc32c(crc, payload_ptr, read_len);
> +
> +	for (i =3D 0; i < skb_shinfo(skb)->nr_frags; i++) {
> +		f =3D &skb_shinfo(skb)->frags[i];
> +		crc =3D crc32c(crc, skb_frag_address(f), skb_frag_size(f));
> +	}
> +
> +	skb_walk_frags(skb, iter)
> +		crc =3D crc32c(crc, iter->data, skb_headlen(iter));
> +
> +	return htonl(crc);
> +}

I tested the crc'ing of non-linear skb buffers and can confirm that it=20
works as expected, so:

Tested-by: Martin Hundeb=F8ll <martin@hundeboll.net>

... at least for batadv_crc32() :)

--=20
Kind Regards
Martin Hundeb=F8ll
Frederiks All=E9 99, 1.th
8000 Aarhus C
Denmark

+45 61 65 54 61
martin@hundeboll.net
