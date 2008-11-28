Message-ID: <4930713D.40809@web.de>
Date: Sat, 29 Nov 2008 00:31:25 +0200
From: "Chris W." <chris-wy@web.de>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] 0.3.1 rv1152 - some test results
References: <492DDC20.7090900@web.de>	<200811280043.26990.lindner_marek@yahoo.de>	<49302F8E.2040502@web.de>
	<20081128205145.GB25072@pandem0nium>
In-Reply-To: <20081128205145.GB25072@pandem0nium>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: chris-wy@web.de
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



> Hey, 
> 
> On Fri, Nov 28, 2008 at 07:51:10PM +0200, Chris W. wrote:
>> Now rv1161 is on, the reduced test area is
>> http://preveli.gr/mesh/bat-228-3b.gif
>>
> 
> 
> The "invalid" messages probably is caused by the bad IPs (see below). 
> The gateway sends an "IP invalid"-message back if a not advertised IP 
> was used. The client then disconnects from the gateway.
> 
> We should probably change this policy. ;)
> 
I'd second this.

> 
> Only the advertised IPs are allowed. However you can build a NAT for
> your gateway, this would ensure that only the advertised IP is used.
> Something like 
> 
>   iptables -t nat -A POSTROUTING -o gate0 -j MASQUERADE
> 
> should do the job. (maybe add something like "--source 192.168.100.0/24"
> to further constrain the traffic).

Uh, this would mean double NAT in the network, sip phones don't like it.

>> Thank you for the explanation. Is this module available for OpenWrt 0.9
>> broadcom somewhere ?
> 
> I don't know of precompiled packages, maybe someone else does? :)
well, I'll find a place ;-)
> 
>> Another point is that
>> even if a gateway's internet connection is down, but announced, it is
>> chosen as tunnel endpoint. Something similar to the olsrd-dyn-gw would
>> be great.
> 
> Actually we have a mechanism to check for black hole gateways (on the
> client).
> 
Checked it with -r 2 -p 10.4.5.30 which is down at this time, reachable 
via  Atheros nodes.
=> 10.4.5.30       ( 86)       10.4.2.72 [    ath0:1], gw_class  40 - 
2048KBit/256KBit, gateway failures: 0
    10.4.2.2        (140)       10.4.2.72 [    ath0:1], gw_class  40 - 
2048KBit/256KBit, gateway failures: 0
    10.4.2.71       (150)       10.4.2.72 [    ath0:1], gw_class  40 - 
2048KBit/256KBit, gateway failures: 0

>>>> -3- previously announced networks are not deleted (8.106), the routing
>>>> table collects multiple entries for the same destination
>>> Thanks for the hint. Fixed in revision 1159.
>>>
>> Yes, no multiple entries anymore in 1161.
>>
>> The announced network of 2.72 gets lost after some minutes on all nodes.
>> Logs show
>> Nov 28 17:13:43 (none) kern.err batmand[18641]: Error - can't add route
>> to 10.2.72.0/24 via 10.4.2.95 (table 65): File exists
>> Nov 28 17:13:43 (none) kern.err batmand[18641]: Error - can't add route
>> to 10.2.72.1/32 via 10.4.2.95 (table 65): File exists
>> root@10.4.2.72:~# ip ro sh ta 65
>> 10.2.50.0/24 via 10.4.2.50 dev eth1  proto static  src 10.4.2.72
>>
> 
> Mhm, this is probably a regression in the new hna_buff_delete() function
> ... but i'm not sure. The "File exists" Error should not be visible in
> any case.
> 
> Could you please (if possible) create a complete dump until the "File
> exists" problems happen with debug level 4, and send this log to me and 
> Marek? We can have a more detailed view what's happening then. 
> 
> (call batman with -cd4 for example)
>
dumped

> best regards,
> 	Simon
> 
> 
greetings,
Christian
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
