Message-ID: <4747C553.6020701@absorb.it>
Date: Sat, 24 Nov 2007 12:01:47 +0530
From: rene <batman@absorb.it>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] batmand still doesn't start the right way
References: <4747BE35.3040307@absorb.it>
	<59044.85.41.146.90.1195884923.squirrel@krisma.oltrelinux.com>
In-Reply-To: <59044.85.41.146.90.1195884923.squirrel@krisma.oltrelinux.com>
Content-Type: text/plain; charset=ISO-8859-1
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

a.anselmi@oltrelinux.com wrote:
> can you give the exact IP configuration (network, netmask end bcast IP)
> for every iface?
-------------------------------------------------------------
root@OpenWrt:~# ifconfig eth0:1
eth0:1    Link encap:Ethernet  HWaddr 00:0D:B9:04:C3:74
          inet addr:192.168.40.186  Bcast:192.168.43.255  Mask:255.255.252.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          Interrupt:10 Base address:0xc000

root@OpenWrt:~# ifconfig ath0:1
ath0:1    Link encap:Ethernet  HWaddr 00:0B:6B:57:01:46
          inet addr:192.168.41.186  Bcast:192.168.43.255  Mask:255.255.252.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1

root@OpenWrt:~# ifconfig ath1:1
ath1:1    Link encap:Ethernet  HWaddr 00:0B:6B:57:04:6C
          inet addr:192.168.42.186  Bcast:192.168.43.255  Mask:255.255.252.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1

root@OpenWrt:~#
-----------------------------------------------------------------

BATMAN was just started with 'batmand eth0:1 ath0:1 ath1:1'

Regards,
Rene
