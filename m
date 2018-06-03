Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 03 Jun 2018 19:53:01 +0800
Message-ID: <2744691.dbA1SKQ1ei@lafayette>
In-Reply-To: <20180515234859.1167-1-linus.luessing@c0d3.blue>
References: <20180515234859.1167-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1890160.jyEfF3eJMx";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC PATCH] batman-adv: Increase DHCP snooped
 DAT entry purge timeout in DHT
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

--nextPart1890160.jyEfF3eJMx
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Wednesday, May 16, 2018 7:48:59 AM HKT Linus L=FCssing wrote:
> This patch increases the DAT entry purge timeout in the DHT for DHT_PUT
> messages which were triggered by DHCP snooping from 5 to 60 minutes.
>=20
> DHCP snooping will ensure a timely update in case of a reassignment
> of an IP address to a new host in the DHT. This allows us to
> increase the DAT entry timeout for entries inserted via an incoming
> DHT_PUT message triggered by DHCP snooping without risking
> inconsistencies.
>=20
> To signalize to a remote node that a DHT_PUT message was triggered
> by DHCP snooping and that it is suitable for such an extended purge
> timeout an according flag in the unicast 4addr header was introduced.

This patch deviates from our battlemesh discussions in a major point: It=20
appears to cater towards your specific use-case more than towards a general=
=20
solution. Can you outline as to why you feel the approach below is=20
problematic:

When a batman-adv node retrieves a MAC-IP address combination from the DHT,=
 it=20
issues a DHT request to the 3 DHT candidates (owners) of this particular MA=
C-
IP address combination. Moving forward, those 3 candidates will be referred=
 to=20
as 'global DAT cache'. Upon reception of the requested information the=20
requesting batman-adv node equally caches the MAC-IP address combination to=
=20
speed up further lookups (the 'local cache').

Today, the global and local DAT cache are implemented and treated identical=
ly.=20
In order to improve the ARP suppression success rate global and local DAT=20
cache could be separated with the global cache having a much longer timeout.
The network updates the global DAT cache whenever new information becomes=20
available. Therefore bearing little risk of returning misleading informatio=
n.
As the network does not take care of updating the local DAT cache, its time=
out=20
should be kept short enough to ensure regular updates.

Cheers,
Marek


--nextPart1890160.jyEfF3eJMx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAlsT1p0ACgkQU1VOj+62
HMB4dAgAk6Xu0M7fyZ6k8xKIsJITHbTg4T5zsat26+xTzcEFGwkOJKyJ8Kb5L0ao
9k3tpgcAOTcNYPgq3ilFegesT1oCrFzdxdillZhtrbkEIlEni2EikSMkiQKnzaT8
pNBGDawozERcgfg9PGYSa3EqL5oLZYei0UgJIioSMC8rXz0fiGC0ozLzr5+0cnq3
QCavZSkoSA1W1tK610CcOaUTviDfTpv//wCDUI3OEbvNoxOX4dxM7dU25ZdZ84ku
glVe4uu8NWbM5XBUPCeHdDepHxN1dLQDAClqYKQ4clproGjz/4JOk9uHbg13nMI7
JA1Phsw/9aDPOGd+i7eDruGLkZDK7w==
=CpBw
-----END PGP SIGNATURE-----

--nextPart1890160.jyEfF3eJMx--



