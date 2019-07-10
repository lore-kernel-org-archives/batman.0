Return-Path: <stefan.bader@canonical.com>
Subject: Re: Unknown symbol cfg80211_get_station
References: <cef22736-91db-6a22-6da4-35a4d53a4adc@web.de>
 <1875314.jOPAOSbl7z@sven-edge> <7eadb3ab-1b51-e248-6122-a7c3c73383c9@web.de>
From: Stefan Bader <stefan.bader@canonical.com>
Message-ID: <c60bd64a-127d-229c-3bed-eb59803a54f4@canonical.com>
Date: Wed, 10 Jul 2019 10:23:21 +0200
MIME-Version: 1.0
In-Reply-To: <7eadb3ab-1b51-e248-6122-a7c3c73383c9@web.de>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="KhJPMH8QhPYjvBDpq4jnwFeU2RKud5t3D"
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Moritz Warning <moritzwarning@web.de>, Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org
Cc: Ubuntu Kernel Team <kernel-team@lists.ubuntu.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KhJPMH8QhPYjvBDpq4jnwFeU2RKud5t3D
Content-Type: multipart/mixed; boundary="5RwczmPjshYdofCVoKLJOx12lQELR4jK9";
 protected-headers="v1"
From: Stefan Bader <stefan.bader@canonical.com>
To: Moritz Warning <moritzwarning@web.de>, Sven Eckelmann
 <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org
Cc: Ubuntu Kernel Team <kernel-team@lists.ubuntu.com>
Message-ID: <c60bd64a-127d-229c-3bed-eb59803a54f4@canonical.com>
Subject: Re: Unknown symbol cfg80211_get_station
References: <cef22736-91db-6a22-6da4-35a4d53a4adc@web.de>
 <1875314.jOPAOSbl7z@sven-edge> <7eadb3ab-1b51-e248-6122-a7c3c73383c9@web.de>
In-Reply-To: <7eadb3ab-1b51-e248-6122-a7c3c73383c9@web.de>

--5RwczmPjshYdofCVoKLJOx12lQELR4jK9
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06.07.19 17:22, Moritz Warning wrote:
> Thanks Sven for having a good look.
>=20
> There is no cfg80211 module present on the system (find /lib/modules/4.=
15.0-1032-aws/ -name *80211*).
> Package linux-modules-4.15.0-1032-aws is installed.

The aws kernel is intended to be used on instances in the Amazon cloud. T=
here is
no wifi hardware present on those instances, so it generally makes no sen=
se to
have those modules.
As Jens pointed out the missing modules are in linux-modules-extra not in=

linux-modules (the former is not installed by default).

-Stefan
>=20
> The module linux-modules-extra-4.15.0-1032 installs the following files=
:
>=20
> /lib/modules/4.15.0-1032-gcp/kernel/net/wireless/cfg80211.ko
> /lib/modules/4.15.0-1032-gke/kernel/net/wireless/cfg80211.ko
> /lib/modules/4.15.0-1032-azure/kernel/net/wireless/cfg80211.ko
>=20
> But this is not in the *-aws path.
>=20
> On 7/6/19 2:16 PM, Sven Eckelmann wrote:
>> On Friday, 5 July 2019 16:51:56 CEST Moritz Warning wrote:
>>> on an AWS server I get this error:
>>>
>>> $ modprobe batman-adv
>>> $ dmesg
>>> ...
>>> [ 1310.125438] batman_adv: Unknown symbol cfg80211_get_station (err 0=
)
>>>
>>> $ uname -a
>>> Linux ip-172-31-47-217 4.15.0-1032-aws #34-Ubuntu SMP Thu Jan 17 15:1=
8:09 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
>>>
>>
>> I have downloaded the headers [1] and they have following defined in
>> include/config/cfg80211.h:
>>
>>     #if IS_ENABLED(CONFIG_CFG80211)
>>     /**
>>      * cfg80211_get_station - retrieve information about a given stati=
on
>>      * @dev: the device where the station is supposed to be connected =
to
>>      * @mac_addr: the mac address of the station of interest
>>      * @sinfo: pointer to the structure to fill with the information
>>      *
>>      * Returns 0 on success and sinfo is filled with the available inf=
ormation
>>      * otherwise returns a negative error code and the content of sinf=
o has to be
>>      * considered undefined.
>>      */
>>     int cfg80211_get_station(struct net_device *dev, const u8 *mac_add=
r,
>>     			 struct station_info *sinfo);
>>     #else
>>     static inline int cfg80211_get_station(struct net_device *dev,
>>     				       const u8 *mac_addr,
>>     				       struct station_info *sinfo)
>>     {
>>     	return -ENOENT;
>>     }
>>     #endif
>>
>> So this function should be always defined by the kernel. Either throug=
h this
>> header or through the cfg80211 module (which can be part of the kernel=
 binary
>> itself).
>>
>> I have then downloaded the config deb [2]. It has the .config file inc=
luded
>>
>>     $ grep CONFIG_CFG80211 usr/src/linux-headers-4.15.0-1032-aws/.conf=
ig
>>     CONFIG_CFG80211=3Dm
>>     # CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
>>     # CONFIG_CFG80211_CERTIFICATION_ONUS is not set
>>     CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=3Dy
>>     CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=3Dy
>>     CONFIG_CFG80211_DEFAULT_PS=3Dy
>>     CONFIG_CFG80211_DEBUGFS=3Dy
>>     CONFIG_CFG80211_CRDA_SUPPORT=3Dy
>>     CONFIG_CFG80211_WEXT=3Dy
>>
>> So it is enabled as a module. So please load this module. And if it is=
 not
