Return-Path: <srn@coolheads.com>
Reply-To: srn@coolheads.com
From: Steve Newcomb <srn@coolheads.com>
Subject: can't find logged information
Message-ID: <501bc34b-2c77-a12a-6cb0-c49903eb420b@coolheads.com>
Date: Fri, 7 Feb 2020 09:13:47 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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

Here in upstate New York, USA, I'm having difficulty with 2 meshes, each 
with 4 nodes, both meshes running BATMAN_IV. All nodes are TP-Link 
Archer C7 or A7 routers running the latest OpenWRT trunk. All nodes are 
stationary.  The radio environment is pretty quiet, I think.  There is 
only one gateway in each mesh.  Nothing ever changes.  (A map of the 
layout can be found at rosepark dot us hash map.)

Nevertheless, each mesh stops working at least once or twice per day.  
If I reboot the gateway node of the one that stops working, the mesh 
starts working again.  In order to keep the meshes running, sort of, 
they now run a script I wrote that reboots them when they stop being 
able to ping each other.  It is not a very satisfactory solution.  If I 
could see what's going on, I might see how to make the meshes more 
stable, but I can't find any debug messages.

I compiled batctl-full and the kernel module with all options, including 
all debug options.  Here's a portion of a "make menuconfig" screen:

<*> kmod-batman-adv......................................... 
B.A.T.M.A.N. Adv
[*]   B.A.T.M.A.N. V protocol
[*]   Bridge Loop Avoidance
[*]   Distributed ARP Table
[*]   Network Coding
[*]   Multicast optimisation
[*]   batman-adv debugfs entries
[*]   B.A.T.M.A.N. debugging
[*]   batman-adv sysfs entries
[*]   B.A.T.M.A.N. tracing support


I run "batctl ll all" followed by "batctl ll" and I see:

@rpc152:/tmp/log# batctl ll
[ ] all debug output disabled (none)
[x] messages related to routing / flooding / broadcasting (batman)
[x] messages related to route added / changed / deleted (routes)
[x] messages related to translation table operations (tt)
[x] messages related to bridge loop avoidance (bla)
[x] messages related to arp snooping and distributed arp table (dat)
[x] messages related to network coding (nc)
[x] messages related to multicast (mcast)
[x] messages related to throughput meter (tp)

But the only debug-related log messages I see are:

@rpc152:/tmp/log# echo "$(dmesg)" | grep batman
[   18.672978] batman_adv: B.A.T.M.A.N. advanced 2019.5-openwrt-0 
(compatibility version 15) loaded
[   42.067698] batman_adv: bat0: Adding interface: mesh0
[   42.073065] batman_adv: bat0: The MTU of interface mesh0 is too small 
(1500) to handle the transport of batman-adv packets. Packets going over 
this interface will be fragmented on layer2 which could impact the 
performance. Setting the MTU to 1560 would \
solve the problem.
[   42.098069] batman_adv: bat0: Interface activated: mesh0
[174193.938445] batman_adv: [Deprecated]: batctl (pid 22747) Use of 
debugfs file "nc_nodes".


@rpc152:/tmp/log# echo "$(logread)" | grep batman
Thu Feb  6 15:21:13 2020 kern.warn kernel: [174193.938445] batman_adv: 
[Deprecated]: batctl (pid 22747) Use of debugfs file "nc_nodes".
@rpc152:/tmp/log#


What have I missed?

Thanks.

Steve Newcomb
