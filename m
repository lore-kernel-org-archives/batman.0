Return-Path: <combsca90@gmail.com>
MIME-Version: 1.0
From: Corey Combs <combsca90@gmail.com>
Date: Mon, 22 Oct 2018 13:51:21 -0400
Message-ID: <CAPzaX0ic23YurEjexLgNq4x6aaAp38f4Nj=iMfNDbLXkHCwhXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [B.A.T.M.A.N.] Version help
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

Hello,

I'm currently working on a project that uses BATMAN for a mesh network
across multiple Beagle Bone Blacks which are running a Debian version
7.9 at the moment.  They also are running batctl debian-2012.1.0-1
[batman-adv 2012.5.0].  I would like to connect a laptop to the
existing network either using Debian or Ubuntu, however I have run
into issues with compatibility.  I configured everything identically
with the laptop and I believe I'm connected to the network, but I
cannot see any other devices on the network.  Is it advisable to
upgrade the version of batctl on the 'bone or downgrade the version on
debian or Ubuntu so that the versions align?  Or is there something
else I am missing in my efforts?

My process for configuring the BBB and the laptop follow this
construct, using appropriate hardware names when required.  I have it
all in a script that runs on startup so it differs a little from the
lines below.  Each node has it's own assigned IP address as well.

modprobe batman-adv
batctl if add eth0
ifup wlan0
ifconfig wlan0
ifconfig wlan0 down
ifconfig wlan0 mtu 1532
iwconfig wlan0 mode ad-hoc essid reynoldsplus ap CA:FE:C0:DE:F0:0D channel 11
batctl if add wlan0
ifconfig wlan0 up
ifconfig bat0 up
ifconfig bat0 10.200.8.1
route add default gw 10.0.99.1
echo bat0 > /sys/class/net/eth0/batman_adv/mesh_iface
echo 1 > /proc/sys/net/ipv4/ip_forward

Thank you.

Corey
