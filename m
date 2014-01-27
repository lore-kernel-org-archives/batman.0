Return-Path: <cmsv@wirelesspt.net>
Message-ID: <52E69D7D.80905@wirelesspt.net>
Date: Mon, 27 Jan 2014 12:55:09 -0500
From: cmsv <cmsv@wirelesspt.net>
MIME-Version: 1.0
References: <1390299725-1873-1-git-send-email-antonio@meshcoding.com>	<86mwipch0u.fsf@coulee.tdb.com>
 <86lhy8pn5v.fsf@coulee.tdb.com>	<52DF7556.9090200@makrotopia.org>
 <86y527oqpl.fsf_-_@coulee.tdb.com>	<52E003DD.6040302@meshcoding.com>
 <52E02EDC.3080805@wirelesspt.net> <86iotbo9hw.fsf@coulee.tdb.com>
 <52E05E0F.7010203@wirelesspt.net> <52E08DFE.9030604@makrotopia.org>
 <52E5063E.3080408@makrotopia.org> <52E51A04.8020800@meshcoding.com>
 <52E5322D.60202@wirelesspt.net> <52E532D0.2000907@meshcoding.com>
 <52E5341F.30800@meshcoding.com>
In-Reply-To: <52E5341F.30800@meshcoding.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="WWmdhRQDR6FKnjDg9mJEvwiqGOJBxM8LH"
Subject: Re: [B.A.T.M.A.N.] batman-adv: memory leak?
Reply-To: cmsv@wirelesspt.net,
 The list for a Better Approach To Mobile Ad-hoc Networking
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
To: b.a.t.m.a.n@lists.open-mesh.org, daniel@makrotopia.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WWmdhRQDR6FKnjDg9mJEvwiqGOJBxM8LH
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Here is an update of some tests i ran in the past 24h with the following
build:

routers used:
dlink dir 601a and tplink wr703n in "ng" mode. (atheros)

My current AA DISTRIB_REVISION=3D"r39154"
mac80211 r39150 from openwrt trunk
hostapd r39155 from trunk

From batman-adv i am using the following patches:
ls  feeds/routing/batman-adv/patches/
0001-batman-adv-fix-batman-adv-header-overhead-calculatio.patch

From d72756b97529b3c6afa08933216aaa912bb16ce6 Mon Sep 17 00:00:00 2001
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 15 Jan 2014 20:31:18 +0800
Subject: [PATCH] batman-adv: fix batman-adv header overhead calculation


batman-adv/Makefile
# $Id: Makefile 5624 2006-11-23 00:29:07Z nbd $

include $(TOPDIR)/rules.mk

PKG_NAME:=3Dbatman-adv

PKG_VERSION:=3D2014.0.0
BATCTL_VERSION:=3D2014.0.0
PKG_RELEASE:=3D1
PKG_MD5SUM:=3D8d58ecaede17dc05aab1b549dc09fa7d
BATCTL_MD5SUM:=3Db0bcf29fef80ddcc33769e13f5937d0a


I tried to find any memory leaks that could be causing reboots and i was
unable to find any after having compiled the build with
batman-adv-header-overhead-calculatio.patch. Before this patch i did get
reboots caused by the leak.


I keep monitoring memory usage with top, htop, ps and /proc/meminfo
since i was not able to install valgrind due to lack of available flash
memory given the size of the valgrind package.

Got some tips from here:
http://blog.thewebsitepeople.org/2011/03/linux-memory-leak-detection

Additionally i ran iperf tests on both routers against each other to forc=
e
them under heavy load during 24h: iperf -c <ip> -t 99999 -i 5

The mtu is 1560 for the adhoc.

After 24h i still had 6 mb of ram and above on both routers. Once i
stopped the tests; the ram increased.

Dmesh and logread output nothing wrong and or errors.

No reboots happened during this time which leads me to conclude that the
problem might not be all from batman-adv side or maybe not even at all
or maybe only happens when in use with something very specific.

I would like to run a few more tests to be more sure about possible
leaks but are there any other tools that someone might recommend ?

@ daniel
What did you use to find the leak and or how did you troubleshoot it ?



On 01/26/2014 11:13 AM, Antonio Quartulli wrote:
> On 26/01/14 17:07, Antonio Quartulli wrote:Can you explain in what
>>
>> This is a patch to fix the memleak we were discussing about.
>> This bug appeared with and it is meant to be applied on
>> batman-adv-2014.0.0 (regardless of the openwrt revision).
>=20
> sorry, bad copy/paste.
>=20
> The patch is for batman-adv-2014.0.0 (I don't know what version you hav=
e
> in AA).
> It fixes the memleak bug that we were discussing about.
>=20
>=20


--WWmdhRQDR6FKnjDg9mJEvwiqGOJBxM8LH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJS5p2HAAoJENmyd4cVxLOCezMP/3tTfmFJuHdcneFRl7USZ3yI
O5l3vThlSXgyjyZcq2q6NdOZiMflR5bA0qZ2G63scKENXG8f+1nU4+dqVLY9DFF7
sLd9/yBqVii3EzZu1T7F4SstVMuB0Gjt6/Ak+6cQTeqz1Q4GtR4zpqvH7Gpi7qie
b8fV+m6nJYrA64FEByZJhSOvR+j6dtrunLoDF5F8DP2y5jmRpooCiWGTdqtQ53+t
UkJuF17Db0DW1rH9lOlZ8yjWrjPmBaskjv9Aa+MVRYc/o6WBsmDy+WzblWR3z7bp
eOO+nkTZETWKrWtG8UsCpNrU/kg00M584YpdECdbAOmE0nAlf5L3zbZG6j3KkJ9W
+0hB2lSPUFuntY2lQ8O72tPlaR7B88GP0qZ1r/XzmcGDIUIO9991Fh3/gWxqdRdf
hMMqtTXRaXLWyr0t9Ab+u3eeBEZYmG4KC7Qg0bjLOftIDIdeqUehodZWDmCk3wBj
uHFzGQ21CKoJKrQOpWoVopqh4M3memO2piWnzITGNEWdleqgrTFh+sCEo7qInELP
3d6fWEKV8qptLBxQ4wwPLK2/trV4wg9MqGwl+xLeYj4EaIN4Mhne97vWMYzlK8lY
+cDomqIrSB+kGoNWeF7zNa3SpGPFTKY54Q287jLkpE6iO17I5wEaD3Jnk7C7+fkl
UnuHe4JAw3nqiK4yrJO0
=J4t/
-----END PGP SIGNATURE-----

--WWmdhRQDR6FKnjDg9mJEvwiqGOJBxM8LH--
