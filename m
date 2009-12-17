Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 17 Dec 2009 21:11:39 +0800
References: <1261051915-13960-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1261051915-13960-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200912172111.40169.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Use forw_bcast_list_lock
	always in disabled interrupt context
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

On Thursday 17 December 2009 20:11:55 Sven Eckelmann wrote:
> forw_bcast_list_lock is spin_locked in both process and softirq context.
> SoftIRQ calls the spinlock with disabled IRQ and normal process context
> with enabled IRQs.
> 
> When process context is inside an spin_locked area protected by
> forw_bcast_list_lock and gets interrupted by an IRQ, it could happen
> that something tries to lock forw_bcast_list_lock again in SoftIRQ
> context. It cannot proceed further since the lock is already taken
> somewhere else, but no reschedule will happen inside the SoftIRQ
> context. This leads to an complete kernel hang without any chance of
> resurrection.
> 
> All functions called in process context must disable IRQs when they try
> to get get that lock to to prevent any reschedule due to IRQs.

Thanks - nice catch (applied in rev 1504)! 

Regards,
Marek
