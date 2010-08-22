Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sun, 22 Aug 2010 22:53:19 +0200
Message-Id: <1282510400-10341-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] (no subject)
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Vasiliy Kulikov <segooon@gmail.com>


-------------
Hi Linus,

On Wed, Aug 18, 2010 at 00:10 +0200, Linus Lüssing wrote:
> Hi Vasiliy,
>
> Also first of all thanks for your little reviewing of the batman code from
> me too. I've been the person submitting the patch to enable ebtables
> filtering of batman-adv's packets.Sorry, I'm not a kernel coding veteran, so
> I might possibly have missed something ;). However, I don't fully understand
> when the skb should be leaked, so hope you don't mind some more asking from
> my side :).
>
> Okay, I had a little closer look again.NF_HOOK returns -1 in case of a drop
> due to nf_hook_slow() and 1 in case of a success due to nf_hook_slow() + the
> ok function returning 1 too. And hey, yes, nf_hook_slow() can also return 0,
> passing it all up to the NF_HOOK which would lead to the goto err_out in
> batman-adv - and both the kernel module and netfilter won't free the skb!
> However, I think I'm not quite getting when nf_hook_slow() might return 0...

The thing is that code using NF_HOOK should be written in functional
paradigm: the recv() should be divided into 2 functions, before the NF_HOOK
and after. All after-nf work should be delegated to second part, not to code in
first part that is run after NF_HOOK return. It solves the problem of asyncronous
processing in hooks. It is perferctly seen in ipv4 ip_rcv() & rp_rcv_finish().

>
> What confuses me even more is, that of course if nf_hook_slow() could return
> a value other than 1 and without freeing the skb, the batman-adv kernel
> module would have to free the skb itself in send.c, too. In send.c the
> return value of NF_HOOK is being returned there immediately without a check
> at the moment, hoping that either netfilter or dev_queue_xmit() would free
> the skb. But then net/ipv4/arp.c's arp_xmit() would have the same problem,
> too, wouldn't it? It also does not check whether the
> NF_HOOK(/nf_hook_slow()) there might return 0 either, meaning that the skb
> has not yet been consumed/freed? So is there the same bug / possible memleak
> or what is the difference between ipv4's arp.c and batman-adv's
> send.c/hard_interface.c in the usage of the NF_HOOK?

No, there isn't ;) In fact, for the caller of NF_HOOK() three cases may
happed:


1) All hooks return NF_ACCEPT or similar (NF_STOP or through
 NF_QUEUE/NF_REPEAT with the same result). In this case ok_fn() is called
 and code after return from NF_HOOK() is run.

 In case of arp dev_queue_xmit() processes the skb and free it.

 In your case ok_fn() does nothing and code after return from NF_HOOK()
 finishes the processing of skb.


2) Some hook returns NF_DROP or similar (like (1), with the same
 effect for the caller). In this case nf_hook_slow() frees skb and NF_HOOK()
 returns -1. ok_fn() is not called at all.

 Arp and batman don't leak anything as skb is freed.


3) Some hook returns NF_STOLEN signaling that now it is responsible for
 skb delivery and freeing. It can be stolen until some long
 calculations end or even some network communication is finished (e.g.
 hook wants to know whether skb dest ip is google.com)

 a) After some time the hook frees skb and doesn't call ok_fn().

   arp and you don't leak anything and work exactly like NF_HOOK() retuned
   NF_DROPPED.

 b) After some time the hook finishes calcs and passes the skb to
 ok_fn(). From this time ok_fn() is responsible for the skb.

   In arp case it is dev_queue_xmit() that frees skb.

   In batman case it does NOTHING and skb is leaked.


Also see the comment from linux/netfilter.h:

/* Activate hook; either okfn or kfree_skb called, unless a hook
  returns NF_STOLEN (in which case, it's up to the hook to deal with
  the consequences).

  Returns -ERRNO if packet dropped.  Zero means queued, stolen or
  accepted.
*/

/* RR:
  > I don't want nf_hook to return anything because people might forget
  > about async and trust the return value to mean "packet was ok".

  AK:
  Just document it clearly, then you can expect some sense from kernel
  coders :)
*/


Thanks,
Vasiliy.
