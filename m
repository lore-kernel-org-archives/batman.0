Return-Path: <gui@altermundi.net>
Message-ID: <557D8FFF.4070601@altermundi.net>
Date: Sun, 14 Jun 2015 11:30:23 -0300
From: Gui Iribarren <gui@altermundi.net>
MIME-Version: 1.0
References: <CALaFpeVMwOE5DtHoDWVA+CBXq2jMuKLdmU-CcOWhCNRkHQ9F5w@mail.gmail.com>
 <7101665.y6bS5x8EtZ@sven-edge>
 <CALaFpeV2DNt9a8--P+CP2_=1fhHkMWJ2+4H6dMDqYAq0scpA0g@mail.gmail.com>
In-Reply-To: <CALaFpeV2DNt9a8--P+CP2_=1fhHkMWJ2+4H6dMDqYAq0scpA0g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] batman-adv: Force line topology
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

On 13/06/15 15:15, Carlos Meralto wrote:
> Thanks for the answer Sven.
> 
> You can patch the driver to allow this (it is just a simple check which
> disallows it in most drivers... or actually in wireless core [1]). But you
> should make sure that you still use the same mac addresses for vif + bridge
> and don't end up with 4 address packets.
> 
> 
> Can you explain how I can apply this "patch”? I saw the file attached
> but i don't know what parameters must change.
> 
> There is already a way to force a topology in batman-adv?
> 
> 
> No. There were only different solutions (not acceptable for the linux kernel)
> which did this directly in batman-adv. A very prominent (and easy to find)
> solution was from Martin [2]
> 
> The idea behind batman-adv is that it finds paths and thus automatically
> creates a good virtual topologies.
> 
> 
> If you can not use ebtables I will try to use the patch that Martin did.
> 
> I'm blocked with no solution.
> 
> Thanks in advance.
> 
> 
> I don't know why you want to use wlan and you also don't explain it in your
> mail. You could for example also use emulation + vde2 [3] since you already
> try to emulate a setup which is not there in reality.
> 
> 
> The first task of my thesis is to make a comparison between
> open802.11s and batman-adv for node discovery time and througput, in
> function of hops and recovery in case of failure. So i want make this
> tests in a real scenario...

then make it a real scenario :)

the simulated line topology will not behave the same as a real-world
line topology in terms of throughput, due to interferences that will
happen in your simulated scenario, that wouldn't happen in real life

if you still want to try it, an alternative (to patching batman-adv) is
to use VLANs on top of the adhoc interfaces
so instead of adding plain adhoc0 with "batctl if"
first create some vlans over adhoc0
say, on first node, create and add adhoc0.1 to batman
then on second node, create adhoc0.1 and adhoc0.2 then add both
interfaces to batman,
on third node, adhoc0.2 and adhoc0.3... and so on
this way, the third node will have no links with the first node.
it won't help with the interference problem i mentioned above, tho.

good luck!

> 
> Thanks in advance.
> 
> Best Regards,
> Carlos Meralto
> 
