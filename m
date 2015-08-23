Return-Path: <bjo@nord-west.org>
Message-ID: <1440352754.3860.9.camel@nord-west.org>
From: Bjoern Franke <bjo@nord-west.org>
Date: Sun, 23 Aug 2015 19:59:14 +0200
In-Reply-To: <78ccce3e5516b2613b09306a586f2584@hilses.de>
References: <1439848023.1458.15.camel@nord-west.org>
 <20150818080855.GD19496@medion.lan> <1439915717.1370.9.camel@nord-west.org>
 <78ccce3e5516b2613b09306a586f2584@hilses.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] Kernel crashes when using more than one
 interface in bat0
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

> We've seen these on our Goettingen Freifunk gateways, too. There,
> too, 
> batadv_frag_purge_orig was the smoking gun. However, I didn't report
> it, 
> because:
> 
> - first and foremost, we were using the outdated legacy 2013.4
> version

We had also some other issues with older versions, so we upgraded to
2015.1 hoping the gateways will run stable.

> - it was most probably an issue with RCU lists
> - and either disabling SMP or using a much more current kernel fixed
> it.

Did you build own kernels with disabled smp?

> So I blamed a buggy RCU implementation in older kernels, plus maybe
> some 
> ill behaviour in the old batman-adv codebase. The crashing kernel was
> the old debian-wheezy one - pretty old, I'd say.
> 

We are running 3.16 and partially upgraded to 4.1 for testing purposes.
But we have some "general protection fault: 0000 [#1] SMP" unrelated to
batman also on the gateways - with different hardware. For the record,
a KVM gateway (the other ones are dedicated servers without
virtualization) does not crash.

Regards
Bjoern

-- 
xmpp bjo@schafweide.org 




