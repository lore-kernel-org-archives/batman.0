Return-Path: <hw@haveyouseenthiscat.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 11 Sep 2015 17:46:57 +0200
From: Hans-Werner Hilse <hw@haveyouseenthiscat.de>
In-Reply-To: <2577570.dDtkYHOgor@prime>
References: <CAGa=++S6fv_+JvpuQ_OJj7XfnF6M7xBOAJN_rQhbGYLB8nH2+A@mail.gmail.com>
 <2577570.dDtkYHOgor@prime>
Message-ID: <4506fd8b11ebc894a73df0b1a75d5e8e@hilses.de>
Subject: Re: [B.A.T.M.A.N.] Quickly setup a virtual B.A.T.M.A.N. network
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

also, I humbly point at my approach to run batman-adv in, errr, 
userland. Well, sorta. I use user mode linux (UML).

https://github.com/hwhw/usermode-batman-adv

It builds a UML kernel with a very basic userland (errr, the one inside 
the UML, that is). The kernel is targeted at providing networking 
support, batman-adv, and not really much more.

VDE networking is possible, too.

I'm currently busy with my exams, so it is slightly outdated (as in 1-2 
months behind current development), but it should work fine.

I worked on this with the aim to maybe even bring this into production 
use, as we're using KVM based servers in the first place in our 
"Freifunk" mesh project here, and isolating B.A.T.M.A.N. in a userspace 
instance has its own merits (none of that being "performance").

I sucessfully ran, I think, about 80-100 instances? As a single instance 
needs about 20-32 MByte of memory, that is the limiting factor.

-hwh

Am 2015-09-11 13:27, schrieb Simon Wunderlich:
> Hey Germano,
> 
> please check out this webpage:
> 
> https://www.open-mesh.org/projects/open-mesh/wiki/Emulation
> 
> we use this for developing stuff, too. The idea is to interconnect a 
> couple of
> KVM virtual machines running OpenWRT using vde_switch. With that, you 
> can
> easily run ~20 nodes on one PC with arbitrary topologies.
> 
> Cheers,
>     Simon
> 
> On Friday 11 September 2015 13:15:15 Germano Massullo wrote:
>> Hello, I need to setup a virtual environment with various nodes that
>> is ready for testing B.A.T.M.A.N. and Alfred. Is there anything that I
>> can use to quickly create such network?
>> I successfully created and runned Alfred and B.A.T.M.A.N. on a Fedora
>> virtual machine, but I cannot setup a real batman-adv network with
>> real nodes right now but I would still like to be able to test and
>> work on Alfred.
>> 
>> 
>> Best regards
>> Germano Massullo

