Return-Path: <mehulksharma@gmail.com>
MIME-Version: 1.0
Date: Thu, 27 Nov 2014 22:57:50 -0500
Message-ID: <CAN0ArPeabkffzSt7iRmpioFXiTxgXbjs_oU_NcqZZsaB3dooFg@mail.gmail.com>
From: Mehul Sharma <mehulksharma@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [B.A.T.M.A.N.] wired only gigabit / 10 gigabit batman-adv mesh
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Ok this is my 3rd attempt to see if this message makes it to the list
:)  .... during the attempts i have had the opportunity to understand
some aspects clearly, thanks to the nice documentation and comments in
the code.


Hi Marek,
               Thanks for the explanation. One of the aims of the
project (i.e the network part of it) is to use a mix of topologies
(wired ethernet) with out the use of external switches (eg. top of the
rack) / routers to connect machines (servers). The idea is to increase
the bandwidth, increase the link utilization, bring about multiple
paths to deal with link failures & also hop reduction to some sectors
of the cluster.

I am able to do this now with:

1) standard bridge + stp

2) standard bridge with no stp + logic to stop and forward traffic
depending on the paths  taken, hops involved and link utilization --
this is a hack on top of the ebtables and ip tables with code
monitoring across the network.

3) use layer 3 OSPF or OLSR + layer 2 on top of it using meshed TINC VPN

4) proxy arp with separate forward / reverse rules (i.e separate
routing tables / policy routing) + layer 2 tinc mesh on top of it

The bottom line I am looking for something standard & flexible.

Point 1, is standard and stable but not the flexibility i am looking
for. Eg. with stp on, it puts a link (ethx device) in blocked mode
where it detects a loop, to me this is a waste of a valid 10 gigabit
or gigabit link which will only be utilized when a fail over happens.
I would like to see more utilization of the link. So, i hacked up step
2, it would have been great if i had a majority of my time dedicated
to it to build a kind of automation logic, but otherwise it is a
manual time consuming setup. Point 3 works also but i would like to
avoid pushing layer 2 over layer 3. Point 4, also works well, but i
have to spend time convincing people that it is not arp-poisoning but
rather arp-sweetening :) and most don't get that part :) (even if i
tell them that your actual network (layer 2) will never see the
communication at layer 3 below it.

So, here i am, after years for some weird reason went back to the olsr
page to see if there were some optimizations so that i could try / use
it in place of ospf, and i came across batman-adv (it had been a while
since i had done some deep dive wireless stuff), and quite frankly i
could not believe it (i found it to have the best logic for next
generation mesh networks ... others are entitled to their feelings /
opinions). I took a look at the logic and architecture and got the
feeling it had the potential to work in many ways better on wired
ethernet than on wireless networks (due to the the wireless layer 1
link, frequency switching, CSMA and related complexities) .... i would
like to continue the feeling for the sake of positivity and intuition
:)

What i saw (which could be my assumptive beliefs) was that batman-adv:

1) Most importantly could help in link utilization -- i read about
network wide multi link optimizations [ alternating and bonding +
alternating]

2) Path fail over -- use another path if the one it is currently using
cannot be reached or another hop gets added.

3) Ease of setup -- adding the ethx devices to bat0 and adding bat0 to
the bridge where other tap devices (virtual machines) and ethernet
devices of existing wired network are present.

4) migration of non mesh clients, which might work for virtual machine
migrations as well (not sure)

5) multicast, default gateway optimizations and wired back-bone loop prevention

Yes, i understand that transmit quality (pertaining to link quality)
is one of the main things batman-adv depends on for wireless networks
(here i don't mean it might be checking quality of every link but
instead checking if it sent / received certain internal packets within
a certain time duration) , may be something of that nature for wired
networks could be obtained by looking at hops involved per interface
to reach the target and then setting penalty to that interface which
has more hops (i think batman-adv might already be doing this).

