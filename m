Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 01 Mar 2012 09:32:14 +0100
Message-ID: <4108295.m2JrXqq1dS@sven-laptop.home.narfation.org>
In-Reply-To: <1330587321-12177-2-git-send-email-lindner_marek@yahoo.de>
References: <1330587321-12177-1-git-send-email-lindner_marek@yahoo.de>
	<1330587321-12177-2-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2120309.OvBjLW8D4U";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/6] batman-adv: introduce packet type
	handler array for incoming packets
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
Cc: Marek Lindner <lindner_marek@yahoo.de>


--nextPart2120309.OvBjLW8D4U
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Thursday 01 March 2012 15:35:17 Marek Lindner wrote:
> The packet handler array replaces the growing switch statement,

> thus
> dealing with incoming packets in a more efficient way.

Usually (there are corner cases) the compiler tries to build such kind of jump 
table from a large switch block. So be careful with this statement.

> It also adds
> to possibility to register packet handlers on the fly.

This is true.

Only scrolled over the patch and it looks like the thing we discussed :)

Kind regards,
	Sven
--nextPart2120309.OvBjLW8D4U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJPTzQOAAoJEF2HCgfBJntGpycP/iU/Wr7VrOskNl8IkLTENhX9
Cy4vVmErMHXgORR/nGNN8gnLA/4HwABI3PrQZg/Bt5GHgZ1usktzx/1vNL8PnW2Y
M/5sBxFPJb5w7OgxN1KoSLZaBopNWxI8HJwZeKfII6Fj2BUkPEqTHIuft4NfJC4Q
3F+yO0gNwtHrN4w30IQajF60Wd/iy3Iw3RE14CAtXHAZ0MZJJRTjUaXEH/6DxZu4
q1uCZTsR3Ml+O+TEBNw32iFTWCiwWwlXvXJvpMXvfhSvF/8Ycqqfueh3/RrMQ4qT
paI5uJ8cT59jmd31ueTKP38n/PqL7WjlpMvQN3OI3T9cdGAbsHZpHcKbHB/n1tFc
PywqO5ujoqBfZo1mCqQKaQXodhr7eS8PFTXLdsYysfc9oZs9tcthrPPJYTi7PI1q
lm0u4W+ugG0MmnPXY4FMJ/iRyQh6oFiGam9kCG7CFuctBxI9iFh85wXyxPDVoALA
dGKYm06vKchq0PS9AWm4gOBXC9Fi61vzAHzB9gJjNceisLRKmgKFL5s94JC7A3+B
PZvxbTiUt4Vm0sZ/QDLDnlUNO1JfCimehqzoO4z/G9Uxhx3moPcefek79cO1aGFQ
ScLAueIOBib9V3TsV0mYwfQ1VpF5UOCoPJz0nuROdPcPJ9AKMFGvnpDaRrBhnHry
svq7l7J9pPLVrODTv0tX
=l3kb
-----END PGP SIGNATURE-----

--nextPart2120309.OvBjLW8D4U--

