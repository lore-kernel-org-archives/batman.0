Return-Path: <zukky@bb.banban.jp>
Message-ID: <4C7CA94A.7020103@bb.banban.jp>
Date: Tue, 31 Aug 2010 16:03:38 +0900
From: Kazuki Shimada <zukky@bb.banban.jp>
MIME-Version: 1.0
References: <4C6437BF.9080909@web.de>
	<201008261028.35755.sven.eckelmann@gmx.de>
	<4C7720F1.5030604@bb.banban.jp>
	<201008271159.28345.sven.eckelmann@gmx.de>
In-Reply-To: <201008271159.28345.sven.eckelmann@gmx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] problem openwrt-trunk + ath5k + batman-adv-devel
 in my case
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

  Hi, Sven.

Thank you for your patch and sorry to be late to reply.

I updated the revision to r1780.
The problem is gone.

After network restart, wlan interfaces under bat0 are still deactivated. 
But it's not big problem. "/etc/init.d/batman-adv restart" makes them 
activated.

Thanks a lot,

Kazuki Shimada

P.S.
When activating network interfaces under bat0, What about forcing their 
mtu value to 1527?


root@OpenWrt:/# /etc/init.d/network restart
ifconfig: SIOCSIFADDR: No such device
root@OpenWrt:/# iwconfig
lo        no wireless extensions.

eth0      no wireless extensions.

eth1      no wireless extensions.

br-lan    no wireless extensions.

wlan0     IEEE 802.11abg  ESSID:"mesh1"
           Mode:Ad-Hoc  Frequency:2.412 GHz  Cell: 5E:8D:F2:44:E6:C4
           Tx-Power=20 dBm
           RTS thr:off   Fragment thr:off
           Encryption key:off
           Power Management:off

wlan1     IEEE 802.11abg  ESSID:"mesh2"
           Mode:Ad-Hoc  Frequency:2.437 GHz  Cell: 7A:69:F0:4A:67:1D
           Tx-Power=27 dBm
           RTS thr:off   Fragment thr:off
           Encryption key:off
           Power Management:off

root@OpenWrt:/# ifconfig
br-lan    Link encap:Ethernet  HWaddr 00:D0:12:03:44:91
           inet addr:192.168.2.1  Bcast:192.168.2.255  Mask:255.255.255.0
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:32 errors:0 dropped:0 overruns:0 frame:0
           TX packets:16 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:0
           RX bytes:1472 (1.4 KiB)  TX bytes:1649 (1.6 KiB)

eth0      Link encap:Ethernet  HWaddr 00:D0:12:03:44:91
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:117099 errors:0 dropped:0 overruns:0 frame:0
           TX packets:211663 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:100
           RX bytes:21594274 (20.5 MiB)  TX bytes:308962021 (294.6 MiB)

eth1      Link encap:Ethernet  HWaddr 00:D0:12:13:44:91
           UP BROADCAST MULTICAST  MTU:1500  Metric:1
           RX packets:4 errors:0 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:100
           RX bytes:200 (200.0 B)  TX bytes:0 (0.0 B)

lo        Link encap:Local Loopback
           inet addr:127.0.0.1  Mask:255.0.0.0
           UP LOOPBACK RUNNING  MTU:16436  Metric:1
           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:0
           RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

wlan0     Link encap:Ethernet  HWaddr 00:0B:6B:2D:F4:91
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:9 errors:0 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:504 (504.0 B)  TX bytes:0 (0.0 B)

wlan1     Link encap:Ethernet  HWaddr 00:0B:6B:2C:15:E3
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:15 errors:0 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:696 (696.0 B)  TX bytes:0 (0.0 B)

root@OpenWrt:/# ifconfig wlan0 mtu 1527
root@OpenWrt:/# ifconfig wlan1 mtu 1527
root@OpenWrt:/# batctl if
root@OpenWrt:/# batctl o
Error - the folder '/sys/kernel/debug//batman_adv/bat0/' was not found 
within the sys filesystem
Please make sure that the batman-adv kernel module is loaded
root@OpenWrt:/# lsmod |grep batman
batman_adv             64982  0
root@OpenWrt:/# /etc/init.d/batman-adv restart
root@OpenWrt:/# batctl if
wlan0: active
wlan1: active
root@OpenWrt:/#


(2010/08/27 18:59), Sven Eckelmann wrote:
> Kazuki Shimada wrote:
> [...]
>> "exit softif_destroy\n" is not printed out.
>> unregister_netdev?
> Thanks, perfect work. This is a new bug which was added in the multiple mesh
> patchset. The problem is that the rtnl lock is taken and we still use
> unregister_netdev when we process an event using hard_if_event.
>
> I have to check other code paths to ensure that I don't destroy other things,
> but a workaround for you would be to use unregister_netdevice instead of
> unregister_netdev in that situation. (Just check v0.2.1-30-g992bfd1 for more
> information on that subject).
>
> The problem is that softif_destroy is also called when we unloading the module
> - which means that it assumes that the rtnl lock is taken (which it is not
> when you don't use unregister_netdev there). So I will work on a complete fix
> and Cc it to you.
>
> Thanks,
> 	Sven

