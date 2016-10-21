Return-Path: <tiger@slientuniverse.com>
Message-ID: <580A39D6.9020002@slientuniverse.com>
Date: Fri, 21 Oct 2016 23:52:54 +0800
From: tiger <tiger@slientuniverse.com>
MIME-Version: 1.0
References: <580A26A4.5030005@yahoo.com> <1744565.jjMyA2xSBQ@bentobox>
 <2284104.QWR2gm6sJD@bentobox>
In-Reply-To: <2284104.QWR2gm6sJD@bentobox>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] High latency with batman-adv on ethernet
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org


Hello linus:

This is my info

lsmod

batman_adv 164539 0
bridge 108205 1 batman_adv


[root@alarmpi tmp]# ls /sys/class/net/bat0/mesh/
aggregated_ogms bonding distributed_arp_table gw_bandwidth gw_sel_class 
isolation_mark orig_interval
ap_isolation bridge_loop_avoidance fragmentation gw_mode hop_penalty 
multicast_mode routing_algo

[root@alarmpi tmp]# ls /sys/class/net/eth0/batman_adv/
iface_status mesh_iface


[root@alarmpi tmp]# batctl nc disable
Error - can't open file '/sys/class/net/bat0/mesh/network_coding': No 
such file or directory
The option you called seems not to be compiled into your batman-adv 
kernel module.
Consult the README if you wish to learn more about compiling options 
into batman-adv.







于 2016年10月21日 23:31, Linus Lüssing 写道:
> On Fri, Oct 21, 2016 at 04:31:20PM +0200, johnzeng via B.A.T.M.A.N wrote:
>> Date: Fri, 21 Oct 2016 22:31:00 +0800
>> From: johnzeng <johnzeng2013@yahoo.com>
>> To: b.a.t.m.a.n@lists.open-mesh.org
>> Subject: i found time delay is very high and there are more caution info  ,
>>   if possible , please give me some advisement
> If I remember correctly, then one typical issue for Arch Linux
> users was, that Arch compiles batman-adv with network-coding, even
> though it is marked as "Experimental". And that introduces high latency
> and/or packetloss.
>
> johnzeug, can you check whether network coding is enabled or
> disabled and if it is enabled, whether disabling helps?
>
> (batctl nc disable)
>
> And like Sven asked, what batman-adv version are you using. Not
> that long ago the network coding default was changed to disabled
> by default even if the module is compiled with NC. Maybe you run
> an older batman-adv release?
>
> Regards, Linus

> On Freitag, 21. Oktober 2016 16:43:41 CEST Sven Eckelmann wrote:
> [...]
>>> because i tested between ethernet network port ( i don't test in wifi
>>> port ) , whether it will master reason ?
>> Should not be the "reason". batman-adv doesn't care much about it. It just
>> requires an ethernet compatible device. The re-broadcast is a little bit
>> less aggressive on non-wifi devices but this has nothing to do with your
>> problem.
> Just created a small test setup via ethernet with batman-adv 2016.3 to show
> you how the results are here. They were connected via a single cable:
>
> without batman-adv
> ------------------
>
>      $ ping -c 10 192.168.2.196
>      PING 192.168.2.196 (192.168.2.196) 56(84) bytes of data.
>      64 bytes from 192.168.2.196: icmp_seq=1 ttl=64 time=0.478 ms
>      64 bytes from 192.168.2.196: icmp_seq=2 ttl=64 time=0.682 ms
>      64 bytes from 192.168.2.196: icmp_seq=3 ttl=64 time=0.392 ms
>      64 bytes from 192.168.2.196: icmp_seq=4 ttl=64 time=0.642 ms
>      64 bytes from 192.168.2.196: icmp_seq=5 ttl=64 time=0.574 ms
>      64 bytes from 192.168.2.196: icmp_seq=6 ttl=64 time=0.466 ms
>      64 bytes from 192.168.2.196: icmp_seq=7 ttl=64 time=0.602 ms
>      64 bytes from 192.168.2.196: icmp_seq=8 ttl=64 time=0.619 ms
>      64 bytes from 192.168.2.196: icmp_seq=9 ttl=64 time=0.658 ms
>      64 bytes from 192.168.2.196: icmp_seq=10 ttl=64 time=0.440 ms
>      
>      --- 192.168.2.196 ping statistics ---
>      10 packets transmitted, 10 received, 0% packet loss, time 9000ms
>      rtt min/avg/max/mdev = 0.392/0.555/0.682/0.098 ms
>
> with batman-adv
> ---------------
>
>      $ ping -c 10 10.10.130.66
>      PING 10.10.130.66 (10.10.130.66) 56(84) bytes of data.
>      64 bytes from 10.10.130.66: icmp_seq=1 ttl=64 time=0.489 ms
>      64 bytes from 10.10.130.66: icmp_seq=2 ttl=64 time=0.675 ms
>      64 bytes from 10.10.130.66: icmp_seq=3 ttl=64 time=0.552 ms
>      64 bytes from 10.10.130.66: icmp_seq=4 ttl=64 time=0.562 ms
>      64 bytes from 10.10.130.66: icmp_seq=5 ttl=64 time=0.612 ms
>      64 bytes from 10.10.130.66: icmp_seq=6 ttl=64 time=0.573 ms
>      64 bytes from 10.10.130.66: icmp_seq=7 ttl=64 time=0.534 ms
>      64 bytes from 10.10.130.66: icmp_seq=8 ttl=64 time=0.622 ms
>      64 bytes from 10.10.130.66: icmp_seq=9 ttl=64 time=0.454 ms
>      64 bytes from 10.10.130.66: icmp_seq=10 ttl=64 time=0.468 ms
>      
>      --- 10.10.130.66 ping statistics ---
>      10 packets transmitted, 10 received, 0% packet loss, time 8996ms
>      rtt min/avg/max/mdev = 0.454/0.554/0.675/0.067 ms
>
> Kind regards,
> 	Sven
>
> PS: I've changed the subject because it was extremely unspecific and
> too long.


-- 

  --
  -----------------------------------------
  SlientUniverse Network

  Tiger

  Mobile: 15323845569

  Tel:+0086 0755 28378179
  ----------------------------------------
  Website:http://www.slientuniverse.com

