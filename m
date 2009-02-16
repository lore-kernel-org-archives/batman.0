Message-ID: <49992315.4090106@irt.de>
Date: Mon, 16 Feb 2009 09:25:57 +0100
From: Tobias Gieseke <gieseke@irt.de>
MIME-Version: 1.0
References: <49945DAC.2010907@gmail.com>
In-Reply-To: <49945DAC.2010907@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] WiMAX
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

Hi,

we have some WiMax Cards but they are all PCMCIA. I may test them with 
Batman but I guess there will be serious driver problems in Linux. The 
cards where shipped with Windows drivers only and even those got some 
problems in the end. I agree with the others, that mesh in an WiMax 
system does not make sense (yet). WiMax is build for "infrastucture 
mode" the base station has the mayor task and is able to controll the 
clients in transmitting power, modulation etc. espacially in mobile 
Wimax (802.16e). The only case where mesh could come in is the 
communication between the Base stations, but that would be discrete 
links, so you don't really need a mesh. But I think you considerd this 
and you have an own concept for mesh in WiMax. Perhpas you could explain 
that to me (and the others)?
I don't know anything about an adhoc mode for WiMax either.

Kind regards,

Tobi

Tim LePes:
> Has anyone been playing with BATMAN on WiMAX hardware?  I have a project
> that I had to back burner for a while and I am getting ready to start
> active work again.  I am looking to see if I can find a mini PCI WiMAX
> card that I can use in a Mesh AP, where WiMAX will be used for the
> backbone and both WiFi and 10/100 Ethernet for clients to connect to the
> AP.  The idea is for drop-and-go network coverage in disaster areas or
> other places where you want to get connectivity up in a hurry.  I have a
> dev board and am finally able to get some parts to help me work on it
> again.  Power supply, PCI to MiniPCI adapter, PoE hardware, enclosure.. 
> and of course a WiMAX card.  I am also shopping for a WiFi card too, so
> recommendations there would be welcome.  Though to be fair I haven't
> been googling on that much yet, the WiMAX backhaul is my main concern at
> the moment.  Doing the WiFi AP part should be relatively easy as it is a
> mature technology w/r/t parts and drivers availability.  Any advice?  So
> far it seems that Intel has the greatest presence in my googling for
> WiMAX on Linux.
>
>
> Thanks so much!
>
> Tim LePes
>   
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>   
