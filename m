Message-ID: <49B98151.2010906@java-system.com>
Date: Thu, 12 Mar 2009 22:40:33 +0100
From: marco tozzini <lists@java-system.com>
MIME-Version: 1.0
References: <49B825BE.4040605@java-system.com>
	<200903112214.44339.onelektra@gmx.net>
In-Reply-To: <200903112214.44339.onelektra@gmx.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] Unable to connect to internet
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

elektra wrote:
> Hi .
>
>   
>> Any Hints?
>>     
>
> sure: You are not announcing a default route.
>
> On mesh router connected to ADSL:
>
> batmand -g 1000 ath0
>
> On other mesh router:
>
> batmand -r 1 ath0
>
> You have to NAT towards the internet on the gateway.
>
> Cheers,
> elektra 
>   

Thank you for your help
It still doesn't work
But something I can't understand happened

root@OpenWrt:~# batmand -a 192.168.0.1/24 -g 1000 -d 3 ath0
WARNING: You are using the unstable batman branch. If you are interested 
in *using* batman get the latest stable release !
Interface activated: ath0
Using interface ath0 with address 192.168.2.200 and broadcast address 
192.168.2.255
B.A.T.M.A.N. 0.3-beta (compatibility version 5)
Warning - batgat kernel modul interface (/dev/batgat) not usable: No 
such file or directory
This may decrease the performance of batman!
debug level: 3
gateway class: 33 -> propagating: 1024KBit/256KBit
Adding throw route to 192.168.0.0/24 via 0.0.0.0 (table 65 - unknown)
Adding throw route to 192.168.0.0/24 via 0.0.0.0 (table 66 - unknown)
Adding throw route to 192.168.0.0/24 via 0.0.0.0 (table 67 - unknown)
Adding throw route to 192.168.0.0/24 via 0.0.0.0 (table 68 - unknown)
Adding route to 169.254.0.0/16 via 0.0.0.0 (table 254 - gate0)
Adding route to 192.168.2.203 via 0.0.0.0 (table 66 - ath0)

root@OpenWrt:~# route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use 
Iface
192.168.2.0     *               255.255.255.0   U     0      0        0 ath0
192.168.0.0     *               255.255.255.0   U     0      0        0 
br-lan
169.254.0.0     *               255.255.0.0     U     0      0        0 
gate0
default         www.routerlogin 0.0.0.0         UG    0      0        0 
br-lan
root@OpenWrt:~#

It seems batman set a gate0 interface with 169.254.x.x IP address
How can I use this one with my 192.168.0.1 ADSL router?

Thanks

Ciao
Marco



