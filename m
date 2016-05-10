Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 10 May 2016 23:58:28 +0200
Message-ID: <3605304.z1uU72uXKg@sven-edge>
In-Reply-To: <1462915079-22681-1-git-send-email-fw@strlen.de>
References: <1462915079-22681-1-git-send-email-fw@strlen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1664465.K91oICAdjz";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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

--nextPart1664465.K91oICAdjz
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 10 May 2016 23:17:59 Florian Westphal wrote:
> batadv_send_skb_to_orig() calls dev_queue_xmit() so we can't use skb->len.
> 
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  Noticed during review, compile tested only.

Fixes: d28785996ad8 ("batman-adv: network coding - buffer unicast packets before forward")
Reviewed-by: Sven Eckelmann <sven@narfation.org>

Kind regards,
	Sven
--nextPart1664465.K91oICAdjz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXMlmEAAoJEF2HCgfBJntGGGsQAJmOrtyHedDOMu0lsstBUEPa
GBZ0bJLRPXbISAZGpYWwjo8yu3TPOdYSzUY7IUIoezmxnXuV6xvHKYx4o1KC9QR6
HEILfJ3sIlWNaaRoFlpJWJih/FTBLkGTZ6ifQpq1tPjFc8G+nUDIjpDZ4LmykuoA
lRrEQfMbD5keIKPv4kKmO4taw47ZG3nWSmJJ08Sw+VPQ/5W1NRyNzXmiyqnsu5zJ
5kpr/1KKpWMupmXRs647GpkxhGWajwtxjiV7Tz5Kg0OrDjuy8aJ7HqyNtE8eHp4k
VY7TPjVIANsT0FjrqvdK4RBr1DU/hUaqgy9yGhjm2XleSvkvxEpe2zWMWFk7cwxF
UKrFU5yj4zrJTzho0Wz9xLNtxFFtjb9BcdvNtjUKzoJgbNVTYXtvit3GCdsS5C+u
JZKBLjraYZq0fVFy1m7b/717cr9IWOMZRdhLcv5q9Al5mwvZ293KVolBQF7CM0N1
yd1dpRR1GrdOuLC9jvJZEQ/YvGBfEIokgZTPiUNmVJo456hLqZgjxuUHKW5vin69
r4/79Wwkt3TmXY7mGTuV+Z//E8enjNv8D5A35hwiow9Ev9mvRCKchB0uyi9TY1An
oK3j90E529X09P7vmais+DHRufMjcFzjyab9Ll+0eeAewI3fxknD6x2P/UncuOlL
agW2K9FFXEa/AThLvQOK
=bbI6
-----END PGP SIGNATURE-----

--nextPart1664465.K91oICAdjz--

