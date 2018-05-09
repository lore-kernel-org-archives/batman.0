Return-Path: <dandenson@gmail.com>
MIME-Version: 1.0
From: dan <dandenson@gmail.com>
Date: Wed, 9 May 2018 17:43:56 -0600
Message-ID: <CAA_JP8VLAE7pFH+1ztUp+ZUhJGFFeLR_cWHz=tduRFHPAYv=3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [B.A.T.M.A.N.] sanity check please
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

I'm trying to see how many bits I can push across batman-adv.

My test setup is 1 Proxmox host with 3 ubuntu 16.04 VM's.

VM1
bat0 (ens19) 192.168.5.1/24

VM2
bat0 (ens19,ens20) 192.168.5.2/24

VM3
bat0 (ens20) 192.168.5.3/24

So VM1 and VM3 are on different 'physical' network segments.


I'm running iperf3 with VM1 the server and VM3 the client

VM1
iperf3 -s
VM3
iperf3 -c 192.168.5.1 -b 10000M -t 60 -P 1

output is 1.75Gbits

-P 99

output is 831Mbps


-P 99 *BUT* hitting the 'native' LAN address of 192.168.1.1 (each VM
has an ens18 on this network)

4.8Gbps

-P 99 from VM2

~1.67Gbps

So I am definitely putting batman-adv in the way and it's having a
clear impact of throughput.  I've also double checked that killing VM2
breaks the connection.

Based on the number of retries and how they compound with more
parallel streams, and that the only substantial CPU used here is
iperf3 in the VM and virtio on the host, the virtio nic is the
bottleneck.  Hardware network should likely perform better.

Ultimate goal here is to basically replicate the concept of SPB but
with a small batman-adv node instead of a switch to replace and
OSPF/MPLS/VPLS wISP network.

I am running bat0 at mtu 1400 so I wouldn't have to switch out from
linux bridges in prox but I don't expect that to have a substantial
effect, maybe a couple % difference.

Has anyone else performed similar tests on hardware/wired connections?
 There would be point-to-point half-duplex and full duplex wireless
links but no multipoint 'wifi' style links.

I've also added an 8021q vlan 8 on top of bat0 (ie bat0.8, tagged) and
batman-adv seems quite happy to transport this VLAN.  VM2 does NOT
have the vlan config on bat0.

I'm pretty happy with the results here, hoping I'm not missing some
obvious "In a VM you get abnormally high performance and low CPU"
situation.  Seeing >1G is great, my maximum links have 1G ports so
that's the bar.

I'm hoping to compare notes with someone before spending the cash on
the hardware to do a field test.  That platform would likely be the
PCEngines APU2 and/or soekris or other hardened x86 device with 3+
ethernet ports.
