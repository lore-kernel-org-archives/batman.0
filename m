Return-Path: <SRS0=AXjO=YA=goodmis.org=rostedt@kernel.org>
Date: Mon, 7 Oct 2019 09:34:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: KCSAN: data-race in find_next_bit / rcu_report_exp_cpu_mult
Message-ID: <20191007093453.2d9852ce@gandalf.local.home>
In-Reply-To: <CANpmjNNmSOagbTpffHr4=Yedckx9Rm2NuGqC9UqE+AOz5f1-ZQ@mail.gmail.com>
References: <000000000000604e8905944f211f@google.com>
 <CANpmjNNmSOagbTpffHr4=Yedckx9Rm2NuGqC9UqE+AOz5f1-ZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Marco Elver <elver@google.com>
Cc: syzbot <syzbot+134336b86f728d6e55a0@syzkaller.appspotmail.com>, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org, a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net, LKML <linux-kernel@vger.kernel.org>, mareklindner@neomailbox.ch, netdev@vger.kernel.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com

On Mon, 7 Oct 2019 12:04:16 +0200
Marco Elver <elver@google.com> wrote:

> +RCU maintainers
> This might be a data-race in RCU itself.
> 
> >
> > write to 0xffffffff85a7f140 of 8 bytes by task 7 on cpu 0:
> >   rcu_report_exp_cpu_mult+0x4f/0xa0 kernel/rcu/tree_exp.h:244

Here we have:

	raw_spin_lock_irqsave_rcu_node(rnp, flags);
	if (!(rnp->expmask & mask)) {
		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
		return;
	}
	rnp->expmask &= ~mask;
	__rcu_report_exp_rnp(rnp, wake, flags); /* Releases rnp->lock. */

> >
> > read to 0xffffffff85a7f140 of 8 bytes by task 7251 on cpu 1:
> >   _find_next_bit lib/find_bit.c:39 [inline]
> >   find_next_bit+0x57/0xe0 lib/find_bit.c:70
> >   sync_rcu_exp_select_node_cpus+0x28e/0x510 kernel/rcu/tree_exp.h:375

and here we have:


	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);

	/* IPI the remaining CPUs for expedited quiescent state. */
	for_each_leaf_node_cpu_mask(rnp, cpu, rnp->expmask) {


The write to rnp->expmask is done under the rnp->lock, but on the read
side, that lock is released before the for loop. Should we have
something like:

	unsigned long expmask;
	[...]

	expmask = rnp->expmask;
	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);

	/* IPI the remaining CPUs for expedited quiescent state. */
	for_each_leaf_node_cpu_mask(rnp, cpu, expmask) {

?

-- Steve
