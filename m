Return-Path: <tonyputi@gmail.com>
MIME-Version: 1.0
From: Filippo Sallemi <tonyputi@gmail.com>
Date: Mon, 20 Feb 2012 00:45:01 +0100
Message-ID: <CAFevQmM12dq09+FPtwedGAXnJxw8rsCwphLAa-qfmaQFifErNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [B.A.T.M.A.N.] mesh: received packet with own address as source
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

Hi all,
after upgrade of batman package on my nodes I see a very decerase of
performance of my mesh network. When I connect to some node i see
every time this message:

mesh: received packet with  own address as source address

now in a gateway mode my network config is:
config 'interface' 'lan'
	option 'macaddr' '02:15:6d:7c:f0:88'
	option 'type' 'bridge'
	option 'ifname' 'mesh'
	option 'proto' 'static'
	option 'ipaddr' '10.240.136.1'
	option 'netmask' '255.0.0.0'

config 'interface' 'wan'
	option 'ifname' 'eth0'
	option 'proto' 'dhcp'

config 'interface' 'msh0'
	option 'proto' 'none'
	option 'mtu' '1528'

in client mode nodes the network config is:

config 'interface' 'loopback'
	option 'ifname' 'lo'
	option 'proto' 'static'
	option 'ipaddr' '127.0.0.1'
	option 'netmask' '255.0.0.0'

config 'interface' 'lan'
	option 'macaddr' '02:15:6d:b0:19:48'
	option 'type' 'bridge'
	option 'ifname' 'eth0 mesh'
	option 'proto' 'dhcp'

config 'interface' 'msh0'
	option 'proto' 'none'
	option 'mtu' '1528'


Someone can help me? I've 20 nodes crazy

-- 
Filippo Sallemi
