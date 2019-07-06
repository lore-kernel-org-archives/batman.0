Return-Path: <moritzwarning@web.de>
Subject: Re: Unknown symbol cfg80211_get_station
References: <cef22736-91db-6a22-6da4-35a4d53a4adc@web.de>
 <1875314.jOPAOSbl7z@sven-edge>
From: Moritz Warning <moritzwarning@web.de>
Message-ID: <7eadb3ab-1b51-e248-6122-a7c3c73383c9@web.de>
Date: Sat, 6 Jul 2019 17:22:01 +0200
MIME-Version: 1.0
In-Reply-To: <1875314.jOPAOSbl7z@sven-edge>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: quoted-printable
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org
Cc: Ubuntu Kernel Team <kernel-team@lists.ubuntu.com>

Thanks Sven for having a good look.

There is no cfg80211 module present on the system (find /lib/modules/4.15.=
0-1032-aws/ -name *80211*).
Package linux-modules-4.15.0-1032-aws is installed.

The module linux-modules-extra-4.15.0-1032 installs the following files:

/lib/modules/4.15.0-1032-gcp/kernel/net/wireless/cfg80211.ko
/lib/modules/4.15.0-1032-gke/kernel/net/wireless/cfg80211.ko
/lib/modules/4.15.0-1032-azure/kernel/net/wireless/cfg80211.ko

But this is not in the *-aws path.

On 7/6/19 2:16 PM, Sven Eckelmann wrote:
> On Friday, 5 July 2019 16:51:56 CEST Moritz Warning wrote:
>> on an AWS server I get this error:
>>
>> $ modprobe batman-adv
>> $ dmesg
>> ...
>> [ 1310.125438] batman_adv: Unknown symbol cfg80211_get_station (err 0)
>>
>> $ uname -a
>> Linux ip-172-31-47-217 4.15.0-1032-aws #34-Ubuntu SMP Thu Jan 17 15:18:=
09 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
>>
>
> I have downloaded the headers [1] and they have following defined in
> include/config/cfg80211.h:
>
>     #if IS_ENABLED(CONFIG_CFG80211)
>     /**
>      * cfg80211_get_station - retrieve information about a given station
>      * @dev: the device where the station is supposed to be connected to
>      * @mac_addr: the mac address of the station of interest
>      * @sinfo: pointer to the structure to fill with the information
>      *
>      * Returns 0 on success and sinfo is filled with the available infor=
mation
>      * otherwise returns a negative error code and the content of sinfo =
has to be
>      * considered undefined.
>      */
>     int cfg80211_get_station(struct net_device *dev, const u8 *mac_addr,
>     			 struct station_info *sinfo);
>     #else
>     static inline int cfg80211_get_station(struct net_device *dev,
>     				       const u8 *mac_addr,
>     				       struct station_info *sinfo)
>     {
>     	return -ENOENT;
>     }
>     #endif
>
> So this function should be always defined by the kernel. Either through =
this
> header or through the cfg80211 module (which can be part of the kernel b=
inary
> itself).
>
> I have then downloaded the config deb [2]. It has the .config file inclu=
ded
>
>     $ grep CONFIG_CFG80211 usr/src/linux-headers-4.15.0-1032-aws/.config
>     CONFIG_CFG80211=3Dm
>     # CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
>     # CONFIG_CFG80211_CERTIFICATION_ONUS is not set
>     CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=3Dy
>     CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=3Dy
>     CONFIG_CFG80211_DEFAULT_PS=3Dy
>     CONFIG_CFG80211_DEBUGFS=3Dy
>     CONFIG_CFG80211_CRDA_SUPPORT=3Dy
>     CONFIG_CFG80211_WEXT=3Dy
>
> So it is enabled as a module. So please load this module. And if it is n=
ot
> included in any package (what I am currently suspecting), please contact=
 the
> maintainers [3]. They either have to ship the modules or disable any mod=
ules
> in their build. But building them and not shipping is breaking the
> dependencies of other modules (as shown by you).
>
> Kind regards,
> 	Sven
>
> [1] http://mirrors.kernel.org/ubuntu/pool/main/l/linux-aws/linux-aws-hea=
ders-4.15.0-1032_4.15.0-1032.34_all.deb
> [2] http://mirrors.kernel.org/ubuntu/pool/main/l/linux-aws/linux-headers=
-4.15.0-1032-aws_4.15.0-1032.34_amd64.deb
> [3] https://bugs.launchpad.net/ubuntu/+source/linux-aws/+filebug
>

