Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 30 Jan 2017 09:29:47 +0100
Message-ID: <2294492.igdRLrzzDz@prime>
In-Reply-To: <20170127141044.5317-1-sven@narfation.org>
References: <20170127141044.5317-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6518158.MVUiABnpYv";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] alfred: Avoid buffer overflow while
	querying ARP cache
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

--nextPart6518158.MVUiABnpYv
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, January 27, 2017 3:10:44 PM CET Sven Eckelmann wrote:
> The arpreq.arp_dev is a limited buffer (16 bytes). Avoid that more bytes
> from the interface name are copied into this buffer by switching from
> strcpy to strncpy.
> 
> Fixes: c7da798113a2 ("alfred: IPv4 multicast distribution support.")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Committed in revision 26ef92b.

Thank you,
     Simon
--nextPart6518158.MVUiABnpYv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAliO+XsACgkQoSvjmEKS
nqHXEA//QlOXWZtfDn49ClLLFuE6wP5H8ReecLJjvOpb9ZKrn7dGrZQvTlyzxowM
We/fGRNkzF3wW8+MieJql8IQ+AtalrLwB59oCNqG4vpnqJoatE4I3hjf3XxkqSh6
MItsn/ZyNvziZSwjpzmbN2TvQkdkP/6gGsvRqfLa6fOIypA6w2Sz7HrePAy0ZKVe
CqfL3+T0aM34K86KFjqC9g8nOoSDT0t9tPHQ0iMjnrS96XtXKZ3MEO/Dc3lM/u16
O95kKSe2LNPJfXA+EAgVW6OU8MJv5tX9NyHQLkfk/dTpabZbTtolHs7YU5BDwS9j
HntRpHKWbD7ZKOL/ss6F19ynqK+fcz1vPyCVRqHjsowOVYcCbephy9SJ/YkD1aDd
yr/u/bc8NMsEBbwUxb89GxXkNJi7wGaW3VgvwxuCa/m/I4b1uEkk09N8KWNAG/Ix
LFi+3vDHzOBgoHSlk7KVkRVyvgrH8SkqlbgcBZPDgzAcoQ305h6Dsv5vzzCFd+aV
qXRWuoX0qGm7teNIsCvJIQZMUN+T9jYOJe+QYKLBcy5sDy1+NsZbm2V3QTaB2nnA
7KN4MBTPglG4addRAH7omrsDEmLjKWSROztxHDUC/S6Nf3c5WZwtMdGUJthT03OK
QCbSvcFnbtB4GKev27Xs/1D6sPqerblZg8hQArjQeDU6pNzn8a8=
=2izF
-----END PGP SIGNATURE-----

--nextPart6518158.MVUiABnpYv--

