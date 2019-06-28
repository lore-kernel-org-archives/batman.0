Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 00/10] pull request for net-next: batman-adv 2019-06-27 v2
Date: Fri, 28 Jun 2019 19:01:41 +0200
Message-ID: <5314018.Pl9QOMrv0R@sven-edge>
In-Reply-To: <20190628.094905.1673194288384587104.davem@davemloft.net>
References: <20190628135604.11581-1-sw@simonwunderlich.de>
 <20190628.094905.1673194288384587104.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12596660.8597IJa787";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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
Cc: David Miller <davem@davemloft.net>, sw@simonwunderlich.de, netdev@vger.kernel.org, Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>

--nextPart12596660.8597IJa787
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, 28 June 2019 18:49:05 CEST David Miller wrote:
[...]
> I think that when you have the read_lock held, RCU is not necessary in order
> to use __in6_dev_get() but I may be mistaken.  Just FYI...

Problem is that the read_lock() can only be used after the __in6_dev_get() 
finished sucessfully. Because the read_lock's lock is stored in the inet6_dev 
object which was retrieved via __in6_dev_get. And the __in6_dev_get kerneldoc 
states [1] that you either have to hold RTNL or RCU (see also the 
rcu_dereference_rtnl call inside this function).

So we can only drop the rcu_read_lock when RTNL lock is held . I would guess 
now that this is not the case here - Linus' might want to correct me.

Kind regards,
	Sven

[1] https://lxr.missinglinkelectronics.com/linux/include/net/addrconf.h#L335
--nextPart12596660.8597IJa787
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl0WR/UACgkQXYcKB8Em
e0ZNUQ//Q5B0cDiKqBKCEmIJewmh45xzefWAbE5/RtSsXKdPbxkj+AlB32tgWfmd
guxcArwDB5A8WYXead8dbMMiRRsBHQ4ZtfI+1DlfJMOPlCQVevYtlsf+or2eujc7
5WvaihO4igWfFnQd9YAGePaxFsUfYXLonF/VW1iclZKnwYkFFuyT3YYm+JmtTzXE
TFU734So4SCAF/osZwMtRkqS5G1mIOmSRYwb4rzC0Q8LpBy3QCmE+ho335vGVa+i
4Z2f1JeFECjJCKs54WrEwa1QsPUy1XuvZvqPNNU5g23gFiH9jvHoyhUIIn5iUaQF
N5HzOq3njEL11Zl8HC/wotjnZPxiLtF0Wvur91H54Xi9c+q5/nnYRTiUWUL6e2aB
3J8ryb2syZiOoTsxrqr0Sfz7Buv/nVQF96M3RKw9KpN4VJsFtmmFpyAswcIVrKp6
mHPEgCmq7wwmzPv8QJv0jhTt/XLOSjj+LRVp+YdeKElIG7HPG3hmjF5bFvhbz1ES
iXaxMy7NTtTxwbP267z9TRZNXsYJ/cqBUiSf5UjcYHKR3WC/Zh1RLb6t5NQRdXeR
rM6X142fcVi78FQhHQNZWLuOzCto1bYW1RgWr5V59jhI8xLByf93lOzlANFXfttL
wDj1ywSo7pL0qmgesw3q3iXo2UBQHDCFpn7xJuk7yqW+rWCukCk=
=nszJ
-----END PGP SIGNATURE-----

--nextPart12596660.8597IJa787--



