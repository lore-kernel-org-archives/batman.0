Return-Path: <emunicio@gmail.com>
MIME-Version: 1.0
From: Esteban Municio <emunicio@gmail.com>
Date: Thu, 2 Aug 2012 19:35:34 -0500
Message-ID: <CAMVTf1hm9Q8Ppu2Lq6h4+7OpvZ9meLYhxFKHFLhudD3LCTNXmg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] Problems with internet connection in a mesh-network,
 (and dhcp and wireless access)
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Hi all

I wrote recently about problems with our batman-adv mesh
implementation in a development proyect in Peru:

https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2012-August/007820.html

Now we are having problems again.
Our mesh-network are formed with Ubiquiti nanostation M5 nodes running
OpenWRT(10.03.x, r32751)+ Batman-adv 2.6.32.
In one of the nodes, the wan gate is connected with Public IP to
internet and I can access to internet from there.

But from a laptop(without batman-adv), I can make ping to all the
nodes of the mesh, but i can't make ping to 8.8.8.8 neither the Ip
public gateway. However, I can make ping to my Ip Public, in the
interface wan of my gateway node.

What am I doing wrong? I have tried to write static routes, but I
think that the problem is about the mesh-bridge.
Is it beacuse of i need do NAT?

All the nodes of the mesh can see themselves, and I set the node with
the gateway to internet like the gateway of the mesh, but it does not
work.

Any help or comment?

That is my /etc/rc.local and /etc/config/network in the gateway node:

/etc/rc.local

wifi up
ifconfig wlan0 mtu 1528
batctl if add wlan0
ifconfig wlan0 up
ifconfig bat0 up
brctl addbr mesh-bridge
brctl addif mesh-bridge eth0
brctl addif mesh-bridge bat0
ifconfig eth0 up
ifconfig bat0 up
ifconfig mesh-bridge inet 1.1.1.1 netmask 255.255.255.0
ifconfig mesh-bridge up
exit 0

/etc/config/network

config 'interface' 'loopback'
    option 'ifname' 'lo'
    option 'proto' 'static'
    option 'ipaddr' '127.0.0.1'
    option 'netmask' '255.0.0.0'

config 'interface' 'lan'
    option 'ifname' 'eth0'
    option 'proto' 'static'
    option 'ipaddr' '192.168.1.2'
    option 'netmask' '255.255.255.0'

config 'interface' 'wan'
    option 'ifname' 'eth1'
    option 'proto' 'static'
    option 'ipaddr' my Ip public
    option 'netmask' '255.255.255.192'
    option 'gateway' my ip public gateway
    option 'dns' '8.8.8.8'

config 'route'

And some offtopic questions...

What should i do for permit to others laptops without batman-adv can
connect by wireless to the mesh, make another wlan interface with
another ssid in ap mode and add it to the mesh-bridge?

 With ethernet all works fine, the problem is without wire...
Should I check the dhcp in order to the laptops can connect directly
to the mesh network? How could I configurate it?


Thanks you very much and regards

-- 
Esteban
