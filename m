Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 26 Jul 2015 20:36:52 +0200
Message-ID: <2515511.aHkK6VeTlm@sven-edge>
In-Reply-To: <CALaFpeUeV9sOnBp=oj-gfjbFd=hd=SPMBPE7+VS+Q6S0e9tsbg@mail.gmail.com>
References: <CALaFpeUvicwHWQag0Upv5UNQ935TYY-RJuXVUtpT7gfORWZm7A@mail.gmail.com>
 <11411625.XETR6nI4Wt@bentobox>
 <CALaFpeUeV9sOnBp=oj-gfjbFd=hd=SPMBPE7+VS+Q6S0e9tsbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2560242.THkU6b7OEb";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Recover in case of node fail
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Carlos Meralto <carlosmeralto@gmail.com>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--nextPart2560242.THkU6b7OEb
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 26 July 2015 19:27:28 Carlos Meralto wrote:
> I tried "batctl ping -R MAC" and the node recover well. But when i try
> "ping IP" does not work and the ping blocks...
> It is normal that this happens?

No, sounds right now like something above batman-adv (higher layer) doesn't 
work in your setup. This could be anything. But right now it sounds like 
something which does connection tracking on L3+ like a stateful firewall, 
masquerade/nat, additional IPv4/IPv6 routing software, ...

Kind regards,
	Sven
--nextPart2560242.THkU6b7OEb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJVtSjHAAoJEF2HCgfBJntG9IAQAJxS6xMpw51nnYS+0EL/jOnJ
m6/rIVwxGdTy/v+QxT91N6VN/yqCAFB5CNPNXZUIOtrNqjj0tgcTYFmKJkLXPIzb
5u2G0T1pgnx6EMwn5QpNAXu5DY/Mh12KFCZsRRZtOQFO/shPv2fHzkz/Nhopmxcs
mpk1t5laMpxThUWUjKEAoMpT6AiQnp0AWbTxMjdXwQ+Cijd189cS2KYHs+pT35ej
QeLyCP33JYHz9nbc5ATZoTMWQULwXcxyA//H6t2684MrCcGoyhLpXf4nNgouGRnQ
gR0CO1p0MSwLOLaa+Wf67Y5J7QlSFcRJvlu0Ek3KgmxLQs3yt3Le3Qf94X+j0/RU
/jZ2oXZGhpdqdAucSjWMKO4OfjyIc4eNvREDiMnCBuDthfxvYo266RHMs12JOan0
Zk+/WZM4cMdRT52xB6tDTF08e8AB3jOlP0qKGUHIJpya/gPSShEfhWeyiWaMksqJ
D6wT6VW/x7g3bDQnkadEifpDd6oElHoXyvAwPJ+Waz3HXjbtEYhdgHjCeH0qEh/r
3be276S/5p+7XIpSFOxfLUGWTV3wlN6r+CB88m/DCwmIk/E3Oz5Z7oUaNJay8pCh
0YvIxfgH4HdnMhhGw2CsW41PUc2KjpkabksJGNzZJjiSjjAUiKf/OmK+P2Xw5BNc
N/abbZBb7SwQh6eyuE2c
=JVRc
-----END PGP SIGNATURE-----

--nextPart2560242.THkU6b7OEb--

