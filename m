Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 11 May 2016 15:58:25 +0800
Message-ID: <6775496.rbfDoTAmc1@voltaire>
In-Reply-To: <3605304.z1uU72uXKg@sven-edge>
References: <1462915079-22681-1-git-send-email-fw@strlen.de>
 <3605304.z1uU72uXKg@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1644487.t9QnrBIoau";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix skb deref after free
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
Cc: Florian Westphal <fw@strlen.de>

--nextPart1644487.t9QnrBIoau
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, May 10, 2016 23:58:28 Sven Eckelmann wrote:
> On Tuesday 10 May 2016 23:17:59 Florian Westphal wrote:
> > batadv_send_skb_to_orig() calls dev_queue_xmit() so we can't use skb->len.
> > 
> > Signed-off-by: Florian Westphal <fw@strlen.de>
> > ---
> > 
> >  Noticed during review, compile tested only.
> 
> Fixes: d28785996ad8 ("batman-adv: network coding - buffer unicast packets
> before forward") Reviewed-by: Sven Eckelmann <sven@narfation.org>

Applied in revision 6863d3b.

Thanks,
Marek

--nextPart1644487.t9QnrBIoau
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXMuYhAAoJEFNVTo/uthzAafUH/10z5i+a1Iqh9XPOqdmqupqx
0TxEkZnb5J8+ex+HJJKjnmvnibFJk68x+pxxVi9HeXkhtRM5MYw2UNLvzs7abAMj
PZzwN+QtXoMLdWXYv8xyKiGBKebkM2NW5GtTey1MGDjCf41pZ9SY9muzTsBASwnu
pNdPxhMnW3xN0HXZdGCY2ZVorps7Bji2qsX8WIjSVITnZdPwYZ7aHdhauCZdsRo2
AmbM+PvJMjSSrmimXbw/JIzJe0ZNYso4jUqwQDw4oQUaJqgCZj8NlAg3KFdhhbIs
vHMvcbjDRvNOJMIC1hVLIzGTLIKVuj40bQozhKbig+Ehbq7oDc2YvIccQqcNo3U=
=l1J2
-----END PGP SIGNATURE-----

--nextPart1644487.t9QnrBIoau--

