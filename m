Return-Path: <philipp.psurek@gmail.com>
Message-ID: <1416825873.2678.2.camel@gmail.com>
From: Philipp Psurek <philipp.psurek@gmail.com>
Date: Mon, 24 Nov 2014 11:44:33 +0100
In-Reply-To: <5472EB56.8000700@hundeboll.net>
References: <1416347918.9920.10.camel@gmail.com>
 <546DA710.2040802@hundeboll.net> <1416476912.2747.5.camel@gmail.com>
 <546DC214.6050908@hundeboll.net> <1416486149.2747.9.camel@gmail.com>
 <546DE067.8070807@hundeboll.net> <1416688754.2696.3.camel@gmail.com>
 <5472EB56.8000700@hundeboll.net>
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature"; 
 boundary="=-k3uWenNiOw0L/iF0EzF9"
Mime-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] kernel BUG at net/core/skbuff.c:100
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--=-k3uWenNiOw0L/iF0EzF9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Martin

Am Montag, den 24.11.2014, 09:24 +0100 schrieb Martin Hundeb=C3=B8ll:
> Can you help me do a quick sum-up?

At the beginning of the month some bug occurred on our two gateways with
Arch Linux. MM and NC enabled. First bat-adv 2014.2.0 later bat-adv
provided with the kernel. Kernel 3.14.23-ARCH later 3.17.1-ARCH. The bug
can not be analysed on those VMs because I don't have access to their
consoles.

I took a Gentoo Linux VM (bat-adv provided inside 3.16.6) with access to
the console to ensure this bug is not Arch related. The bug occurs after
three days. After kernel panic it can't be scrolled inside the console,
so a complete trace-back is impossible. The end of the trace-back was
the same I reported. I recompiled the Kernel (3.16.7) with debug symbols
on and changed to it after one more crash.

> 1) At first it crashed with regular intervals (0 - 72 hours) with the=20
> backtrace you posted initially.

No, with irregular intervals (0 - 72 hours). I think it has nothing to
do with the time. With the Arch VMs I tried out this: one machine gw
server the other gw client. After first VM's crash I immediately
switched the other to gw server. After no time also this machine
crashed. I think it has to be a bogus user packet.

I don't know which user sends bogus packages and I also can not ask our
users what they are doing to crash our gateways.

I also don't know if the crash on Arch VM is the same on the Gentoo VM,
with the back-trace I reported, but I assume.

> 2) Then you disabled NC. Did it stop crashing at that point?

NC has been disabled for 20 h before I patched the kernel, so it can't
be told for sure that disabling stops the crashes.=20

> 3) Then we enabled NC and added my patch, and it still does not crash?

After patching NC was enabled again to reproduce the bug. The VM crashed
after 27 h. I could not retrieve the trace-back because I set the
'crashkernel' option to low. The next crash happened after 32:38:59.
There has not been any batadv_frag_merge_packets in kernel ring buffer.

> I remeber you said it crashed with the distro-provided batman-adv=20
> module. Did you ensure to use the same version when running with my patch=
?

Yes. I patched /usr/src/linux/net/batman-adv/fragmentation.c
I use batman-adv provided with the Kernel to reproduce all the steps.
make modules recompiled only the batman-adv module, which I reloaded.

> I haven't had time to dig into the reproduction of the crash, but I=20
> think I will do regardless.

Please tell me, if you need some more information.

The VM's uptime is now 39 h. It survives Saturday evening and Sunday
without a crash. I think the bug is NC related, but lets wait some more
days until next Monday to tell for sure. In this time the users might do
what they did in the past and trigger the bug.

Thank you for your time and making B.A.T.M.A.N.-adv better.

Best regards

Philipp

________________________
Freifunk Rheinland e. V.
=E2=80=93 Funkzelle Wuppertal =E2=80=93

--=-k3uWenNiOw0L/iF0EzF9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABAgAGBQJUcwwZAAoJENpWdD1eHU4Jj9EP/3BnsNBgthH5Qp+nr3b9BVrK
T8/IZ9IQi3EHv/XY8RohaaE+44rAe6+EfOYsGjoiKaGq8l6HxYxZVwXMWwXW2Hvk
IiC89FWWhPtXMxlBdLpMiGR/1CCD20Yr7q+keHcKAszHP9WBGE8l8UIsRGDiLBQV
elyIpudhmlfrxIfikKph6foDyqkVWQ1PBUDeZvgH/Yr3hQPhZefLnqvxcizK692C
yW5YPAwRp4WEinFX9baVbyiGQtmIYbSghx2HJsvwFKLANh+i37gZexVt7doBDRpb
lJeOMb19kMaP0c6EqgyzV/iSdhhLq9DlY8QISOE1cFLNYimAJdF2hazAmsjcv+Re
pmhZzF+7o5zOwFaJsf0MgfiK7xbKEp6nu4t7zYU9g7k/m5YzQ6jbAQLMy+tfZhi4
cGf040GGHV/tgwjqhwaQJeFi8BkyV7HZmF+pH3BhzGQ7peKayODRl5/ngxjwVY4z
DWDjn0PzS3+MNEVwuSSwFlLEyOx4qVmiKAkG3RBakvSOwalybIJVeePJ+Spz/xdJ
+ZYd4Eq3x1azcSS9KCy4zobvzS1iCCQmsw5/Sd/TZbjrrPq0AidGkth+FQeqnkkz
KC+XtZggy7ORZFu/0NBLBElMDGCHpHwcnUjqf/hbC/advt0pUuvaHOIUDChvKFZ+
0VTlBgwchEhg2jpJadA0
=evWg
-----END PGP SIGNATURE-----

--=-k3uWenNiOw0L/iF0EzF9--

