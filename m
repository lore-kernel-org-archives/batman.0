Return-Path: <hwhilse@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Date: Tue, 05 Apr 2016 09:36:06 +0200
From: Hans-Werner Hilse <hwhilse@gmail.com>
In-Reply-To: <6462510.GtylGfypVS@bentobox>
References: <1459513651.4076.17.camel@gmail.com>
 <20160404231558.GG3002@otheros> <6462510.GtylGfypVS@bentobox>
Message-ID: <db225dbe7e4bba7088c521a02c99bb33@hilses.de>
Subject: Re: [B.A.T.M.A.N.] Need some help to understand the code
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

Am 2016-04-05 09:11, schrieb Sven Eckelmann:
> On Tuesday 05 April 2016 01:15:58 Linus Lüssing wrote:
>> Maybe you could set up a KVM instance and play a little with its
>> code in there? Try out lists and spinlocks etc. in there without
>> crashing the VM instance :).
> 
> There is also an easy example how to build an amd64 [1] VM image with
> many debug helpers enabled.

And my 2ct: user mode linux still exists - despite making no new 
headlines in the news - in current kernels. It might not be fit for 
developing PCI device drivers, but for networking code, it's quite nice. 
And you can just use gdb on it. It's all just a "make ARCH=um" away! You 
want 100 kernel instances communicating using batman-adv? No problem! 
Want a conditional breakpoint at some point in the code you don't yet 
have a grip on? Inspect stack when things went wrong? Just go ahead :-)

-hwh
(who actually did run 100 UML instances, using batman-adv, just for the 
fun of it - and to measure resulting "baseline" traffic)
