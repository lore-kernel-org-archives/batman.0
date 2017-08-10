Return-Path: <linus.luessing@c0d3.blue>
Date: Thu, 10 Aug 2017 04:33:38 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20170810023338.GL27539@otheros>
References: <49206786-169d-f793-5d48-f74dc8f4e838@televic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <49206786-169d-f793-5d48-f74dc8f4e838@televic.com>
Subject: Re: [B.A.T.M.A.N.] No bandwidth over wired Batman mesh network
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

Hi,

Hm, smells like an endianess bug. And/or an MTU/fragmentation
issue as your TCP test is working in exactly one direction only.


For the broken PC1->PC2 test, can you verify with tcpdump/tshark/wireshark
or "batctl td" on eth0 that you see packets arriving on PC2? And
if so, do you see the matching, decapsulated ones arriving on bat0,
too?

What MTUs are you using on eth0 and bat0 on both PC1 and PC2?

Would be great if you could share the output of "batctl o",
"batctl nc", "batctl f" and "ip address", too.

There are no bridges or iptables/ebtables involved, right? (double
check your "iptables [-t nat] -L" output)

Does it make a difference to run the tests with batman-adv
fragmentation disabled? (The MTU of bat0 should be lowered
automatically on both sides then. Check that they have the same
MTU.)

Some messages can be found via "dmesg". Regarding extra,
more verbose debugging messages, you can build batman-adv
with CONFIG_BATMAN_ADV_DEBUG=y and then use "batctl ll" and
"batctl l".

Regards, Linus


On Wed, Aug 09, 2017 at 08:31:43AM +0200, Mattias Vanhoutte wrote:
> Hi,
> 
> 
> I am trying to use B.A.T.M.A.N. on a wired mesh network (ethx interfaces)
> version: batctl 2017.0 [batman-adv: 2017.0.1], but I got very/no bandwith
> over the BATMAN interfaces.
> 
> I have PC1 which is Intel based, 64 bit, kernel 4.9.0-3-amd64, OS is Debian,
> build batman from sources:
> 
> - eth0 10.1.98.250/24 address
> 
> - bat0 172.16.100.250/24 address
> 
> I have PC2 which is ARM based, 32 bit, kernel 4.6.0-xilinx-v2016.3, OS is
> yocto build, build batman from sources
> 
> - eth0 10.1.98.3/24 address
> 
> - bat0 172.16.100.1/24 address
> 
> PC1 and PC2 are directly connected with ethernet cable (no switch in the
> network)
> 
> I did network measurements with iperf (TCP and UDP) between PC1 and PC2 in 2
> conditions:
> 
>  - Without using batman, I got symmectric bandwidth between PC1 and PC2
> (measured TCP and UDP on ethx interface), TCP bandwidth is 300-400 Mbits/sec
>  - With using batman, I got something strange: bandwidh PC1 -> PC2 is 22
> Kbit/sec and bandwidth PC2 -> PC1 is 110 Mbit/sec (measured TCP on bat0
> interfaces)
>     Also for UDP measurements I got bandwidth=0 measured PC1 -> PC2 and 222
> Mbit/sec PC2 -> PC1
> 
> There is no firewall active on both devices.
> Does anybody has an idea why I got no bandwidth in 1 Direction? Is there
> something I should configure when I build and want to use batman on 2
> different types of operating systems / CPU?
> 
> I also did tests between 2 devices of type PC2, then I got symmetric
> bandwidths in both directions:
> 
>  - without using batman: 430 Mbits/s in both directions PC1 <> PC2
>  - with using batman: 125 Mbit/s in both directions PC1 <> PC2
> 
> So here I see a large drop of the TCP bandwidth by using batman 430 -> 125
> Mbit/s. Is this normal behavior?
> 
> Can anybody tell me where and how I can see debug messages from Batman?
> 
> 
> Kind Regards,
> 
> Mattias Vanhoutte
