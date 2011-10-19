Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 19 Oct 2011 14:08:59 +0200
References: <1319014945-32281-1-git-send-email-siwu@hrz.tu-chemnitz.de>
	<201110191120.48103.lindner_marek@yahoo.de>
In-Reply-To: <201110191120.48103.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201110191408.59847.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: remove references for global
	tt entries
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

On Wednesday, October 19, 2011 11:20:47 Marek Lindner wrote:
> > -void free_rcu_tt_global_entry(struct rcu_head *rcu)
> > -{
> > -       struct tt_global_entry *tt_global_entry;
> > -
> > -       tt_global_entry = container_of(rcu, struct tt_global_entry, rcu);
> > -       kfree(tt_global_entry);
> > -}
> 
> If you remove the function from compat.c please also remove its declaration
> in  compat.h.

My fault - the compat.h cleanup is there.
Next time I'll read the patch 3 times before commenting.  ;-)

Regards,
Marek
