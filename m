Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 03 Jun 2018 11:44:53 +0200
Message-ID: <3539597.lkrFk2ZsHA@sven-edge>
In-Reply-To: <20180601153845.26561-1-sven@narfation.org>
References: <20180601153845.26561-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2364214.zNnPjQiKyH";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Drop support for Linux < 3.16
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

--nextPart2364214.zNnPjQiKyH
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 1. Juni 2018 17:38:45 CEST Sven Eckelmann wrote:
> The Linux Kernel 3.2 reached its end of life [1] after over 6 years.
> Instead it is recommended to use at least kernel 3.16 which is also already
> over 3 years old. All older kernels (v3.2 - v3.15) should therefore be
> dropped to reduce the support overhead.
> 
> [1] https://lkml.kernel.org/r/a3d2d2b2c3559217eb8315d25df0c5883f922066.camel@decadent.org.uk
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---

The servers already stopped testing these old versions. And it might also be 
interesting for everyone that the extra "build/" directory was dropped. We 
only needed this directory because we had to patch the sources before each 
build. This is currently not necessary anymore.

Unfortunately, we will have to keep compat-sources and some of the really 
crude hacks until mid 2020.

Kind regards,
	Sven
--nextPart2364214.zNnPjQiKyH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlsTuJUACgkQXYcKB8Em
e0bidA/+IJV2TnM1ql8969FoXF7BvOGUuTGb9YFA59KGq4T0HQtbyy+4ywP0GBuW
ggjdXo3qS21SsNr71b5sa+Ldm/ErR81r63aWZ3FGlMMFjC5YIqDF4CQ1b3GrtxT2
jg8S/DU2JrMUojyGxeR52n2o4XtO/fEhVPSp7OBDtk4ajKXCrqVv9EENOITllRMi
d9AnBgEsCQVmRdXg2YIfCnIwXzfmDVQ0EOWicql9FB2E/7pxVbgDNey/siTauZOb
nln64383YkH3SAeWkBK9dlKcajhnZiZu4uUv6a1ypMlLEVQRPz3/O+pgez2Xaluy
A6pvN9u4O034qVO4fBGHh4lQsX4l4gojFD5CrR5ADdEeT970Zg3xeWotpESeh13w
vq+eiBceGkNw2WEjA8fGMJOE/M2q3cw20DshxMIUXhTU7Ahpev2v2G2qhl3kUhfy
Fp0kYr3MmoDjUbwoV5ZEtDUN6uKfKUasdpK49NCHl8OerfTkeQYIEZeIWLkt58Bb
ctvlAOVS5EzKZ1A/HM9O/+7sO+5h779L3w99wN8DW3XLMc7euR+7jMFUHsB3jvss
mCunTU+iXOlyl5yLe7/1zbvjHTiwjw5chdO/loWy3jj9zhn1x4shjFhEaXb4OCIn
g0YupKsA9T7q4CJ7+38XxdB6FgTJvMSXk68ZRblVfCZ3RXhxhBE=
=7LdH
-----END PGP SIGNATURE-----

--nextPart2364214.zNnPjQiKyH--



