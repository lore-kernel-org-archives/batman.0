From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] 0.3.1 rv1152 - some test results
Date: Fri, 28 Nov 2008 00:43:26 +0800
References: <492DDC20.7090900@web.de>
In-Reply-To: <492DDC20.7090900@web.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200811280043.26990.lindner_marek@yahoo.de>
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


Hey,

> thought I'd just let you know what I experienced when testing rv1152 on
> an outdoor network with atheroses and broadcoms, olsr in parallel.
> Interfaces are started with
> ifconfig eth1:1 10.4.2.29 netmask 255.255.0.0 broadcast 10.4.255.255
>
> The batman test area looks something like this:
> http://preveli.gr/mesh/bat-228-2b.gif

wow - looks pretty good.


> -1- gateway:
> Adding default route to 10.4.2.2 (gw_flags: 40, tq: 181, gw_product: 0)
> Gateway client - got IP (169.254.0.1) from gateway: 10.4.2.2
> Adding default route via gate0 (table 68)
>
> gateway log:
> Gateway - assigned 169.254.0.1 to client: 10.4.2.29
> Gateway - assigned 169.254.0.1 to client: 10.4.2.29
> Gateway - assigned 169.254.0.1 to client: 10.4.2.29

You probably experience the same issue as Derek. You could verify whether it 
is related to endianess or not by looking in the dmesg output on the gateway. 
Such seldom errors are reported in the kernel log (on OpenWRT you may use 
logread to access it). We are looking for messages like: "Error - got packet 
from unknown client ..."


> -?- What is batgat for, does it disannounce a gateway which in fact is
> down e.g due to dsl-failure ?

The batman daemon maintains a tunnel connection to every "batman internet 
client". Every packet that goes to the internet or comes back has to go 
through this tunnel. As it is a user space tunnel a lot of copying between 
user space and kernel land is necessary. Depending on the number of clients 
and the CPU power available this might be a bottleneck.
The batgat kernel module tries to overcome this limitation. Once loaded the 
batman daemon will detect its presence automatically on startup. The daemon 
will activate the kernel module to let it handle the tunneling, hence avoiding 
the expensive copy operations. There is no difference between the daemon 
tunneling and the kernel tunneling other than that.

I will put this into our FAQ.


> -2- together with olsrd.
> All olsr nodes are on the subnet 192.168.x.x, all batman interfaces are
> aliases except on fonera 2.29 which is batman only.
>
>  From a gateway node running olsrd in parallel the route to an announced
> network drops out towards the internet, the node itself is reachable:

Sorry, I don't understand this. Can you explain a bit more ?


> -3- previously announced networks are not deleted (8.106), the routing
> table collects multiple entries for the same destination

Thanks for the hint. Fixed in revision 1159.


> Well, I'll keep on testing ;-)

Cool ! Many thanks for your hints - we are waiting for feedback.  :-)

Regards,
Marek


