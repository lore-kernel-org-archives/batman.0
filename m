Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 22 May 2010 18:34:26 +0800
References: <1274522445-6965-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1274522445-6965-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201005221834.26380.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Update gfp.h and slab.h
	includes to prepare for breaking implicit slab.h inclusion
	from percpu.h
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

On Saturday 22 May 2010 18:00:45 Sven Eckelmann wrote:
> From: Tejun Heo <tj@kernel.org>
> 
> percpu.h is included by sched.h and module.h and thus ends up being
> included when building most .c files.  percpu.h includes slab.h which
> in turn includes gfp.h making everything defined by the two files
> universally available and complicating inclusion dependencies.
> 
> percpu.h -> slab.h dependency is about to be removed.  Prepare for
> this change by updating users of gfp and slab facilities include those
> headers directly instead of assuming availability.  As this conversion
> needs to touch large number of source files, the following script is
> used as the basis of conversion.

Applied in rev 1677.

Thanks,
Marek
