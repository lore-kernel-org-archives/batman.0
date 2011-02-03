Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 3 Feb 2011 18:02:51 +0100
References: <1296352379-1546-1-git-send-email-sven@narfation.org>
In-Reply-To: <1296352379-1546-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201102031802.52134.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Reordered rcu refcounting
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


Hi,

> I told Linus and Marek that the implementation of some datastructures using
> reference counting and RCUs must be redesigned. The problem is that
> call_rcu should only be used when the reference count is zero because
> multiple call_rcu cannot be initiated at the same time. The next problem
> is that we may try to access an element with the refcount 0 when we try to
> traverse a rcu protected list. This problem cannot be solved by kref -
> thus we have to use atomic_t again to not increase the reference count
> when it was already zero.

I reviewed the posted patches, filled in the missing parts and fixed some bugs 
along the way. Feel free to comment.

@Linus: I believe it would be a good idea if your gateway patch was based on 
this patchset.

Cheers,
Marek
