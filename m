Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: batman-adv for kbit level speeds, external neighbor info
Date: Tue, 16 Mar 2021 14:36:22 +0100
Message-ID: <1686262.MoqjggJXJV@ripper>
In-Reply-To: <20210316131750.1198.63671@diktynna.open-mesh.org>
References: <20210316131750.1198.63671@diktynna.open-mesh.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1635464.8lGXPOoK3Q"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: oytunyapar@hotmail.com

 
--nextPart1635464.8lGXPOoK3Q
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: oytunyapar@hotmail.com
Subject: Re: batman-adv for kbit level speeds, external neighbor info
Date: Tue, 16 Mar 2021 14:36:22 +0100
Message-ID: <1686262.MoqjggJXJV@ripper>
In-Reply-To: <20210316131750.1198.63671@diktynna.open-mesh.org>
References: <20210316131750.1198.63671@diktynna.open-mesh.org>

On Tuesday, 16 March 2021 14:17:50 CET oytunyapar@hotmail.com wrote:
>     Do you suggest, batman-adv, for speeds like 2.4kbit/s (very slow networks)?

No, the discovery and link quality propagation packets can easily consume more 
bandwidth than you have here. Of course, this depends highly on your setup and 
configuration. For B.A.T.M.A.N. IV, there is at least a chance to support it 
because it has no idea about the throughput. But B.A.T.M.A.N. V's throughput 
metric is not made for such a slow link speed.


>     Is there any way, feeding neighbor information to batman-adv externally (etc. using DLEP protocol, as an external link monitor)?

No, not at the moment. And you also have to be very careful not to introduce
bogus TQs or throughput values when doing things like this.

But in theory, you could write something to inject such information via some
new netlink based "protocol".

Kind regards,
	Sven
--nextPart1635464.8lGXPOoK3Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmBQtFYACgkQXYcKB8Em
e0ZPJxAAg9k/JPQ8DpN0jvx4Ukp/75Q/O13bS+ApZTK4q2xl/C3uRb5DJvA2kaPA
3ZFm6LF2J0f+jO3YhpOK1iMFNK4KqvmFjjS2tcWAmH1oUYeWZ+6XsgbMvjJjfmyI
tgtnV8VdRQeG/822BqFZLwCStvPIcVHPQpg6JReF6x3EYzFh9T0JQXdjMxI5b97/
2khxMhu11BdtMQNHt5sR1Py2+mOb2OHYISE4kLR+BjfoMi+vnYG9ze8/3rugo0Bn
peGPsY0hg8MCy0nwYxYCuFKMtKRJGxd5BNuvh1O34L7X+hdAS2YCapm0DjYIHdXX
wgidKuE0OnGRLMpeLlwiw5m+il/xqbItjRndiMwhvJ5TqkcmnLLSGK9ngLzIUWsD
KpM0pwidxaSZyk8YQD8m7wnPgQxEx3n7LHijxBBLUqquvBwC45+ouzSkfU4Atk/X
9fiRh9v7NqwUh/nHqTrK3wc6MARgIjEHhAZc+x9443SinwW6GYEg9ucaOFpLMoBT
xyDYKUAjeyCgaXZ95TCUitvlvQnz5n1eYx504xLUXUmt36YeJ3IuYjTrpGzEiu1E
o5kCQshXjiAOV7BYMZlxGKp+u5PaRzkcIw3xKlkP3a6ZgumTMrVI4TsHVUK/HXHv
dWWREMfkJPt5BXW9o20hQzWW99S9JWB14saFsF8l2tRLXj9tOiw=
=/Zry
-----END PGP SIGNATURE-----

--nextPart1635464.8lGXPOoK3Q--


