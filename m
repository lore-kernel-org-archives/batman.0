Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 19 Jan 2011 21:07:01 +0100
References: <201012130118.14949.lindner_marek@yahoo.de>
In-Reply-To: <201012130118.14949.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201101192107.02433.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] performance patches (v3)
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

On Monday 13 December 2010 01:18:14 Marek Lindner wrote:
> the performance patches progress step by step. A few patches already went
> into  the repository the rest is waiting for more review. Thanks to Sven's
> feedback quite some bugs were squashed.
> 
> Changes since v2:
> * code rebased on top of the trunk
> * some more neigh_node protected by reference counters
> * call_rcu and kref_put race condition fixed
> 
> Known issues:
> * bonding / alternating candidates are not secured by refcounting [see  
> find_router()] - ideas welcome

Thanks to the bonding / alternating patch I was able to commit the remaining 
patches that replace the orig_hash spinlock with more advanced locking 
techniques (revision 1904 - 1909).

Regards,
Marek
