Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 27 Jun 2016 00:59:50 +0200
Message-ID: <6609893.dbqcFQ4Lmy@sven-edge>
In-Reply-To: <1466981721-3202-1-git-send-email-sven@narfation.org>
References: <1466981721-3202-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6271020.ZshT9FlkAC";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Remove orig_node
	reference handling from send_skb_unicast
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

--nextPart6271020.ZshT9FlkAC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 27 June 2016 00:55:21 Sven Eckelmann wrote:
> This breaks for example the reference counting in
> batadv_interface_tx when an DHCP packet (BATADV_DHCP_TO_SERVER)  is
> detected in a multicast (not broadcast) packet which is later detected by
> the multicast code as BATADV_FORW_SINGLE. The multicast code then assumes
> that it will send it and acquires the originator to the destination. But in
> reality, the DHCP forwarding code takes precedence and as result the
> reference counter is not decreased anymore.

Ok, just saw that this cannot happen because do_bcast would not have been set 
to true in this situation. And this would automatically disable the multicast 
detection parts. I will therefore resubmit for master instead of maint.

Kind regards,
	Sven
--nextPart6271020.ZshT9FlkAC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXcF5mAAoJEF2HCgfBJntG9WMP/3I0U65g37bIhY2y4dJr8iqU
MlW/fhqX1IrYUVJPBUkykiMn/Hr1rCpqUUxUz6nNljNnB+emwtlRDmKgIrp6Rvdy
gXMUN3G+iWiVW4TDI3+52v1tcFc17+xmo6kghTcqrKbFmeqWvv7XgHnTv1QlCwe9
chKDAwxskVPj3X/T0mmeysrMzYntbxN47B8tk9OJmEPp8UumeC7gXBiWDCAXayOR
jh4UCJK8esoky1A0vQDJs8AM4uAUT1x/2WFrXKVOC5AhLUS3DNWVzTJoBFArAzwa
IaAmTgFEf8KvCccx8J1IigShkC/KqgMkBPCYu1YvJaP32xaN+dUnK0CgMAZkLTtQ
W6ujK4Q9Wpkj8ciA2mg4/DZdyS6iPHShcQeGYLV8jvVq9UGD6BAvK5loB2zmP0so
QB06drRwvY3D4JEjRxEcVzOqJ0U9fxsduxIfWRzABleSZTLCujA6f9gRjzP9PQTE
KxZ04+ixBQRTiHQYsockvGB+oAG1CSon5weh/SE/FOfJ/MXgyftGVYXai54bdGiW
/juoW1IybgAvk/YRHjI3cPJjXJ65PNzoiCbbxOaq1UyiBwSjKYdKVW5reXp9C78Y
To8bUPzRe62CqPeC6NLCMl43lY0JmCwLqcgy2uwFliQ7H0XT06LmzG+ctpAr/eRF
dQzU/wwOKXFjs9zE8LdV
=4auF
-----END PGP SIGNATURE-----

--nextPart6271020.ZshT9FlkAC--

