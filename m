Return-Path: <andrew@lunn.ch>
Date: Fri, 29 Jan 2016 04:01:40 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20160129030140.GD12692@lunn.ch>
References: <1453953259-30022-1-git-send-email-andrew@lunn.ch>
 <20160128040638.GE22112@prodigo.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160128040638.GE22112@prodigo.lan>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: Add support for network
	namespaces
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <a@unstable.cc>
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Thu, Jan 28, 2016 at 12:06:38PM +0800, Antonio Quartulli wrote:
> On Thu, Jan 28, 2016 at 04:54:19AM +0100, Andrew Lunn wrote:
> > When running within a network namespace, access to files within
> > debugfs have to take into account the network name space. Each
> > namespace has its own directory under
> > /sys/kernel/debug/batman_adv/netns.
> 
> Thanks for providing the batctl patch Andrew.
> 
> What do you think about documenting this feature in the README file as well?
> Imho a few words in the "How does it work?" section plus an example on how to
> use it would be really nice!

Yes, i can do that. Here is a little example for three nodes which i
used for testing.

     Andrew

EMU1="ip netns exec emu1"
EMU2="ip netns exec emu2"

ip netns add emu1
ip netns add emu2

ip link add emu1-veth1 type veth peer name emu2-veth1
ip link set emu1-veth1 netns emu1
ip link set emu2-veth1 netns emu2

$EMU1 ip link set emu1-veth1 name veth1
$EMU2 ip link set emu2-veth1 name veth1

$EMU1 ip link set veth1 up
$EMU2 ip link set veth1 up

ip link add emu1-veth2 type veth peer name veth2
ip link set emu1-veth2 netns emu1
$EMU1 ip link set emu1-veth2 name veth2

$EMU1 ip link set veth2 up
ip link set veth2 up

$EMU1 batctl if add veth1
$EMU1 batctl if add veth2
$EMU1 ip link set bat0 up

$EMU2 batctl if add veth1
$EMU2 ip link set bat0 up

batctl if add veth2
ip link set bat0 up

# Give DAD time to complete
echo Waiting for DAD
sleep 4

($EMU1 alfred -m -i bat0 -u /var/run/emu1-alfred.soc) &
($EMU2 alfred -m -i bat0 -u /var/run/emu2-alfred.soc) &
alfred -m -i bat0 &

sleep 1

($EMU1 batadv-vis -s -u /var/run/emu1-alfred.soc) &
($EMU2 batadv-vis -s -u /var/run/emu2-alfred.soc) &
batadv-vis -s &
