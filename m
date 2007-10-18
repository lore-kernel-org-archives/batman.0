From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] no gateway / tun interface / default route
Date: Fri, 19 Oct 2007 01:35:40 +0200
References: <4717BE98.2010206@ddmesh.de>
In-Reply-To: <4717BE98.2010206@ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200710190135.41117.axel@open-mesh.net>
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

Hello

On Donnerstag 18 Oktober 2007, Freifunk Dresden wrote:
> Hello,
>
> I have problems with the gateway. The following setup is used:
>
> Laptop: batmand -g 1024/200 -a 104.61.0.0/16 -s 10.12.0.1
> --no-unreachable-rule --no-throw-rules --no-prio-rules --no-unresp-gw-check
> --resist-blocked-send wlan0 bbs /t 1 /i bbc /t 1 /i wrt54gs: batmand

> batmand -d 4 -r 2 --t 63 --no-unreachable-rule --no-throw-rules
> --no-prio-rules --no-unresp-gw-check --resist-blocked-send eth1 bbs /t 1 /i
> bbc /t 1 /i

Generally you should announce the ip address of your non-primary interfaces 
(bbs and bbc) with HNA. Otherwise the traffic you generate on these nodes 
might leave the node with a source IP address which is simply not known 
beyond that link. If you really want to completely hide the IP addresses of 
bbs and bbc then you  need to do NAT for all locally generated packets, 
except for the OGMs. 
>
> The laptop uses a proxy (squid) to only allow some URLs. Also the firewall
> only allows some specific ip ranges. Does this have any influence for the
> gateway detection? --------------------------
I dont know!
> During start the laptop produces the following syslog entries.
> Oct 18 21:54:53 0-1 batmand[13603]: Warning - batgat kernel modul interface
> (/dev/batgat) not usable: No such file or directory This may decrease the
> performance of batman!
Thats OK!

> kernel: bat0: Disabled Privacy Extensions
this message I dont know!

> Oct 18 21:54:53 0-1 batmand[13603]: Error - can't create tun device
> (TUNSETIFF): Device or resource busy Oct 18 21:54:53 0-1 batmand[13603]:
> Trying to name tunnel to bat2 ... Oct 18 21:54:53 0-1 kernel: bat2:
This is usual as well, batmand is searching for an unused tunnel name.
>
> ip route
> 10.203.71.21 dev vpn1  proto kernel  scope link  src 10.203.71.22
> 10.203.71.0/24 via 10.203.71.21 dev vpn1
> 10.63.0.0/16 via 10.203.71.21 dev vpn1
> 10.0.0.0/8 dev wlan0  proto kernel  scope link  src 10.12.0.1
so you have some overlapping IP ranges?
> default via 192.168.178.1 dev eth0
>
> 0-1:/home/ffdevel/ff-build/open-mesh.net# ip route list table bat_route
> 10.12.10.1 dev wlan0  proto static  scope link  src 10.12.0.1
> 10.12.10.17 dev wlan0  proto static  scope link  src 10.12.0.1
> throw 104.61.0.0/16  proto static
>
> 0-1:/home/ffdevel/ff-build/open-mesh.net# ip route list table bat_hna
> 10.12.10.0/28 via 10.12.10.1 dev wlan0  proto static
> 10.12.10.16/28 via 10.12.10.17 dev wlan0  proto static
> throw 104.61.0.0/16  proto static
>
> 0-1:/home/ffdevel/ff-build/open-mesh.net# ip route list table bat_default
> throw 104.61.0.0/16  proto static

ip rule
would be also interesting. Since you have used the --no-prio-rules, have you 
manually configured a rule like
ip rule add pref 6600 from all to 10.0.0.0/8 t 66

Can  you ping all the other mesh IPs, particulary the GW: 10.12.0.1

>
> B.A.T.M.A.N. 0.3-exp, MainIF/IP: wlan0 10.12.0.1, WindSize: 128, BLT: 2,
> OGI: 1000, UT: 0d 0h 2m Originator           viaIF         Router (brc rcvd
> lseq lvld) [    viaIF RTQ  RQ  TQ].. alternatives... 10.12.10.1         
> wlan0      10.12.10.1 (126 128 39555    0) [    wlan0 118 127 118]        
> 10.12.10.17 (  2) 10.12.10.17         wlan0     10.12.10.17 (128 128 49229 
>   0) [    wlan0 123 128 123]

That looks good.
>      Gateway              Router (#/128)
> => 10.12.0.1             10.12.0.1 (123), gw_class 33 - 1024KBit/256KBit,
> reliability: 0
In the first place, this just indicated that the local batmand has decided for 
one of the available GWs. It does not necessarily mean, that the connection 
to that GW was successfull

>
> But the ip route list table bat_default contains only a throw entry and not
> the default route. 
There is no default route until the client has decided for a GW. After the 
startup, the daemon waits a while before it decides for a GW. This is done to 
gather some statistics about the available GWs. 
> ip addr lists the interfaces but always without an ip 
The bat0 tunnel interface does not get an IP address until the client node 
sends some data over the tunnel. But if the GW is not reachable (see above) 
it can never get one.
> address assigned. The batman revision I use is the batman-experimental
> Rev724. also some revisions before have the same result.
>
> Despite the presens of --no-throw-rules throw rules are added to the batman
> routing tables to throw the hna entries. Is this wanted?
Probably not :-)
>
> In older version I got a tunnel but this has be removed by batman. Perhaps
> because the client didn't not use it to much?
??? Which tunnel has been removed by batman and when?
>
> If I try to add a tunnl manually (ip route add default dev bat0 table
> bat_default) and try to ping an internet address the client logread shows
> :kern.err batmand[6649]: Error - can't receive ip from gateway: number of
> maximum retries reached
>
> The manually added default route is removed after a while by batmand.

It really sounds your GW is not reachable. Check your ip rules and if
ping 10.12.0.1 
works.

ciao
/axel
>
> Has anyone an idea what I have done wrong.
>
> Regards
>  Stephan
>
>
>
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


