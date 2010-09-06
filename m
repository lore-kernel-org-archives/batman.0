Return-Path: <linus.luessing@web.de>
Date: Mon, 6 Sep 2010 12:09:13 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100906100913.GA13044@Sellars>
References: <1283729393-13842-1-git-send-email-linus.luessing@web.de>
	<20100906073046.GA6973@sven-atom.lazhur.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20100906073046.GA6973@sven-atom.lazhur.ath.cx>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Always synchronize rcu's on
 module shutdown
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi Sven,

synchronize_net already contains a synchronize_rcu at its end, so
the synchronize_rcu in the batman code there has always been
redundant.

I've removed the synchronize_rcu instead of the synchronize_net to
be on the safe side. I guess usually no more packets should arrive
anyway as the batman packet type is not registered anymore. But I
wasn't sure if the might_sleep() of synchronize_net() might be
needed for something, so I didn't dare to remove synchronize_net.

If someone says it'd be ok to remove synchronize_net() instead,
I could make a new patch, no problem.

Cheers, Linus

On Mon, Sep 06, 2010 at 09:30:46AM +0200, Sven Eckelmann wrote:
> On Mon, Sep 06, 2010 at 01:29:53AM +0200, Linus Lüssing wrote:
> > During the module shutdown procedure in batman_exit(), a rcu callback is
> > being scheduled (batman_exit -> hardif_remove_interfaces ->
> > hardif_remove_interfae -> call_rcu). However, when the kernel unloads
> > the module, the rcu callback might not have been executed yet, resulting
> > in a "unable to handle kernel paging request" in __rcu_process_callback
> > afterwards, causing the kernel to freeze.
> > Therefore, we should always flush all rcu callback functions scheduled
> > during the shutdown procedure.
> 
> I am really irritated by your patch. I would have expected that you add a
> synchronyze_rcu in batman_exit and that was it. Instead I see a synchronize_net
> added and a synchronize_net/-_rcu removed from mesh_free. This doesn't seem to
> match at all. Could you please explain further why it is implemented that way?
> 
> thanks,
> 	Sven


