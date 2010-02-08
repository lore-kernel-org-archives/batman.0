Return-Path: <linus.luessing@web.de>
Date: Mon, 8 Feb 2010 22:32:12 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100208213212.GA9389@Sellars>
References: <20100208205602.GA9369@Sellars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20100208205602.GA9369@Sellars>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] Can't load batman-module on 2.6.26
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

And here are a couple of manual call traces :) (don't have a
device with a 2.6.26 + seriel console at the moment, hehe):

---
__run_hrtimer
hrtimer_interrupt
smp_apic_timer_interrupt
apic_timer_interrupt
strnlen
string
bat_printk
bat_printk
bat_printk
bat_printk
bat_printk
bat_printk
ktime_get_ts
ktime_get
blk_rq_map_sg
getnstimeofday
bat_printk
schedule_timer_interrupt
add_wait_queue
unix_poll
bat_printk
ext3_getblk
ext3_getblk
bat_printk
hrtimer_start
hrtick_set
do_notify_resume
bat_printk
---

Cheers, Linus

On Mon, Feb 08, 2010 at 09:56:02PM +0100, Linus Lüssing wrote:
> And next thing, batman-adv is crashing on Debian stable with a
> 2.6.26 kernel. The call trace is showing bat_printk() right after
> insmodding the batman-adv kernel module from the current
> maintenance branch.
> 
> (And also thanks to Chris/|x|, I guess you've been experiencing the
> same problem on your router with the maintenance branch.)
> 
> Cheers, Linus
> 
