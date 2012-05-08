Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 8 May 2012 13:59:26 +0800
References: <4FA823EB.7070309@universe-factory.net>
In-Reply-To: <4FA823EB.7070309@universe-factory.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201205081359.26707.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] The current state of the batman-adv vis code
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

On Tuesday, May 08, 2012 03:35:07 Matthias Schiffer wrote:
> It should be possible to get rid of the vis_hash_lock altogether, as the
> hash table has spinlocks for the hash lists itself;

Yes, the hash implementation was converted to use fine-grained locking instead 
of one big spinlock as was the rest of the code except for vis.


> overall hash consistency might be a issue though - I would propose adding a
> hash_update function that updates a hash entry without deleting and
> re-adding the hlist node.

Can you give an example of such an "update" ? Where would we need it ?


> I think I found a bug in the hash_add function though. First there is a
> RCU-locked loop that checks if a entry does already exist, but the
> spinlock is taken after the rcu_read_unlock() - thus allowing the same
> entry to be appended twice if two threads try to add it at the same time.

You are right - you found a bug.  :)

Regards,
Marek
