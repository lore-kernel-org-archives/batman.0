From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] routing problem?
Date: Sat, 10 Nov 2007 12:43:28 +0100
References: <2bda28cd0711090623r2e7b8750g558aebab35247da0@mail.gmail.com>
In-Reply-To: <2bda28cd0711090623r2e7b8750g558aebab35247da0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200711101243.28980.axel@open-mesh.net>
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

On Freitag 09 November 2007, Stefano Scipioni wrote:
> I'm testing batman 0.3 exp rv 777
>
> traceroute give me a problem
>
> root@sala:~$ traceroute  10.0.1.1
> traceroute: can't find interface
> root@sala:~$ ip route ls tab 66
> 10.1.5.104 dev ath0  proto static  scope link  src 10.1.5.102
> 10.1.5.130 via 10.1.5.104 dev ath0  proto static
> 10.1.5.129 via 10.1.5.1 dev ath0  proto static
> 10.1.5.1 via 10.1.5.104 dev ath0  proto static
> root@sala:~$ ip route ls tab 65
> 10.0.1.0/24 via 10.1.5.1 dev ath0  proto static
> root@sala:~$ traceroute  10.0.1.1
> traceroute: can't find interface
> root@sala:~$ ping 10.0.1.1
> PING 10.0.1.1 (10.0.1.1): 56 data bytes
> 64 bytes from 10.0.1.1: seq=0 ttl=61 time=9.119 ms
> 64 bytes from 10.0.1.1: seq=1 ttl=61 time=8.486 ms
>
> traceroute works If I utilize source address option.
> What is my mistake?

i think theres no mistake, busybox-traceroute is just to stupid to figure out 
the correct src ip. In my test, tcpdump showed that it uses the first 
(non-alias) address of the outgoing interface. No matter if the route to the 
destination specifies the src address or not. Did you use an alias interfaces 
for this scenrio?

And even better, the traceroute on my notebook chooses the correct outgoing 
src address but unless i specify it also manually it does not work either. 
The reason is a corrupted udp checksum which is verified by the final 
destination of the packet.


>
> Also if one of nodes has no batman-exp running on it I can't reach it
> from neighbours (I use batmand on ath0 interface, not an alias)?
> Perhaps I have to use --no-unreachable-rule?

For correct routing between batman-nodes and non-batman nodes you need to set 
routes manually. If a multi-homed node is involved with the same netmask on 
multiple interfaces then you must also specify the src address for the manual 
routing entry like: ip r add 10.0.1.1/32 dev ath0 src 10.1.5.102 
And on the batman-node you must either HNA announce the ip of the non-batman 
node using -a (this will automaticall disable the unreachable rule to hit for 
the ip address of the non-batman node).

Or, just as you suggested, launch batman with the --no-unreachable-rule.


ciao,
axel

>
> Stefano
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


