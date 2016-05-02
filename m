Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 02 May 2016 16:39:34 +0200
Message-ID: <2777130.u5sIhYUgAL@bentobox>
In-Reply-To: <20160502141041.GY11201@prodigo.lan>
References: <1460626198-31226-1-git-send-email-a@unstable.cc>
 <2815997.TuhcixZTPn@voltaire> <20160502141041.GY11201@prodigo.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4446933.7gqQqHy58r";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batctl: tcpdump - use proper format
	string when printing help message
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
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart4446933.7gqQqHy58r
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 02 May 2016 22:10:41 Antonio Quartulli wrote:
> On Mon, May 02, 2016 at 10:04:13PM +0800, Marek Lindner wrote:
> > On Thursday, April 14, 2016 17:29:58 Antonio Quartulli wrote:
> 
> [..]
> 
> as explained in the original commit, I was getting the "opposite" warning. Now I
> don't get it anymore. Not sure why.
> 
> I'd just suggest to drop the patch.

You most likely had a different patch which used BIT(x) for DUMP_TYPE_* [1].

Kind regards,
	Sven

[1] https://patchwork.open-mesh.org/patch/4084/
--nextPart4446933.7gqQqHy58r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXJ2amAAoJEF2HCgfBJntGKhQP/Az8M50g/ZxyqgXe+zMbgomC
sM2tN49GQaMDVCAPLfLXgH9tvTROhBG1swN6b6iti9xtlELiMGb+dxg19kiSA52c
AgE88n7ufR7JTz1nVZapGWaJRRWAtRsC+ZBvYt80jgRo1Lmsr9NbxWSGgF86+z+S
xdFv8KdFQyD+XEzKBfQ2A/gt9u2rSeuDFdF3H/ijemOEuTD8AXPEPy0GGomgkxEA
DZqi29W7jTJgxs3t+doiq8dkHmp64JNgr41o7MG22kyDLc+Pd77dIS5+iluO7/64
mtLijynUtwL9zPix1qNXs/EegDg5KJHVTTMudSEFaXABQ9gjfEbVat/eSRuBMciA
QXmJMReVrq7oCnsYVzdmb4OhZZKHTdKtTaUe6sf3m2qzr2yNsbeTkK2lQ/7rrXib
Nf3/nOsBnhvbhGMI0ybaDV0cEyOup9inAQbzPMXauWAJFYZJxn+aE97M3i/kLUPG
yRSXSq9KK0d7kLGjv763W3Nx0Iih7Noedywj6EVwobTYiDtkxIDx4aUolPp3xOsY
BM2G5DjkwtfyEnZCwLYCPFJmTIXDh8W/dBqQTRevrN/N9Zu64GnEo3YtCTMsA1ts
+qcP7CwrQu7gRzOaBS4BrGJuvKQ/WmlwuFllmk1Rheax8iwJ25eTa2ZVOjDEL5MS
1omPBZnVbSojKsDXz3Zb
=4SkG
-----END PGP SIGNATURE-----

--nextPart4446933.7gqQqHy58r--

