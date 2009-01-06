Message-ID: <4963633D.2020306@dd19.de>
Date: Tue, 06 Jan 2009 14:57:17 +0100
From: Alexander Morlang <alx@dd19.de>
MIME-Version: 1.0
References: <83b3410f8105237b1e68c92065dec7d0.squirrel@wm.ddmesh.de>	<200812172114.43427.neumann@cgws.de>	<3f7879383457743711ac3341637ff601.squirrel@wm.ddmesh.de>
	<200812191115.20610.neumann@cgws.de>
In-Reply-To: <200812191115.20610.neumann@cgws.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] dublicate HNAs / certificates
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Axel Neumann schrieb:
> HI,
> 
> I like brainstorming like this.
> We wanted batmand (and especially its core routing algorithm) to be decentral 
> and simple. So no central point of control/failure and therefore also no HNA 
> server. Of course there are many potential attack vectors in a community mesh 
> and probably there will always be until you completely restrict the access. 
> Therefore IMHO the preferable security to be solved should be:
> 
> - detect and protect against (usually accidental) misconfigurations like 
> duplicate addresses.
> 

sure, a duplicate address is something the routingprotocoll has to
detect and to react on, but:
duplicate HNA are very importand and widely accepted in the internet
community, they are called anycast and are a vital instrument in network
design and deployment.

as an example, anycast ist used for dns root servers, 6to4 tunnel and
many other usecases.

i am still not understanding why you are discussing about removing such
important thing as anycast.

anycast is a way to use distributed services, as you can announce an
anycast address on every node, providing a specific service and packets
will get routed to the nearest service provider.

> - find mechanisms to limit the impact of denial of service or other attacks to  
> the local environment (neighborhood).
> 

<removed>

Gruss, Alex
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (Darwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkljYz0ACgkQhx2RbV7T5aESngCgm0gopTcK+C17sHB29nz4jfsY
5JcAmgIS2EXnvL37QfFU/mAxnBRAQDMe
=nJZR
-----END PGP SIGNATURE-----
