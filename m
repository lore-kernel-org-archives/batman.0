Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 29 Oct 2016 13:46:59 +0200
Message-ID: <2528373.sE2IHzpoFy@sven-edge>
In-Reply-To: <20161029105628.GE1692@nanopsycho.orion>
References: <20161027190150.7880-1-sw@simonwunderlich.de>
 <22392280.4UY6GoIrAk@sven-edge> <20161029105628.GE1692@nanopsycho.orion>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3996215.GW0L9WpkYn";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 03/17] batman-adv: Add network_coding and
	mcast sysfs files to README
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net

--nextPart3996215.GW0L9WpkYn
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Samstag, 29. Oktober 2016 12:56:28 CEST Jiri Pirko wrote:
[...]
> >> I strongly believe it is a huge mistake to use sysfs for things like
> >> this. This should be done via generic netlink api.
> >
> >This doesn't change the problem that it is already that way. This patch
> >only adds the list of available files to the README.
> 
> Sure. Just found out you did it like that. Therefore I commented. I
> suggest to rework the api to use genl entirely.

Fair enough, I have added it to the issue tracker [1].

It seems there is no easy way to drop support for modifying batman-adv
attributes of the interface or its ports via sysfs in the near
future. But disallowing sysfs for new attributes might be a viable
policy.

Kind regards,
	Sven

[1] https://www.open-mesh.org/issues/300
--nextPart3996215.GW0L9WpkYn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYFIwzAAoJEF2HCgfBJntGWZwP/0ihDN/YbhoBU1CKEkSrOK5E
HSGZcaQ+mhMdE4uGdrvqIRZDx/Gm8EQnIJFE0YnK2kak4YWgjIVHJvnM8Qryp63C
U16XtnIgj2qCKDpZVPukKEK3bGouP68BLsaThwqsdzO4ncvLdT+lry+kRTtFNjU6
76q5b0NtHDOF/sfmnsmzWGZoy9HUtrJcv0VDIDWv1abwkijIUZHADGmosrPQybWI
Pjjo0rE2MnCW6xqc93/hjynuKp9juHTfv0eVMqaXeRbWkzb5h7ZevCTITqzNeeBg
Nyp73SJaYcKe//YQoVUfrRTzZn7ZaexHQx7PUkFllsPVFDNr/ATQq6SWhxXa8JaC
F+SiQw0V/cUEc+7oNgAvtN0zSYQ7ayYT2bxgKZew0BUpNjo+ujHD++gpS9jTaqMz
mq5Y0/lW19eItBVJbIu6sS4XK3tXofBUyyFmWi4Rk/Zkw3N01LDWJVC4Ug9LZCfh
AhNoq91XNJLgB22XUvdoDvu1VSYriCmOjb0oVsGwQVYlTwTGonG6cOxr4qiU3hVh
6XblMGeqnCMw/0wPzLXXwxh0M7emHkoYBV/fcC9nWJ4g6anQ6sdqVRLiLCvfXKAP
M1BBTIiJtQD6tPUPZF73Gu8Ub4MjXZK1zMjPRD4naJIC1cU6Ww6gYPojl5OkNv8Q
2wcyddFPkQoyvF8/HbYD
=rnzV
-----END PGP SIGNATURE-----

--nextPart3996215.GW0L9WpkYn--