>> included in any package (what I am currently suspecting), please conta=
ct the
>> maintainers [3]. They either have to ship the modules or disable any m=
odules
>> in their build. But building them and not shipping is breaking the
>> dependencies of other modules (as shown by you).
>>
>> Kind regards,
>> 	Sven
>>
>> [1] http://mirrors.kernel.org/ubuntu/pool/main/l/linux-aws/linux-aws-h=
eaders-4.15.0-1032_4.15.0-1032.34_all.deb
>> [2] http://mirrors.kernel.org/ubuntu/pool/main/l/linux-aws/linux-heade=
rs-4.15.0-1032-aws_4.15.0-1032.34_amd64.deb
>> [3] https://bugs.launchpad.net/ubuntu/+source/linux-aws/+filebug
>>
>=20
>=20



--5RwczmPjshYdofCVoKLJOx12lQELR4jK9--

--KhJPMH8QhPYjvBDpq4jnwFeU2RKud5t3D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE2118yvOZTjOV2k0+6Gdd7svuzqMFAl0loHkACgkQ6Gdd7svu
zqM3lg/9G5k+BFUp9MvP5HiKtht4iVvrgPwkGIHfLFjUb3BfO8OkMPXWmyM6vYvH
PEauKal8D/kFHBdwi8ZOVdhJ/EIO5Dz2EtScGN3aPl2Iaf39WdSCNu26RiCV6FfF
bcp/datx+r2MjtkEqbrWGOmg0v/a/aNn2+99od/xc/SJAgalSbcvDHn7SjDJTQ3m
6cGRtwme4cAIkZert7Lw9jKICMylrsFYtSbajPTNPCeldoc4Tmm7gYCcGyhKS3tn
WUQbDLmjTD2S3Grvqw2YwIRdZ0FMHUDna/SB2MbIz/dK3XvxhTHQvzhDbXdQF64z
XfX9RAUn1pSBsWEfvb6ccsO6LrstbLmedp76RzLe/i1yoU4VsjoF9g30SNXqQBfz
KgnYcLF0tTxbQF94fYQzf9afwMvaj42KGsFITwYQPdn1aJWMFiy1eRuYKgRfFtkh
P60EUg1TccGpy6DRe3V46fvqOajrUg5cKupdVysBpuQijbvb34vEQj4GEhkDDgX2
+mzRPbeB5ygpwy0LYkPd4SbJwG1MBdIjP+GQHzsGIZsubsJ9otl6VSJR3GK8q9MT
tqfh74UyGfz8BYNGSxQE3C25V2BqOA2OLJUpnW0N4f6Qlw+TK05IT5xpf7fhtcfj
Q2VSehJ+UfUJRia41UYHfBH3Wpq0HJ778Hmf8b2uBouSOTBa/K8=
=qecm
-----END PGP SIGNATURE-----

--KhJPMH8QhPYjvBDpq4jnwFeU2RKud5t3D--
