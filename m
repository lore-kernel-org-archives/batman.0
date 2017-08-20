Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 20 Aug 2017 08:55:12 +0200
Message-ID: <13544673.RylKELaqkV@sven-edge>
In-Reply-To: <CAA_JP8WFZPzDzFLAAOydhjuL7Ex26_RtbnH-pEhaCe4Fs70FEA@mail.gmail.com>
References: <CAA_JP8WFZPzDzFLAAOydhjuL7Ex26_RtbnH-pEhaCe4Fs70FEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2222623.ESeB7NOYFE";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] batman on top of vlan?
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

--nextPart2222623.ESeB7NOYFE
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Mittwoch, 16. August 2017 09:43:34 CEST dan wrote:
> Can batman operate on top of a vlan?  For example, a wireless link
> with MTU of 1532 to accommodate both batman and the vlan.  Plugs into
> the batman-adv box on eth0, configure eth0.10 and add eth0.10 to bat0.

It should work. batman-adv is not too picky about what is used below it. It 
must be able to transport ethernet frames and it must allow things like 
broadcasts. We could go here into more details but it wouldn't help us to 
answer the question. At least 802.1Q should not influence the behavior in any 
significant way and should therefore not be a problem.

Kind regards,
	Sven
--nextPart2222623.ESeB7NOYFE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlmZMlAACgkQXYcKB8Em
e0Z5Pw//ToxtRCDvFocjLXHSkiyDJue9viNnuCWA9cXpWLdFeCvi4NRXuY1q3+pG
VT2Hnc6g787BntbRIjkE7Zu4f8MbwUhmi7jHDlNg0/wakIccjVkT7Ct/ezfEvruq
+gFAxbvHB4ii3JADnP9ufZS+Uxd+rlpBq8z57euGnvqU2DfmbAIB/snYxzqRrpAa
oRWNKi9gWEaPjRU0SACBNTE/Gw3z2ykiMMD1XHy7rQWtdmnl+brbejyCXxtP2Fe8
uo/9ElA1BgUnSoHYBN45dI1RO5VhsRZM3PdjHYhpbrugVLzAKKIMSljEOPwbcP/v
oBtotM7n1QjpLokIrZVcsiHKUmkV8rQ5/yAX/mRWYLu1Fm0XtTLnZWE9vtB9OBNG
zNX5g7wZ5PB/CZOO19PLZfkuXnDVWkkg8L6HVRbymHEkHYwz9WnnbJHNX6KfeQeS
fT46FsBactv6h08AQEvKAUT5ub3wprZzSelz9nGIFgiBncVg+K2OxAvjJhkiwPZC
uLvz3HdLZf+bKE35o+wOi2BBNw1JTpeco9iJOLBhLehXLPu7zhyP65QX+mx5vQ8v
kcdhs9hwuyuZLrcB+eOoLVsa/cvE1DmR0bwyOkz58UaaHZIng+X03e/Ayek71607
Y83s3DmscSstTWLf+GPEmbvHUGecpeLery+TcNoB1NDqnj1kdA8=
=MLYR
-----END PGP SIGNATURE-----

--nextPart2222623.ESeB7NOYFE--

