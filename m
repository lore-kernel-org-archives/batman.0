Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 28 Feb 2016 10:20:30 +0100
Message-ID: <2289020.8mL0hEvS8q@sven-edge>
In-Reply-To: <20160228090227.GJ28478@prodigo>
References: <b.a.t.m.a.n@lists.open-mesh.org> <2655547.V2kIYkZTyH@sven-edge>
 <20160228090227.GJ28478@prodigo>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3690008.1T42ARIhm4";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Check skb size before using
	encapsulated ETH+VLAN header
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <a@unstable.cc>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Marek Lindner <mareklindner@neomailbox.ch>

--nextPart3690008.1T42ARIhm4
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 28 February 2016 17:02:27 Antonio Quartulli wrote:
> On Sun, Feb 28, 2016 at 07:36:40AM +0100, Sven Eckelmann wrote:
> > On Sunday 28 February 2016 08:49:02 Marek Lindner wrote:
> > > On Friday, February 26, 2016 17:56:13 Sven Eckelmann wrote:
> > > 
> > > In its current form that check is useless because
> > > batadv_recv_unicast_packet() already calls batadv_check_unicast_packet()
> > > which does the same
> > > pskb_may_pull(skb, hdr_size). Am I overlooking something ?
> > 
> > Looks like it also only checks the size of the batman-adv header and the
> > content of the outer (not the encapsulated) ethernet header.
> 
> I think you are both right here :-) in batadv_check_unicast_packet() we
> perform a may_pull with the same hdr_size, therefore it here once again
> is not useful. It is not really related to this patch, but I think that
> the removal of the useless pskb_may_pull() in interface_rx() could be
> done here since you are cleaning up all the pulls in this function.

Ok, I misunderstood his comment. This one is not necessary when each path to 
this function uses batadv_check_unicast_packet or does "if 
(!pskb_may_pull(skb, hdr_size))" directly. The only callers are 
batadv_recv_bcast_packet (does "if (unlikely(!pskb_may_pull(skb, hdr_size)))") 
and batadv_recv_unicast_packet (calls batadv_check_unicast_packet). I would 
say that an extra patch for that can be introduced later to remove it. But it 
should not be part of this patch because this fix should not contain cleanup 
stuff ("batman-adv header size check") which is not related to the 
encapsulated ethernet (vlan) header.

Kind regards,
	Sven
--nextPart3690008.1T42ARIhm4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW0rveAAoJEF2HCgfBJntGdaUP+QH+V26n8a9Fyp2M0srcJ49Z
LL2fjnPwFo2t1Drs0WyXBeBdCMvV0ytu0OfBJdx7USu6BKZY9F39lNOpMhVrdSKx
4FzSKDte6rzW5JQonR98YK3T6dwvA4+zMw170l3U5dsXtygMwQ/mRR0P5sALM94L
yM7OpfWp+4+ycgximawjpY51Cj1mVbvD7IVmhrXG8GyJbvLYMMvVnS3lXaT6+QPX
cV3myOu1qcWr6xFQ41YM5itqVqroW8J4wXfQXtcG/938u7bkAh4AgKSGfFxOhY7U
grakZRRTJ/qGdxZqSmPFcXuJQ4DAijd1RNGpR7mjRVpOZLkPskQBJEfSopZ80D/R
32KmUSx+HO5syFl2icAppqJ/Eg3eVzNlpcRepL5CdBVmq61OPw0rIjGIPMhb3ouJ
eU7OP98PW3Met+LBhtN9xhCoGV6bOb5nZaOHmb0IkXsWxQRWwub/GdGq2fHO3kqI
29o6PQ5WxOQ/9oQr4oNqmLC8TsJ3ls7MZW9IwY+Rk10HK16JoQZMHzZX4aQeEk3U
Si7H32Z76hEdDanwzt2J/76Ohxt5QzKZt6MFmmJmcM14Yw1csO5GLhKSTHigCCut
w0/KtqG8V9pq5OjTvPXTAUzniv7oEIrDPlKf6M1ITeEP9FoUJZFNJNC+80nYxIjr
G+Qihcmj+ntOm3sruAL2
=njr7
-----END PGP SIGNATURE-----

--nextPart3690008.1T42ARIhm4--

