Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: Unknown symbol cfg80211_get_station
Date: Wed, 10 Jul 2019 10:28:58 +0200
Message-ID: <91929546.yq5N1g86sx@bentobox>
In-Reply-To: <c60bd64a-127d-229c-3bed-eb59803a54f4@canonical.com>
References: <cef22736-91db-6a22-6da4-35a4d53a4adc@web.de>
 <7eadb3ab-1b51-e248-6122-a7c3c73383c9@web.de>
 <c60bd64a-127d-229c-3bed-eb59803a54f4@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2452679.vzzFCWVnlo";
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
To: Stefan Bader <stefan.bader@canonical.com>
Cc: Moritz Warning <moritzwarning@web.de>, b.a.t.m.a.n@lists.open-mesh.org, Ubuntu Kernel Team <kernel-team@lists.ubuntu.com>

--nextPart2452679.vzzFCWVnlo
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, 10 July 2019 10:23:21 CEST Stefan Bader wrote:
> On 06.07.19 17:22, Moritz Warning wrote:
> > Thanks Sven for having a good look.
> > 
> > There is no cfg80211 module present on the system (find /lib/modules/4.15.0-1032-aws/ -name *80211*).
> > Package linux-modules-4.15.0-1032-aws is installed.
> 
> The aws kernel is intended to be used on instances in the Amazon cloud. There is
> no wifi hardware present on those instances, so it generally makes no sense to
> have those modules.

Yes, but then please don't compile it in. Otherwise other modules (which make 
sense on a server) build against functions from cfg80211 and *don't* end up with 
a nop-stub - just because the actual implementation was compiled as part of the 
cfg80211 module (but not shipped).

> As Jens pointed out the missing modules are in linux-modules-extra not in
> linux-modules (the former is not installed by default).

Who is Jens and where did he point something out?

On Saturday, 6 July 2019 17:22:01 CEST Moritz Warning wrote:
> The module linux-modules-extra-4.15.0-1032 installs the following files:
> 
> /lib/modules/4.15.0-1032-gcp/kernel/net/wireless/cfg80211.ko
> /lib/modules/4.15.0-1032-gke/kernel/net/wireless/cfg80211.ko
> /lib/modules/4.15.0-1032-azure/kernel/net/wireless/cfg80211.ko
> 
> But this is not in the *-aws path.

It looks to me like Moritz checked it (I didn't) and they were not available 
for his aws kernel.

Kind regards,
	Sven

--nextPart2452679.vzzFCWVnlo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl0locoACgkQXYcKB8Em
e0bmyw//VIp8kAaBJr4XkUzF4y8aIG7+qdbXZvHQNwvWgrH1b+s1vUjbiZ/wYpvX
wBfR/0RECdmHvqOz8zFzI7NFuFD4OQcaFJo4g6uE5jP7uG4xCbaWFt09xbJIs2BM
sVQllBjSAwpDvHStsF6tVwJMTZoiD7qeY6nyZ9sRHnIu3Bw1+FtAZGblp7XBln81
1sQ5+Nvo/wdUTgUbgqfq2xwLYSba0CZgdMJgjtwR3J+jNJVttKW0KpQRmleoH6w1
VSiuViV2zaVjuiJIOK1jrLmIyGqiNKGduLGmI2a8osTssrNXAfkUUdv3zXzSF7/R
p3EmrBzoJwpPAINNfVfCwOF5DsmoO7cv9SBWvGwe0crG0XmNAJqVcZQums9Z53G4
TeKq02tfHTr6Zki5C9IV5sAHrzNzjzA9lDYbIysTzJn0FKtW1KLsBlbexBIFxT7S
n9qCWKqVNhAc8s5387B8IGwu60nuoGUPP1xp8dhEUnzjXTUovLXNVsUBYVSgfJuZ
befUp2S4D4RpBRhZMt1ZdcOokYX91p2i18lrLjyXHnjcy6VSgYu6WDxT2QvwjRw/
q2UP4NzXg0838xk3SJ6VVkB7+s13+WAuWaWAc4BjqoMmlmR8r2OYj7+vBVaIze4p
L+pyntgQFE3NI0oxATqoHjGZF6Gy9IOsvd3Z3o5x+vsTR8YdGw4=
=tw4t
-----END PGP SIGNATURE-----

--nextPart2452679.vzzFCWVnlo--



