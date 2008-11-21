Message-ID: <56595.149.5.32.200.1227286517.squirrel@www.rivertowermail.com>
In-Reply-To: <60150.149.5.32.200.1227274456.squirrel@www.rivertowermail.com>
References: <50914.149.5.32.200.1227263810.squirrel@www.rivertowermail.com>
	<52708.149.5.32.200.1227271288.squirrel@www.rivertowermail.com>
	<60150.149.5.32.200.1227274456.squirrel@www.rivertowermail.com>
Date: Fri, 21 Nov 2008 16:55:17 -0000 (UTC)
Subject: Re: [B.A.T.M.A.N.] gateway 'expiring' instantly
From: "Derek C" <derekbatman@hssl.ie>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Just in case the problem was that I was using an unstable version of
batmand I've downloaded and tried B.A.T.M.A.N. 0.3 rv1057 - I'm getting
exactly the same funny problem with instantly expiring IPs on the 2nd node

Its as if the gateway node is giving an IP to the 2nd node with a really
short lease

Derek


On Fri, November 21, 2008 1:34 pm, Derek C wrote:
> I take it back - I'm seeing the "gateway... IP XXX.XXX.XXX.XXX is
> expired" messages coming up even when I've synced the clocks with ntpdate.
>
>
> The messages just repeat over and over ("Got IP"... "IP is expired") and
> the link bounces up & down quickly.
>
> More debug messages: -
>
>
> root@OpenWrt:~# batmand -d 3 -r 3 -s 192.168.5.15 ath0
> WARNING: You are using the unstable batman branch. If you are interested
> in *using* batman get the latest stable release ! Deleting throw route to
> 2.255.0.1/32 via 0.0.0.0 (table 66 - unknown)
> Deleting throw route to 2.255.0.1/32 via 0.0.0.0 (table 66 - unknown)
> Deleting route to 192.168.100.0/24 via 0.0.0.0 (table 68 - unknown)
> Deleting route to 192.168.100.0/24 via 0.0.0.0 (table 68 - unknown)
> Deleting route to 2.0.0.0/8 via 0.0.0.0 (table 68 - unknown)
> Deleting route to 2.0.0.0/8 via 0.0.0.0 (table 68 - unknown)
> Deleting route to 127.0.0.0/8 via 0.0.0.0 (table 68 - unknown)
> Deleting route to 127.0.0.0/8 via 0.0.0.0 (table 68 - unknown)
> Deleting route to 127.0.0.0/0 via 0.0.0.0 (table 67 - unknown)
> Deleting route to 127.0.0.0/0 via 0.0.0.0 (table 67 - unknown)
> Error - can't delete route to 127.0.0.0/0 via 0.0.0.0 (table 67): Invalid
> argument Interface activated: ath0
> Using interface ath0 with address 2.255.0.2 and broadcast address
> 2.255.255.255
> B.A.T.M.A.N. 0.3.1-beta rv1145 (compatibility version 5)
> Error - can't add unreachable route to 0.0.0.0/0 via 0.0.0.0 (table 67):
> File exists
> Adding throw route to 127.0.0.0/8 via 0.0.0.0 (table 68 - lo)
> Adding throw route to 2.0.0.0/8 via 0.0.0.0 (table 68 - ath0)
> Adding throw route to 192.168.100.0/24 via 0.0.0.0 (table 68 - ath1)
> debug level: 3 routing class: 3 visualisation server: 192.168.5.15 Adding
> route to 2.255.0.1 via 0.0.0.0 (table 66 - ath0) Found new gateway
> 2.255.0.1 -> class: 65 - 16MBit/4MBit
> Error - can't send udp packet: Network is unreachable
> Error - can't send udp packet: Network is unreachable
> Error - can't send udp packet: Network is unreachable
> Error - can't send udp packet: Network is unreachable
> Error - can't send udp packet: Network is unreachable
> Error - can't send udp packet: Network is unreachable
> Adding default route to 2.255.0.1 (gw_flags: 65, tq: 254, gw_product: 0)
> Gateway client - got IP (169.254.0.1) from gateway: 2.255.0.1
> Adding default route via gate0 (table 68)
> Gateway client - gateway (2.255.0.1) says: IP (169.254.0.1) is expired
> Deleting default route via gate0 (table 68)
> Adding default route to 2.255.0.1 (gw_flags: 65, tq: 255, gw_product: 0)
> Gateway client - got IP (169.254.0.1) from gateway: 2.255.0.1
> Adding default route via gate0 (table 68)
> Gateway client - gateway (2.255.0.1) says: IP (169.254.0.1) is expired
> Deleting default route via gate0 (table 68)
> Adding default route to 2.255.0.1 (gw_flags: 65, tq: 254, gw_product: 0)
> Gateway client - got IP (169.254.0.1) from gateway: 2.255.0.1
> Adding default route via gate0 (table 68)
> Gateway client - gateway (2.255.0.1) says: IP (169.254.0.1) is expired
> Deleting default route via gate0 (table 68)
> Adding default route to 2.255.0.1 (gw_flags: 65, tq: 254, gw_product: 0)
> Gateway client - got IP (169.254.0.1) from gateway: 2.255.0.1
> Adding default route via gate0 (table 68)
> Gateway client - gateway (2.255.0.1) says: IP (169.254.0.1) is expired
> Deleting default route via gate0 (table 68)
> Adding default route to 2.255.0.1 (gw_flags: 65, tq: 254, gw_product: 0)
> Gateway client - got IP (169.254.0.1) from gateway: 2.255.0.1
> Adding default route via gate0 (table 68)
> Gateway client - gateway (2.255.0.1) says: IP (169.254.0.1) is expired
> Deleting default route via gate0 (table 68)
> Adding default route to 2.255.0.1 (gw_flags: 65, tq: 255, gw_product: 0)
> Gateway client - got IP (169.254.0.1) from gateway: 2.255.0.1
> Adding default route via gate0 (table 68)
> Gateway client - gateway (2.255.0.1) says: IP (169.254.0.1) is expired
> Deleting default route via gate0 (table 68)
> Adding default route to 2.255.0.1 (gw_flags: 65, tq: 255, gw_product: 0)
> Gateway client - got IP (169.254.0.1) from gateway: 2.255.0.1
> Adding default route via gate0 (table 68)
> Gateway client - gateway (2.255.0.1) says: IP (169.254.0.1) is expired
> Deleting default route via gate0 (table 68)
> Adding default route to 2.255.0.1 (gw_flags: 65, tq: 255, gw_product: 0)
> Gateway client - got IP (169.254.0.1) from gateway: 2.255.0.1
> Adding default route via gate0 (table 68)
> Gateway client - gateway (2.255.0.1) says: IP (169.254.0.1) is expired
> Deleting default route via gate0 (table 68)
> Adding default route to 2.255.0.1 (gw_flags: 65, tq: 255, gw_product: 0)
> Gateway client - got IP (169.254.0.1) from gateway: 2.255.0.1
> Adding default route via gate0 (table 68)
> Gateway client - gateway (2.255.0.1) says: IP (169.254.0.1) is expired
> Deleting default route via gate0 (table 68)
> Adding default route to 2.255.0.1 (gw_flags: 65, tq: 254, gw_product: 0)
> Gateway client - got IP (169.254.0.1) from gateway: 2.255.0.1
> Adding default route via gate0 (table 68)
> Gateway client - gateway (2.255.0.1) says: IP (169.254.0.1) is expired
> Deleting default route via gate0 (table 68)
> Adding default route to 2.255.0.1 (gw_flags: 65, tq: 254, gw_product: 0)
> Gateway client - got IP (169.254.0.1) from gateway: 2.255.0.1
> Adding default route via gate0 (table 68)
> Gateway client - gateway (2.255.0.1) says: IP (169.254.0.1) is expired
> Deleting default route via gate0 (table 68)
> Adding default route to 2.255.0.1 (gw_flags: 65, tq: 253, gw_product: 0)
> Gateway client - got IP (169.254.0.1) from gateway: 2.255.0.1
> Adding default route via gate0 (table 68)
> Gateway client - gateway (2.255.0.1) says: IP (169.254.0.1) is expired
> Deleting default route via gate0 (table 68)
> Adding default route to 2.255.0.1 (gw_flags: 65, tq: 253, gw_product: 0)
> Gateway client - got IP (169.254.0.1) from gateway: 2.255.0.1
> Adding default route via gate0 (table 68)
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
> On Fri, November 21, 2008 12:41 pm, Derek C wrote:
>
>> Hi again,
>>
>>
>>
>> It does look like a clock date/time issue.  I put ntpdate into both
>> boxes and managed to synchronize the dates.  I did the gateway box first
>> and then when I got a BATMAN default route on the 2nd node I ran ntpdate
>>  there too.
>>
>> All seems fine now and the BATMAN route is staying up all the time.
>>
>>
>>
>> My only concern is the "chicken and egg" situation (need BATMAN working
>>  to get ntpdate to get on the Internet).  I'm not sure how I got the
>> BATMAN
>> route up on the 2nd node when its date was Jan 1 2000 - maybe just
>> because the gateway node's date was ok?
>>
>> Derek
>>
>>
>>
>>
>> On Fri, November 21, 2008 10:36 am, Derek C wrote:
>>
>>
>>> Hi all,
>>>
>>>
>>>
>>>
>>> On a couple of test x86 based openwrt boxes (PC engines WRAP boards)
>>> I'm
>>> seeing a client (non-gateway) batman node setting-up and dropping the
>>> gateway over-and-over again.
>>>
>>> With debug set to 3 I see the log output below.
>>>
>>>
>>>
>>>
>>> Could it be because the WRAP boards have no clock battery ?  They
>>> always boot up and set their clocks to Jan 1 2000.
>>>
>>> thanks for any help
>>>
>>> Derek
>>>
>>>
>>>
>>>
>>> Gateway client - got IP (169.254.0.1) from gateway: 2.255.0.1
>>> Adding default route via gate1 (table 68)
>>> Gateway client - gateway (2.255.0.1) says: IP (169.254.0.1) is expired
>>>  Deleting default route via gate1 (table 68)
>>> Adding default route to 2.255.0.1 (gw_flags: 65, tq: 251, gw_product:
>>> 0)
>>> Gateway client - got IP (169.254.0.1) from gateway: 2.255.0.1
>>> Adding default route via gate1 (table 68)
>>> Gateway client - gateway (2.255.0.1) says: IP (169.254.0.1) is expired
>>>  Deleting default route via gate1 (table 68)
>>> Adding default route to 2.255.0.1 (gw_flags: 65, tq: 251, gw_product:
>>> 0)
>>> Gateway client - got IP (169.254.0.1) from gateway: 2.255.0.1
>>> Adding default route via gate1 (table 68)
>>> Gateway client - gateway (2.255.0.1) says: IP (169.254.0.1) is expired
>>>  Deleting default route via gate1 (table 68)
>>> Adding default route to 2.255.0.1 (gw_flags: 65, tq: 251, gw_product:
>>> 0)
>>> Gateway client - got IP (169.254.0.1) from gateway: 2.255.0.1
>>> Adding default route via gate1 (table 68)
>>> Gateway client - gateway (2.255.0.1) says: IP (169.254.0.1) is expired
>>>  Deleting default route via gate1 (table 68)
>>> Adding default route to 2.255.0.1 (gw_flags: 65, tq: 251, gw_product:
>>> 0)
>>> Gateway client - got IP (169.254.0.1) from gateway: 2.255.0.1
>>> Adding default route via gate1 (table 68)
>>> Gateway client - gateway (2.255.0.1) says: IP (169.254.0.1) is expired
>>>  Deleting default route via gate1 (table 68)
>>>
>>>
>>>
>>>
>>>
>>>
>>> --
>>> Derek C
>>>
>>>
>>>
>>>
>>> _______________________________________________
>>> B.A.T.M.A.N mailing list
>>> B.A.T.M.A.N@open-mesh.net
>>> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>>>
>>>
>>>
>>>
>>
>>
>> --
>> Derek C
>>
>>
>>
>> _______________________________________________
>> B.A.T.M.A.N mailing list
>> B.A.T.M.A.N@open-mesh.net
>> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>>
>>
>>
>
>
> --
> Derek C
>
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>
>


-- 
Derek C

