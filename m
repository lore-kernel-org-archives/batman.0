From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] problem starting batmand (v799)
Date: Tue, 20 Nov 2007 10:08:13 +0100
References: <47426F09.9060605@absorb.it>
In-Reply-To: <47426F09.9060605@absorb.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200711201008.13700.axel@open-mesh.net>
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

On Dienstag 20 November 2007, rene wrote:
> Hi,
>
> starting batmand, the daemon sometimes doesn't seem to recognize the
> network the right way.
>
>
> root@25:~# killall batmand
> root@25:~# batmand eth1:1 vlan0:1
> Using interface eth1:1 with address 192.168.42.25 and broadcast address
> 192.168.43.255
> Using interface vlan0:1 with address 192.168.42.25 and broadcast address
> 192.168.43.255

> -------------------------------------------
> on the other node:
> root@25:~# killall batmand
> root@25:~# batmand eth1:1 vlan0:1
> Using interface eth1:1 with address 192.168.42.25 and broadcast address
> 192.168.43.255
> Using interface vlan0:1 with address 192.168.42.25 and broadcast address
> 192.168.43.255
> root@25:~#
>

What is definitively not correct is that your capture indicates 4 times the 
same IP address (192.168.42.25) on 4 different interfaces. 
Can you check whether your capture, the alias-interface configuration (what is 
the output of ip a ?), or the daemon is wrong?
There MUST be a different IP address for each BATMAN interface in the network 
(also if a single BATMAN node has more than one interface). 
All BATMAN interfaces SHOULD  have the same netmask and broadcast address.

ciao,
axel
