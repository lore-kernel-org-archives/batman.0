Return-Path: <michael.rack@rsm-freilassing.de>
Message-ID: <4AA4DD8F.8000705@rsm-freilassing.de>
Date: Mon, 07 Sep 2009 12:16:47 +0200
From: Michael Rack <michael.rack@rsm-freilassing.de>
MIME-Version: 1.0
References: <4AA34865.9000203@rsm-freilassing.de>	<200909062311.22521.lindner_marek@yahoo.de>	<4AA3EDCD.1090704@rsm-freilassing.de>
	<200909070147.05443.lindner_marek@yahoo.de>
In-Reply-To: <200909070147.05443.lindner_marek@yahoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] Problems with Gateway-Selection without option -g
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

Am 06.09.2009 19:47, schrieb Marek Lindner:
>> When using the tunneling interface, the MTU is set to a lower value then
>> 1500 bytes (1431 bytes). B.A.T.M.A.N have in addition to the NAT-Helper
>> set the TCPMSS Flag to something like 1371 bytes (1431 bytes - 20 Bytes
>> of MAC-Address and - 40 Bytes of TCP/IP Header). I found nothing about
>> TCPMSS on my firewall-rules (iptables) in the table "mangle".
>>
>> Without TCPMSS, packages that transport more then 1371 bytes will be
>> silently dropped in my case.
>
> Not sure how you get to these numbers (1431 / 1371) as the batman tunnel is
> running over UDP which costs 29 Bytes [20 Bytes IP + 8 Bytes UDP + 1 Byte
> batman stuff] in total, reducing the maximum packet size to 1471.
>
> You are right about the the TCPMSS configuration - batman could set this
> automatically as well. I suggest something like this:
>
> iptables -I FORWARD -p tcp --tcp-flags SYN,RST SYN -o gate0 -j TCPMSS --clamp-
> mss-to-pmtu

I got these numbers by "/sbin/ip addr show dev gate0".

gate0: <POINTOPOINT,MULTICAST,NOARP,UP,LOWER_UP> mtu 1431 qdisc 
pfifo_fast qlen 500
     link/[65534]
     inet 169.254.0.0/32 scope global gate0

MTU is set to 1431 bytes.

>> Currently i have my own policy-routing-script, because B.A.T.M.A.N does
>> not support HOST-Routes xxx.205.12.4/32. But why does B.A.T.M.A.N not
>> fully support Host-Routes? A mash with only Host-Addresses is easier to
>> administrate then complete networks. A second goal is, that the ad-hoc
>> mobile user is free to change his position across the net.
>
> Your own policy-routing-script ?
> Why do you think batman does not support host routes ? I had the feeling
> batman supports host routes in all possible ways.  :-)

IP-Host #1: 123.205.12.0 / 32
IP-Host #2: 123.205.12.4 / 32

IP RULES ON "HOST #2":
~ $ /sbin/ip rule show
6600:    to 123.205.12.4 lookup batman_hosts [66]
6601:    from all lookup batman_networks [65]
6700:    to 123.205.12.4 lookup batman_unreach [67]

Host #1 (123.205.12.0) is in the routingtable of batman_hosts [66].

But i can not ping 123.205.12.0, because the kernel will not enter the 
rule 6600.

When i configure my Host #2 to a /24 network, all went fine. Then the 
rule will setuped as follow:

6600:    to 123.205.12.4/24 lookup batman_hosts [66]

In this case, i had to write my own routing-policy-script.

Cheers,
Michael.
