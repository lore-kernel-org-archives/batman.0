Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 29 Sep 2010 13:44:24 +0200
References: <201009262057.36382.lindner_marek@yahoo.de>
	<1285527477-10340-1-git-send-email-lindner_marek@yahoo.de>
	<201009282323.07115.sven.eckelmann@gmx.de>
In-Reply-To: <201009282323.07115.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201009291344.24774.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: softif lan loop avoidance
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

On Tuesday 28 September 2010 23:23:03 Sven Eckelmann wrote:
> Do you want to change the other _hold and _put functions to make it
> consistent in batman-adv regarding the NULL pointer checks?

Yes, I will send patches for that.


> You must protect the whole loop and not only the hlist_del_rcu with the
> bat_priv->softif_neigh_lock, And it must be with spin_lock_irqsave because
> you use it in context were irq is disabled and in some with enabled irq
> contexts... or am I wrong?

No, you are right - I will add the irq locks.


> Can you mark that function as static?

Done.

Thanks for your review,
Marek
