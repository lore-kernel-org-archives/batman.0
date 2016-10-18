Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 18 Oct 2016 14:25:34 +0200
Message-ID: <2059029.BTNThUFUEN@bentobox>
In-Reply-To: <1468961051-6447-2-git-send-email-sven@narfation.org>
References: <1468961051-6447-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1764497.Zdk93RuqUU";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [2/4] batctl: Use monotonic time source for icmp
	timing
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

--nextPart1764497.Zdk93RuqUU
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 19. Juli 2016 22:44:09 CEST Sven Eckelmann wrote:
> gettimeofday is not monotonic. It would give wrong results in some
> situation like leap seconds, when switching between daylight saving time
> and non-DST, NTP changes the time or when the administrator of the system
> changes it manually. The function is also obsolete since POSIX.1-2008.
> 
> clock_gettime is recommended to get a monotonic timesource and as general
> replacement of gettimeofday.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  Makefile    |  2 +-
>  functions.c | 17 +++++++++--------
>  2 files changed, 10 insertions(+), 9 deletions(-)

Applied in ef7cfaa81f72292f67afe50303ac657f41280853 [1].

Kind regards,
	Sven

[1] https://git.open-mesh.org/batctl.git/commit/ef7cfaa81f72292f67afe50303ac657f41280853

--nextPart1764497.Zdk93RuqUU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYBhS/AAoJEF2HCgfBJntGYQIP/19ZpCqvOVZX4pRB6/zZ1tBa
juPL2S7wyW7lIwL4WGppZUtyx9D+OAdJOp8va7GHfI7u1CzV4qqzxdQdmzvhMPeq
7uVMwf/dYMGFbjcUIoUgGiWhDIJSbqlilavLknuJzrmXKn2mJC9ZlCfUAnvH4q/y
ZcOWBEUgpUp4YPb/nKF+h88Avwer7Yu2sJwQDawELs9NEQ36bAWXG//xOvRirr0z
Y5fl3ZL+k770PENNMrMSYMktP3DrIFRPixxxhpAd6WGzfGQsE4PjN5G+bgxEIL8Q
eFKR6LZHIKPZE4yVnX60hs2kRiEaR0A6khfRztKeaj6m6yq3zzsMZt+aLNcOAp2J
quoLnt1QTFNg0A8AfnkoCMS6RXEPy607MVz8kAd2xah7rON7CjBX63d63yITVLz3
Yv2RBfjte7Nwfx2g7tS8o/oHgXU5NJ7sBezkCQFYIH+EHekAvryaEdCm7yX9+a4d
haV2QqCT+Mi7qxFFvJovuOawu0iA8CwAGdd9DsjsYt8Z/dbpxbYBsOGe/QNKhoXK
7lgbplV9e0b/1OA4//y9+xMmBXLUhsp6nAI+nlZ6n7cnKVCWRiaQyaN3G3BCC7ry
oFooE6jonP7DdfqURYRXrAHwwfJ/49O/VlzlZF0O/ndGTYO1SaDga31f8ojPtrBl
PLt1OI8cBamAV+F/O3a1
=vks0
-----END PGP SIGNATURE-----

--nextPart1764497.Zdk93RuqUU--

