Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 31 Jan 2012 23:53:33 +0100
Message-ID: <14133018.uqaqHtSXXJ@sven-laptop.home.narfation.org>
In-Reply-To: <1328045710-32600-1-git-send-email-ordex@autistici.org>
References: <1328045710-32600-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2806617.O6hQq5Hc2a";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: pass the correct header size
	to interface_rx
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


--nextPart2806617.O6hQq5Hc2a
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Tuesday 31 January 2012 22:35:10 Antonio Quartulli wrote:
> in recv_unicast_frag(), the third parameter of the interface_rx()
> invocation, which is the size of the current header, is wrongly computed.

Really (actually it is the fourth, but I don't want to talk about that)? 
Wasn't the reassembled unicast packet just a unicast packet and not a 
unicast_frag packet (see frag_merge_packet)?

I could be wrong (didn't checked it), but I just have the feeling that the 
current version could be correct.

Kind regards,
	Sven
--nextPart2806617.O6hQq5Hc2a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJPKHDtAAoJEF2HCgfBJntGYjUP/2NghLWZYq08xtDL6OqB09UD
Vr744G+og9NUIgTWf51obtk8B+c/JopPlhJLuhUz5n5+jDFLeSKRQf/L/F06iUrE
m+RyUTsAz5qaxLVttK+wFfhDUj2ybIpoAIQd9auM8WOj11Xv6lYy7XqUxYW2yHJo
w94Wzr7JX8zQxs4Q74LotFtVw7HgusbWY8RQ1/y0ROvSq4mp5dfFOWryaaK7wFWt
NeQSivzFrAmoVKkJuSbRdg5RJdhvEILdVjqrVmyA6zNDZdWJpKLGh2z6MmiQHUPT
T5pmHmHuUe8Q0ab9ycdbGfslWO1qXDPcE0TaKMLvgXZcEXsjFa/IBqeysk8toOnS
E8e6ltFX4IAx/siJ2q3jbdFXoTFMiMfEs2Y1ndRR87NXRBf9RO3h6mjH/LuVSnbC
dliTT+RG9l7IR8/C/cZeNlz4oRgb2Neagi3zYPIh0VJLj2T2haKO9kGo9ZJxWKOQ
kZaEt8ndROQMiFaVcQdcpImuE+Oo6350LNfsazJ6sqhGopxjSOUptEzO7lDJ/AZn
1I4Q4kdSO8rjVDubttc/JIw9BqWi0Nab3jKuIyBTRx4hHT0SCx51cQtrCgHYoSrf
4PTOFH37RyHOzZQ3qhWMkC+jqvtpjButoflSlH2WhYBrx0dfxizmNkuERjiGmByg
Z/9kJRs3ZO3wBDpI2kYQ
=ifHc
-----END PGP SIGNATURE-----

--nextPart2806617.O6hQq5Hc2a--

