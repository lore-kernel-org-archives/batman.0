Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 20 Apr 2017 20:04:08 +0200
Message-ID: <8630867.MyzoOeHIao@bentobox>
In-Reply-To: <7dba317c-2fbb-2d4b-6d3f-17545395adbd@tu-bs.de>
References: <7dba317c-2fbb-2d4b-6d3f-17545395adbd@tu-bs.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1538189.8kWiFgrHgq";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] batman-adv route selection parameters
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

--nextPart1538189.8kWiFgrHgq
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Donnerstag, 20. April 2017 16:10:02 CEST Harms, Hannes wrote:
[..]
> I run into the problem that batman-adv sometimes routes traffic directly 
> from Node A to C.
> with gives me 5 Mbit throughput, and sometimes route A-B-C is chosen, 
> resulting in 25 Mbit throughput.
> 
> I have adjusted the originator interval to 200 ms, and the hop penalty 
> to 1 without significant improvements.

Set your multicast rate to something meaningful. Usually 1mbit is used - which 
is too low to make any sense when comparing the mcast packet loss with the 
packet loss of the higher unicast rates. Maybe you can test something like 24 
Mbit/s.

> Are the other ways to force batman-adv to chose route A-B-C ?

Maybe you are interested in B.A.T.M.A.N. V which actually uses throughput 
information and not packet loss.

Kind regards,
	Sven
--nextPart1538189.8kWiFgrHgq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlj4+BgACgkQXYcKB8Em
e0ZW3xAA195uODQokaWAAgkBUpbAmmI5tvvrPMYZQrCdXMaIGuHhw1wWkKqR3VAl
mzuUFlWP7x2mUEHV2II/9g5M2Q0pySFn8imPYFLzgmgG+b+b2KUilw/tKKhiuLyE
Z0qgrZOqec53zRsMDIxxaS73viPXFYji0LJvh0TiPj59bA13u5LMaaIenKo3Innf
2kEcbWpqnZvSogCFejn79AagMHh1t2kQHDBjVPbc6YodcGCum7H8ZF4ma2o+fwzp
MRCmJAJbit6NfF2WWIwm/KUDxCnlDAWTPPGbC3y6lRrBn96iOBdf/yaIP7fICrSo
3F5qe7gCijnEU4PqGQo5mJObSfDaORjfA+BIxvTyp1ZiENSWIJEs4B2rlO1Tgj/H
RBhvM3H8uFUcN9jgKL8wqpZMmUEMtPP/zP1NbACl0B/75mKVxoc0/P1SPmYgNS2x
e84LF5byPbjWNd28FuPH94DY9uMBDYpuHdpQT4qjj1H/V98OsMelJJ6FY3y9JnhS
5b2OUgecpBOc89Koy0aDf6/NvlNDciEqJOixuGu94KUH9rLD22FLjZy+raz+OwwB
kWEQBYLLd+ipLDIQJa8DXCGnypN73c1WZ7B8QlMuHXLyEhymPnUNDBemRhoXR1mn
78/WQLDJctNUdiJadmLbtHOuiTXU9rf2IE1vmemqp96BIPurhdw=
=78vk
-----END PGP SIGNATURE-----

--nextPart1538189.8kWiFgrHgq--

