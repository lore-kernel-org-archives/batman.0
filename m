Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH net 11/12] batman-adv: fix iflink detection in
 batadv_is_on_batman_iface
Date: Sat, 14 May 2022 12:21:16 +0200
Message-ID: <1754593.qx6Pg7X6uG@sven-desktop>
In-Reply-To: 
 <afa206858a88910691bdb917d0956cea3f32f667.1600770261.git.sd@queasysnail.net>
References: <cover.1600770261.git.sd@queasysnail.net>
 <afa206858a88910691bdb917d0956cea3f32f667.1600770261.git.sd@queasysnail.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart41320831.pHRkKXBtVs";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <a@unstable.cc>, b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org

 
--nextPart41320831.pHRkKXBtVs
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>, b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org
Subject: Re: [PATCH net 11/12] batman-adv: fix iflink detection in batadv_is_on_batman_iface
Date: Sat, 14 May 2022 12:21:16 +0200
Message-ID: <1754593.qx6Pg7X6uG@sven-desktop>
In-Reply-To: <afa206858a88910691bdb917d0956cea3f32f667.1600770261.git.sd@queasysnail.net>
References: <cover.1600770261.git.sd@queasysnail.net> <afa206858a88910691bdb917d0956cea3f32f667.1600770261.git.sd@queasysnail.net>

On Thursday, 1 October 2020 09:59:35 CEST Sabrina Dubroca wrote:
> device has the same ifindex as its link. Let's use the presence of a
> ndo_get_iflink operation, rather than the value it returns, to detect
> a device without a link.

There wasn't any activity in this patchset since a while, it doesn't apply
anymore and the assumptions made here doesn't seem to be reflect the current
situation in the kernel. See commit 6c1f41afc1db ("batman-adv: Don't expect
inter-netns unique iflink indices"):

> But only checking for dev->netdev_ops->ndo_get_iflink is also not an option
> because ipoib_get_iflink implements it even when it sometimes returns an
> iflink != ifindex and sometimes iflink == ifindex. The caller must
> therefore make sure itself to check both netns and iflink + ifindex for
> equality. Only when they are equal, a "physical" interface was detected
> which should stop the traversal. On the other hand, vxcan_get_iflink can
> also return 0 in case there was currently no valid peer. In this case, it
> is still necessary to stop.

It would would be nice when the situation would be better but the proposed 
patches don't solve it. So I will mark the two patches as "Rejected" (from 
"Changes requested") in batadv's patchwork. It is not meant as sign of
disapproval of someone working in this area to improve the situation - I just
don't want to wait for the v2 [1] anymore.

Kind regards,
	Sven

[1] https://lore.kernel.org/all/20201002090703.GD3565727@bistromath.localdomain/
--nextPart41320831.pHRkKXBtVs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmJ/gpwACgkQXYcKB8Em
e0b8bg//cTQcj0L6HvTbt3v4eZIOw1E9xQVtfh3w7zKEagsEIyz8fPapiqG4uHOd
aZukT6tVDAyxT6ce+1sm07hVcBfMEeMf+a6BrobdVJ6cvKXt31O+juUEiAl8qex1
8begZbq/5tTZmKkgiHUbvZeW8lBDwrlvvSwYLXTwqbjJoIKVfvFucOSHnYD/N7Ho
XN9wfHcZng5Q/XFGuu6Ki5cvX1j/ygzW1MH6bHzat7+RCDxt3ri7CuFAHQ6cnf33
bZPoFStCjgJLZ+5VZcTPNVHe6bZv1uwGxniSyaPi4T3HNoIWnGsPUndY7us/jBtl
LLyObHy9Tli2ARjL599L2e/fTayDKwro/DTGYSpuXTvz9FgIG4wZiwoSQK2TVx2I
sAPfkspDbB3MPG+Os0XBfDrB3plZeFZgFyLYYDf9DmCQxm1XKLUm8sZa6G7s3Wjf
xlBqB4JwLjXxltnbTsHyUgu4PewMCIrJglau/uL3/03WDMO+eGhtVa4ZsISdP3rM
rnibmZ46GS7c4Nr5gNC00ecjr/36dTn6sc//ZBbbFEm+FZVXixJ6P1Zzcg4rqdKV
xv6a3z8hLUtvh9Gxxt8jwH4XSWtufTe+RG5mu+QDEy5prxCUWoAReJRQsO1hGJG1
y/ZQMvW3aXzyCA27wyCgsbLACX0W3tD7O7ponxGV3o7XfI0wssU=
=97Bw
-----END PGP SIGNATURE-----

--nextPart41320831.pHRkKXBtVs--


