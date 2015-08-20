Return-Path: <hw@haveyouseenthiscat.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 20 Aug 2015 12:08:20 +0200
From: Hans-Werner Hilse <hw@haveyouseenthiscat.de>
In-Reply-To: <1439915717.1370.9.camel@nord-west.org>
References: <1439848023.1458.15.camel@nord-west.org>
 <20150818080855.GD19496@medion.lan> <1439915717.1370.9.camel@nord-west.org>
Message-ID: <78ccce3e5516b2613b09306a586f2584@hilses.de>
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

Am 2015-08-18 18:35, schrieb Bjoern Franke:

> Thanks for the hint, it did not work on the debian machines, but I got
> the systems running with crashkernel enabled. Now we got the first
> crash:
> https://p.rrbone.net/paste/nnNHrIJI#oHfBMOs2

We've seen these on our Goettingen Freifunk gateways, too. There, too, 
batadv_frag_purge_orig was the smoking gun. However, I didn't report it, 
because:

- first and foremost, we were using the outdated legacy 2013.4 version
- it was most probably an issue with RCU lists
- and either disabling SMP or using a much more current kernel fixed it.

So I blamed a buggy RCU implementation in older kernels, plus maybe some 
ill behaviour in the old batman-adv codebase. The crashing kernel was 
the old debian-wheezy one - pretty old, I'd say.

-hwh
