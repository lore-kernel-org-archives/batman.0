Return-Path: <linus.luessing@web.de>
Date: Sat, 12 Feb 2011 22:23:02 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20110212212301.GA26450@Sellars>
References: <201102031802.52134.lindner_marek@yahoo.de>
	<1296832896-30081-3-git-send-email-linus.luessing@ascom.ch>
	<20110210124544.GC13038@Sellars>
	<201102101457.57316.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201102101457.57316.lindner_marek@yahoo.de>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/7] batman-adv: Correct rcu refcounting
 for softif_neigh
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

> > There's a race condition in softif_neigh_seq_print_text(), between
> > the rcu_read_unlock() and rcu_read_lock() the number of
> > softif_neigh's can have increased and there's no check for
> > accidentally writing outside of the allocated buffer.
> 
> Also correct - are you going to send a patch ?
Yes, will do, wait a sec.
