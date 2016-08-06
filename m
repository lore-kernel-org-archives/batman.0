Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 07 Aug 2016 00:10:09 +0200
Message-ID: <33444698.d0jSVnpdRi@sven-edge>
In-Reply-To: <60020429-5aca-f377-5bde-a5c631fce66f@dabax.net>
References: <20160725175212.GC2263@makrotopia.org>
 <60020429-5aca-f377-5bde-a5c631fce66f@dabax.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1641492.T7RhkDO0UQ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [lime-dev] bridge and batman-adv over ethernet
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
Cc: libre-mesh developement <dev@lists.libre-mesh.org>, battlemesh@ml.ninux.org, Pau <pau@dabax.net>

--nextPart1641492.T7RhkDO0UQ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Samstag, 6. August 2016 23:43:44 CEST Pau wrote:
> It would be nice to have some update on this issue if possible.

Maybe you should include Gui Iribarren in your Cc list since he is the one
who can reproduce it(?), knows anything about it and answered to the initial
mail [1].


Btw. I am not sure if LibreMesh supports to receive complex bridge loop 
messages [2] and solve the problem (e.g. by disabling the batman-adv on 
ethernet).

Kind regards,
	Sven

[1] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2016-July/016081.html
[2] https://patchwork.open-mesh.org/patch/15916/

--nextPart1641492.T7RhkDO0UQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXpmBBAAoJEF2HCgfBJntGmIoP+wV9u/7GIhaxtTPpgy+WFABP
v1Q8HfiAq/cPb5dWDQFS7+D6UFSUNJrRORptkf+n4UZcdmpYg6dvH3uTZ8WbWIyP
mU8GVBO+1BnDZivEQmwhgZK+8Z8hj2f2qHYuTI5UPf93GAEi226+9MqRn2bX7cQy
rqwgT/HfBstT4nGp0ryavn7h3da8fK4mNiGKAHC0qfujYWrS3m/pQYVLee7/tlZc
jfg2WbN1MznGUnIc+STFXsPQf3d34R7FZ/r0Z7yd8PeWBQvpHQpNFf9xS6CXPYKR
mH8D+5EYAO7QgGIyTxhiL1CUDFgT2H0827mB/t37GUWYTZ4dro0fuaRZG3MsfQvm
lz1ZDKjLZRKvyO9ixjdzZXEEstYJaBRayvViowDC4WHBcD5/EyBocWFVouYFtqRE
snEF7VHRu5W8VWz8M6IIaY8JMslbT3ZMzz+ELuldKOO4D/PBm1L51VhN0spicKrv
+EmMJp7iAeoMBOmNS2LBeT/aAjIYJWHNjJLLIMGx2x+onoNEPNxd8DXQOAvDIpuq
0VosBwD2qD/O028PSHZOSBbgI2tBMSTSYtJUWj7zgGH2gF1Hmkgm7JC56uXKJLGj
OmNMKopwX8PRDq9GPnP380dawstF6s7TQ6ghGTWTOyj5hUZUN67xptBk0xXqXBtl
AnvggBW8pByHoc7s6XXm
=qzvL
-----END PGP SIGNATURE-----

--nextPart1641492.T7RhkDO0UQ--