When compared with the bridge forwarding table look ups and then the
actual forwarding, batman-adv's new network wide optimizations with
maintaining separate routing table / list for separate interfaces
involved in the mesh should not be a deterrent to speed, from my
understanding the encapsulation of the ethernet frame into a
batman-adv header may be an area of slow down comparatively (but then
again this is done in kernel so speed should not be an issue
especially with server cores involved).

Just some thoughts, intuitive assumptions which may be totally wrong
:) ..... i look forward to understanding more.

Thanks & Best Regards,

Mehul


On Sun, Nov 16, 2014 at 1:08 AM, Marek Lindner
<mareklindner@neomailbox.ch> wrote:

Hi,

>                  Good Afternoon from Boston. I really love Batman-Adv ...
> brilliant layer 2 functionality.
>
> I want to use batman-adv in a wired (gigabit and 10-gigabit) only mesh and
> wanted to know your insights.

makes me happy to hear you love our project. Typically, we communicate via our
public mailing list allowing various sources to chime in at any point. Since I
don't see any reason for privacy I am cc'ing the mailing list in my answer.


> The example case scenario is as follows:
>
> 1)     4 to 6 AMD servers with 6 10-Gigabit NICs each.
>
> 2)     2 or 3 10-Gigabit NICs used for batman-adv, which are then connected
> in ring or torus topology directly (no external switch involved)
>
> 3)     the remaining interfaces on the server are connected to the LAN
> (switches, routers etc)
>
> 4)     the virtual machine (qemu-kvm) tap interfaces, the physical
> non-batman-adv ethernet and bat0 interfaces are put in a bridge (brctl), so
> now we have the ability for virtual machines, wired hosts on the lan to go
> via batman-adv and talk to each other.
>
> Is there any, down size to doing this? I see at the most 2 - 100 servers in
> one network....
>
> From what i understand:
>
> 1)  that the live migration of virtual machines (qemu-kvm) will be seen
> just as a migrating non-mesh client so my assumption is that live migration
> should work from that perspective. Also, what if the tap interfaces of the
> virtual machines are given to bat0 itself (if it might help in live
> migration / increasing throughput) ?
>
> 2) The MTU if set for 1500 or 9000 or higher (eg barman-adv reads --
> "define ETHERMTU ETH_DATA_LEN") would be taken automatically by batman-adv
> and anything below 1500 would be fragmented, which gives me the idea that
> higher MTUs would not be a problem for batman-adv to handle.
>
> 3)  There is no restriction to the number of clients in batman-adv.
>
> am i somewhat close in understanding batman-adv? .... apologies if not...
>
> Also would layer 2 forwarding by batman-adv would be close, same or better
> when compared to bridge (linux brctl) packet forwarding?
>
> I have built converged-unified distributed qemu-kvm system (all metadata
> less design, with web-interface and cli, quite the opposite of vmware and
> open-stack type centralized approaches) and was in the preliminary stage of
> looking at the possibility of integrating batman-adv into the design.
>
> Your input will be valuable for me to give server and desktop
> virtualization a mesh architecture on top of already distributed design.

I keep your description intact to allow other people to comment as well.

Before we dive into the batman-adv details I'd like to understand what
advantage batman-adv brings to the table in your scenario. The batman-adv
project aims to facilitate layer2 routing in primarily wireless setups with
dynamically changing links due to link quality changes or links being modified
in an uncontrolled fashion (community mesh network). While batman-adv also is
able to run on wired backbones this never was the main target and bears a
number of drawbacks compared to other technologies. A simple example to
picture this: The standard Linux bridge (configurable via brctl) does not run
any link layer protocol to estimate the quality of one link compared to
another. This will give you huge advantages in terms of overhead with the cost
of all links being treated equal. While this work fine on an all-wired setup
it represents an unacceptable trade-off for wireless networks.

From what I can gather you are not running wireless but high throughput wired
links. What has brought you to batman-adv ?

Cheers,
Marek
