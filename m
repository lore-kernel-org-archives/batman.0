Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 03 Aug 2012 12:01:57 +0200
Message-ID: <2644807.rpvzRr0ts2@bentobox>
In-Reply-To: <B6EC8CB5-DDE0-4708-B89E-FADE58F33026@gmail.com>
References: <BB2F02D2-9B93-465E-BB7D-FA13492511BF@gmail.com>
 <2670997.NDZah7qDiQ@bentobox>
 <B6EC8CB5-DDE0-4708-B89E-FADE58F33026@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4927392.8c8rcN7n2n";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] Batman-adv and routed subnets
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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


--nextPart4927392.8c8rcN7n2n
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 03 August 2012 11:40:43 Luca Pretto wrote:
> Thanks for your answer Sven.
> 
> So, I've obviously misunderstood the part "mixing non-B.A.T.M.A.N. systems
> with batman-adv" [&]

This thing only explains how to connect non-batman-adv systems like you would 
to with a switch... not routing.

> I admit: the fact that batman-adv operates al L2
> really confuses me a lot! I'm a DIY nerd with no background training, so
> it's quite difficult to me.. But I won't give up! ;D

Just imagine that the mesh is a big switch. Such a thing that you have 
(propably) on your table. This version is not in one box, but build using 
connected small boxes. It depends on you how you want to give clients access 
to this switched network... just use L2 switches/bridges to connect them or 
use L3 routing to create smaller broadcast domains.

> So, do you think that I should try to setup OSPF on every node, to keep the
> thing as-much-auto-scaling-as-possible?

Sry, will leave that open for someone else.

> But in that case I suspect I won't be able to use the "Gateway support"
> functions. Is it correct? [%]

The gateway support stuff is just for DHCP routing. It helps sent a DHCP 
packet to the best gateway. And your setup (that routes packets) will not sent 
DHCP packets from clients over the mesh, but instead each router has to answer 
it. So yes, normal L3 setups will not benefit from the gateway support. You 
may still use it when you configure the dhcp server on the routers as dhcp-
relay-agent (but only when they still forward the request as broadcast and not 
as unicast to a preconfigured server).

Kind regards,
	Sven
--nextPart4927392.8c8rcN7n2n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQG6GVAAoJEF2HCgfBJntGj4wQAJxCcavOs+xgPVUBcqoFILdo
pgUU7gSBAcPD/kJqaIcQgrtweYFBkpekR/1lg9zQd8tFJTtCy9dtqzUqT8t0cqe7
LveX4kmL/fqMzGKt/JssRwVftZoQuecK6C9ch/s483Uk5ZrWncFQ2WxBObRk5/By
XDazXSqbleoTE0rEyXjXOrSH6HkOlFjYzx5i6pNortHFqxA5iQr5zgv8ToQtOdxV
gALhvswKeOR3bJmLtADbECjANDLXTOu0F8mdLQZgEPNFJRJ9TrVVX6vcdkjVITQE
p5mTevLb96KG8TY1nja8UNEXH5rZmqUa5wgSqH1v6qfsViEv0UW+AttctDa5oZLn
nBaO8NbH+cU6CzuN1j3xcssJkrtdxXAMSIeIbA5xetbQXhOkY+c9zhPSHDSFmqhQ
D2ir50fx/aiNPBIgcmlvy52xEDPfC+2O4AMMg9LAd5Ccyx55DuWhjzdLjIBLlQg7
RtefV8cb5+dKRAzP/Ls58YEaQo1T46aTgkPIwHbIIuoUWJgH1fJ6UAScUJfUp5+h
pxaZknKDhHCWX3a5yM8RXD7lB0Tc7x/4SUge8NAxCEq9iM7kexuXOC2v8HqyEV2X
Zc4HbW6WNOeBx1sXOnUZmbJdjEhCP1qG0cZ8iBnrbWLqdAtdrGFnLeGvA7F7Wn2B
dLg7CZVmB/jZKyBYi/qM
=HXdW
-----END PGP SIGNATURE-----

--nextPart4927392.8c8rcN7n2n--

