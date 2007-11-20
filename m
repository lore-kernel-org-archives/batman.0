Message-ID: <4742C4FF.4010307@absorb.it>
Date: Tue, 20 Nov 2007 16:59:03 +0530
From: rene <batman@absorb.it>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] single IP for multiple interfaces
References: <47426F09.9060605@absorb.it>	<200711201008.13700.axel@open-mesh.net>	<4742B775.2060601@absorb.it>
	<200711201159.15845.lindner_marek@yahoo.de>
In-Reply-To: <200711201159.15845.lindner_marek@yahoo.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
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

Hi,

Marek Lindner wrote:
> Hi,
> 
>> 05:12:09.512310 arp who-has 192.168.43.255 tell 192.168.42.25
>> 05:12:10.512178 arp who-has 192.168.43.255 tell 192.168.42.25
> 
> These ARP request are not issued by BATMAN itself. BATMAN does only send 
> broadcast packets - your system creates these requests. 
> 
> 
>> This is two times the same node, first time it recognizes the broadcast
>> the right way, second time not.
> 
> BATMAN askes the system for the IP and broadcast addresses. In both cases the 
> system responds with the same answer. I don't see much difference from 
> batmans point of view.
But thats definitely whats happening, on OpenWrt WRAP (x86) as well as
on BroadCom (mipsel). It happened more than once, and the only thing
what was done to change the behavior was killing and starting batmand
again. Which doesn't changed every time the behavior.

> You have multihomed OLSR nodes with a single IP and that works ? Can anyone of 
> the OLSR folks say something about that ? I can't imagine how the routing 
> daemon can distinguish 2 distinct connections with the same address ...
Works perfect, we use for instance the WRAP-boards in our network with
two WIFI- and one LAN-Interface, all three having the same IP.
The related patch is at
http://titan.www.opennet-initiative.de/olsrd_patches/mipip.patch, but
its since a while part of olsrd.

Regards,
Rene
