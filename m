Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 22 Oct 2018 20:15:33 +0200
Message-ID: <3971667.ui1v05AXcD@sven-edge>
In-Reply-To: <CAPzaX0ic23YurEjexLgNq4x6aaAp38f4Nj=iMfNDbLXkHCwhXQ@mail.gmail.com>
References: <CAPzaX0ic23YurEjexLgNq4x6aaAp38f4Nj=iMfNDbLXkHCwhXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2025955.oWOvcQjO3m";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Version help
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Corey Combs <combsca90@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2025955.oWOvcQjO3m
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Montag, 22. Oktober 2018 19:51:21 CEST Corey Combs wrote:
> I'm currently working on a project that uses BATMAN for a mesh network
> across multiple Beagle Bone Blacks which are running a Debian version
> 7.9 at the moment.  They also are running batctl debian-2012.1.0-1
> [batman-adv 2012.5.0].

Uhm, 2012.5.0 is extreme old and I would advise not to use such an old 
version. And beside that, it is using COMPAT_VERSION 14 [1]. The current 
COMPAT_VERSION is 15 - batman-adv kernel modules with different 
COMPAT_VERSIONs cannot talk to each other.

> I would like to connect a laptop to the
> existing network either using Debian or Ubuntu, however I have run
> into issues with compatibility.  I configured everything identically
> with the laptop and I believe I'm connected to the network, but I
> cannot see any other devices on the network.  Is it advisable to
> upgrade the version of batctl on the 'bone or downgrade the version on
> debian or Ubuntu so that the versions align?  Or is there something
> else I am missing in my efforts?

Why batctl? The biggest problem here is the extreme old batman-adv version 
which is not compatible with every batman-adv version since 2014.

And btw. you didn't tell us what batman-adv version your laptop is using. If 
they are really using the same version then it could be that either the laptop 
or the beagle bone blacks have problems with their wifi driver. Wouldn't be
the first time that things like broadcast or unicast communication via IBSS 
is broken with some wifi hw/driver.

Kind regards,
	Sven

[1] https://www.open-mesh.org/projects/batman-adv/wiki/Compatversion


--nextPart2025955.oWOvcQjO3m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlvOE8UACgkQXYcKB8Em
e0b7Zg//VEIzcwAkDV0Ugn/2qTzvnYk/zuSGQ0bU3uv5w41jC+rIu2MiDlqofIcI
C2TtwTnMW5uI/05ZPvBvYk56MjqRh2m4nJqQHrO/VJqaasRcjLnRiVoKbR82xDXK
QOgcAKu1IevKyNj11Whnq8MLX0aEOH6uVrgpxF5IlOCxhFHzHODGuyg84zsts8f3
rEFKsmAGCmhzrF3tvH7HHqzBhzMBHXIvSJtqgrbuVMjvFLZkInMRAN/hEkbBeb0Y
ZA1kDzm9S3rotxHOygKvW/726WrXn5vFSyWBjY+cE0r50TowyBmCIgOgnESBNHQK
noFVDuzBxF+P8BL3913stoQ+rEEOCrS++DbFJQ+kk/XT4PlJcDfp7xqMibGIkymH
+WdmBGgN3Ux7wAfdNWT9DC1cJpRUHJzZ+QImz0m22UFrPNLiQQENqJcFTVtyyMit
+JqUTzLm7NirmMf4/wiPEnFACfpxwsr24jAqmJ0OxYcuCRqp4wmGVTbgp2HCi6Vb
soL21ROJDMW3SBMcTUpvLw05gviCj7NVG3wBIMTuIiOuEgu5J5XY1IezNyoBplAh
kNJCJy0Idu78uryvJdXvt6wlizCwwEhO+1k7+gd0WvcxxF2NnRQmg/HQGFpm5Fxn
r5QFzfOgEEM6DLuCNYiUHZCR0jZnP64k+fotvrvCQiMltFE7oX8=
=ot90
-----END PGP SIGNATURE-----

--nextPart2025955.oWOvcQjO3m--



