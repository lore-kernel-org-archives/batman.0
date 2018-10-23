Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 23 Oct 2018 16:06:46 +0200
Message-ID: <5881573.Sb6ha2483l@bentobox>
In-Reply-To: <722f811f37e870de99c4d9e4d11c28b3b9aa9bea.camel@sdl.usu.edu>
References: <02ef01d466a6$f0c629f0$d2527dd0$@sina.com>
 <2008119.62L72lsrl6@bentobox>
 <722f811f37e870de99c4d9e4d11c28b3b9aa9bea.camel@sdl.usu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2398047.O3lpLZltjp";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] alfred and batadv-vis issue
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org, Jonathan Haws <jhaws@sdl.usu.edu>

--nextPart2398047.O3lpLZltjp
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 23. Oktober 2018 13:50:42 CEST Jonathan Haws wrote:
[...]
> > And of course, Jonathan's IPv4 implementation must get the mac
> > address using 
> > different methods. It is using the function ipv4_arp_request to get
> > the 
> > information from IPv4 neighbor table. And it looks like his
> > implementation is 
> > missing a reliable way to fill this neighbor table.
> > 
> 
> Yes - my plan is to implement a manual ARP request, which if that fails
> then the behavior will be as it is now. However, on success, it will
> have the correct MAC and everything will be good to go.

Manual ARP request sounds weird. What about 
https://git.open-mesh.org/batctl.git/blob/83faa3126d6cc984fff10760aa975bacec043632:/functions.c#l537
and
https://git.open-mesh.org/batctl.git/blob/83faa3126d6cc984fff10760aa975bacec043632:/functions.c#l702

Kind regards,
	Sven
--nextPart2398047.O3lpLZltjp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlvPKvYACgkQXYcKB8Em
e0bhgxAAv4sl3aj14LPaX/sVFHFz9dfw9YryMFJgMAZHSAAVdmvrDi+XUAjKSr4z
0IOItnLCEKx35EhXJ55J4ZxMeuHpVkVzXQ7ZtNgFh5SWtZr5CepJ4ZvmaTdqmcjY
8VYD5yWQhO1Pwl4kUZ4ov5/XiKmQJ5i5ikABBSfhd/lF8u7QhlkUh40xlM+FYfkX
mcpWdDpa4MJZtC9jBLxhLpMBOWgWD2BzOp3H7kue42Ar1TO+XwWe9N8HOwx+YhdA
87FgW4SuSfXNrtGfYWu3T/MOvrdYzCHVP5WQANLb9bMstMz6UNRoOU2UNW1gfzMW
ZHTu6phaUHYg1cjpQNR8kcVSoWAb9oy/oO00mLJ76u4bkn08NgtTs+gHF0sQg0ym
8YDY+eq41zlSTL12RAEwunoT1gex3TkYBC8mgf6Udrlqpbgpikkmu4UAKOXxrf91
3BCyFY1A7spLh3sr8Ef7Lta0BxTt/VJqWA5R6mcvoE+k2NvN02OcIDYuTb4qpAu5
96f+PJJ+DzEfKb1gny60sKOKpnfYfnlFRiQR+oKUHbtL4PydyGjYuYvF1AOhPgLW
5UBDaQj5aPDFbnWecSjdjyAcBjJNnGa0wCskRFCearjWJmnRVpwbsRPcKkpfbq65
HYUNpVVxAjoQAcU3GrZUbvmjdSGZABeawyUxX2AhIC1BIlfbtL8=
=YRHJ
-----END PGP SIGNATURE-----

--nextPart2398047.O3lpLZltjp--

