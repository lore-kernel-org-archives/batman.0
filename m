Return-Path: <gmazzurco89@gmail.com>
Message-ID: <4F42234D.4010703@gmail.com>
Date: Mon, 20 Feb 2012 11:41:17 +0100
From: Gioacchino Mazzurco <gmazzurco89@gmail.com>
MIME-Version: 1.0
References: <CAFevQmM12dq09+FPtwedGAXnJxw8rsCwphLAa-qfmaQFifErNg@mail.gmail.com>
In-Reply-To: <CAFevQmM12dq09+FPtwedGAXnJxw8rsCwphLAa-qfmaQFifErNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] mesh: received packet with own address as source
 address
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Maybe related to the problem we had in Mistretta!

We upgraded just ONE node and it seems that bridge loop avoidance didn't
worked anymore

that node was attached to another node via lan and both nodes had bat0
and eth0 bridged, the 2 nodes started flooding the network with
rebroadcasted broadcast packet and every link was overloaded

the solution was to turn off the new node ( i have to go and disable the
bridging manually )

But I think that in my case the problem was triggered by the fact that
the two nodes has different batman-adv version one 2012.0.0 and the
other 2011.4.0 ( and i supposed that the two version have incompatible
loop avoidance )

Both node use batman-adv from openwrt repository

On 02/20/12 00:45, Filippo Sallemi wrote:
> Hi all,
> after upgrade of batman package on my nodes I see a very decerase of
> performance of my mesh network. When I connect to some node i see
> every time this message:
> 
> mesh: received packet with  own address as source address
> 
> now in a gateway mode my network config is:
> config 'interface' 'lan'
> 	option 'macaddr' '02:15:6d:7c:f0:88'
> 	option 'type' 'bridge'
> 	option 'ifname' 'mesh'
> 	option 'proto' 'static'
> 	option 'ipaddr' '10.240.136.1'
> 	option 'netmask' '255.0.0.0'
> 
> config 'interface' 'wan'
> 	option 'ifname' 'eth0'
> 	option 'proto' 'dhcp'
> 
> config 'interface' 'msh0'
> 	option 'proto' 'none'
> 	option 'mtu' '1528'
> 
> in client mode nodes the network config is:
> 
> config 'interface' 'loopback'
> 	option 'ifname' 'lo'
> 	option 'proto' 'static'
> 	option 'ipaddr' '127.0.0.1'
> 	option 'netmask' '255.0.0.0'
> 
> config 'interface' 'lan'
> 	option 'macaddr' '02:15:6d:b0:19:48'
> 	option 'type' 'bridge'
> 	option 'ifname' 'eth0 mesh'
> 	option 'proto' 'dhcp'
> 
> config 'interface' 'msh0'
> 	option 'proto' 'none'
> 	option 'mtu' '1528'
> 
> 
> Someone can help me? I've 20 nodes crazy
> 
