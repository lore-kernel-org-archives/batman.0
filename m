Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 03 Apr 2017 18:12:25 +0200
Message-ID: <1614094.q8xjyvsmAh@prime>
In-Reply-To: <20170401124706.18257-1-sven@narfation.org>
References: <20170401124706.18257-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4923518.JeR1JaYdr6";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 0/4] batman-adv: ethtool code cleanup
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

--nextPart4923518.JeR1JaYdr6
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, April 1, 2017 2:47:02 PM CEST Sven Eckelmann wrote:
> Hi,
> 
> Philippe Reynes sent in a patch [1] to convert the get_settings stuff to
> the new ethtool link_ksettings api. I've therefore asked Marek (original
> author of the ethtool stubs) whether the code is still needed for
> something.
> 
> He couldn't remember anything about it. This was therefore a good
> opportunity to completely get rid of the code - instead of converting
> not useful code to the new api.

Merged in 9e8d507d..080d75e5.

Thanks!!
     Simon

--nextPart4923518.JeR1JaYdr6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAljidGkACgkQoSvjmEKS
nqH5uw//RdOotWb9eQZ01eb5c+mjrmDtP4dVUpsC9JGhgIDxI+uEWJQn9fZXjigL
Q7GpWUKFiA/aM0DJt2xhK5n0mDhDQjq9dik5KTiY0jLnsmSII9RoBz7sdx+IPfjS
pl/S0jzg/9NjC4AQA1y92gKL50kgZ++dRjts6yz+x4rSThGsDPoKHm1voh3vjUYB
ZdLmZctVUfX8sweyRG449cdcPZ6X4koX3NiPw6rHd0QOS8jZ09PAaUQA0tTItSxP
CFuw3YT358OOHtWx8vCpATD16fy1Wq5LfAPY+m7SxxHdPB4dkW20eyWLkrsFS92L
NcshvbAFEe09UIA1CQRNz7CkXeHCdoBpNhhb1Ax0SzxKin9S+lvMV9eifPjLrYVS
6M6JV1PyrnncwTvmd530nLuOYyIxCHzNu3sEIw6nGQ8VINMymwGNrrcv1rN5BzIo
PsK98g6n3g5mpiaZy2jjtaag0VJbDIqkEwPcwK3ZwYf09yBON53kxbNnHnzekFHg
Dvv+ZJ5d6Cfjnh87oHW8aSsWHF5P6qhuTC67IQIGl/ZE/yNPUnlq/hrj58aVPeZz
Q+S49JrB8W/RFZgPaaLTOb0w4CeWH6KO0l1bW2tKzSsXASelQeahBTvbSo25Y59f
UY/STFFlosZKPAAbKm29BnRdjbIkt75qtrg1C9lNLPn7XMwGw+s=
=YFuQ
-----END PGP SIGNATURE-----

--nextPart4923518.JeR1JaYdr6--

