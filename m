Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 24 Nov 2013 00:45:06 +0800
Message-ID: <8502078.3ioMQf3Zdu@diderot>
In-Reply-To: <1385141910-2670-1-git-send-email-antonio@meshcoding.com>
References: <1385141910-2670-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2220125.Jgp32QIr4W";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix compat macro for
	kstrtou32
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
Cc: Antonio Quartulli <antonio@meshcoding.com>


--nextPart2220125.Jgp32QIr4W
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 22 November 2013 18:38:30 Antonio Quartulli wrote:
> The macro previously introduced in the compat code to replace
> kstrtou32() may not work properly in case of a too large
> user input.
> 
> Fix it by using a temporary variable of the proper length
> and then cast the result.
> 
> Possibly return -ERANGE is the result is too big to fix a 32bit
> long variable.
> 
> Cc: Matthias Schiffer <mschiffer@universe-factory.net>
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
>  compat.h | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

Applied in revision 28dab26.

Thanks,
Marek

--nextPart2220125.Jgp32QIr4W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSkNuSAAoJEFNVTo/uthzANJIH/jo7BGxUZfrXScXgjtjYo95e
5JNa5vksXdnMiEKnivfnmvKISc3m3J1esoFB/AmYs0JDzzLauxOhoFOUYuTt2iif
YCpyr8ALS7zhkQgYo8EEKmOB5N+Kji56CgdOSaN835loC25YyjnBn/k3TKcJJGvi
ii23y4Jm48ZRwKuG3F1dzI9xpNmVhbI274HpzlUXXRGk4MZcQeqF125OUJRDjm+v
Mau09uzIjEmBRxeIqIksWIBvOA+pDEV3UA1xsF8y/v01z/h6kevBMY24kd3tdLKL
QoSi1bM3/AFMFCxXHQLOTItvigqaL/m6fJxdGldwF2u/iNMFfZ3YlCM9uNifuyw=
=Xj1s
-----END PGP SIGNATURE-----

--nextPart2220125.Jgp32QIr4W--

