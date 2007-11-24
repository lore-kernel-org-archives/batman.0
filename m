From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] batmand still doesn't start the right way
Date: Sat, 24 Nov 2007 12:05:16 +0100
References: <4747BE35.3040307@absorb.it>
	<59044.85.41.146.90.1195884923.squirrel@krisma.oltrelinux.com>
	<4747C553.6020701@absorb.it>
In-Reply-To: <4747C553.6020701@absorb.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200711241205.16596.axel@open-mesh.net>
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

Hi rene,

your interface configuration looks correct, the following may sound weird but 
I've once observed a similar effect. The following happened:

 run batman on my notebook on a alias ethernet interface, connected to a small 
batman testbed - everything fine. Then send the notebook to deep sleep 
(suspend to disk) and resumed it when coming back the next day. Batman just 
continued but without any neighbors. Tcpdump showed exactly your 
observations. It traced the OGMs from the neighbors but not the own ones. I 
opened debug-level 4 to see whats going on and recognized that the batman on 
my notebook did broadcast OGM (at least the debug output claimed so) and it 
also revealed that the daemon received its own OGMs back (and then dropped 
then). The debug-level-4 then prints something like:

[   4570480] Received BATMAN packet via NB: 103.130.30.218 , IF: eth3:bmx 
103.130.30.218 (from OG: 103.130.30.218, seqno 46443, TTL 50, V 9, UDF 0, IDF 
0, DPF 1)
[   4570480] Drop packet: received my own broadcast (sender: 103.130.30.218)

So from the notebooks' batmand point of view the OGM is send and received, but 
its not even shown with tcpdump. I dont remember if the notebooks' batmand 
received the OGMs from the neighbor (but anyway, a neighbor is not fully 
accepted until there is a prooven bidirectional communication). 
I think even restarting the daemon did not help, but what finally helped was 
to pull the ethernet cable out of the NIC connector and plug it back again. 

For me it seemed like there was a problem with the (re-)initialization of the 
interface or just its alias interfaces. Maybe for some reason you are locked 
in a similar trap.

If this is the case the you might validate (e.g. using ping -I 192.168.40.184 
192.168.40.186 from your neighboring device) or settingup another alias 
network only on the interfaces of this problematic link and see if the 
problem is also there. 

happy debugging,

/axel


On Samstag 24 November 2007, rene wrote:
> Hi,
>
> a.anselmi@oltrelinux.com wrote:
> > can you give the exact IP configuration (network, netmask end bcast IP)
> > for every iface?
>
> -------------------------------------------------------------
> root@OpenWrt:~# ifconfig eth0:1
> eth0:1    Link encap:Ethernet  HWaddr 00:0D:B9:04:C3:74
>           inet addr:192.168.40.186  Bcast:192.168.43.255 
> Mask:255.255.252.0 UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           Interrupt:10 Base address:0xc000
>
> root@OpenWrt:~# ifconfig ath0:1
> ath0:1    Link encap:Ethernet  HWaddr 00:0B:6B:57:01:46
>           inet addr:192.168.41.186  Bcast:192.168.43.255 
> Mask:255.255.252.0 UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>
> root@OpenWrt:~# ifconfig ath1:1
> ath1:1    Link encap:Ethernet  HWaddr 00:0B:6B:57:04:6C
>           inet addr:192.168.42.186  Bcast:192.168.43.255 
> Mask:255.255.252.0 UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>
> root@OpenWrt:~#
> -----------------------------------------------------------------
>
> BATMAN was just started with 'batmand eth0:1 ath0:1 ath1:1'
>
> Regards,
> Rene
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


