Return-Path: <davem@davemloft.net>
Date: Fri, 30 May 2014 16:47:57 -0700 (PDT)
Message-Id: <20140530.164757.984109840722396912.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1401157547-25199-1-git-send-email-antonio@meshcoding.com>
References: <1401157547-25199-1-git-send-email-antonio@meshcoding.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] pull request net: batman-adv 20140527
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: antonio@meshcoding.com
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 27 May 2014 04:25:46 +0200

> Hello David,
> 
> here you have another very small fix intended for net/linux-3.15.
> It prevents some multicast functions from dereferencing a NULL pointer.
> (Actually it was nothing more than a typ0)
> I hope it is not too late for such a small patch.
> 
> 
> Please pull or let me know of any problem
 ...
> are available in the git repository at:
> 
>   git://git.open-mesh.org/linux-merge.git 

This doesn't work:

[davem@dokdo net]$ git pull git://git.open-mesh.org/linux-merge.git 
remote: Counting objects: 10335, done.        
remote: Compressing objects: 100% (2687/2687), done.        
remote: Total 9894 (delta 7726), reused 9123 (delta 7189)        
Receiving objects: 100% (9894/9894), 1.98 MiB | 399 KiB/s, done.
Resolving deltas: 100% (7726/7726), completed with 236 local objects.
From git://git.open-mesh.org/linux-merge
 * branch            HEAD       -> FETCH_HEAD
Auto-merging net/batman-adv/types.h
Auto-merging net/batman-adv/translation-table.c
CONFLICT (content): Merge conflict in net/batman-adv/translation-table.c
Auto-merging net/batman-adv/sysfs.c
Auto-merging net/batman-adv/soft-interface.c
Auto-merging net/batman-adv/send.c
CONFLICT (content): Merge conflict in net/batman-adv/send.c
Auto-merging net/batman-adv/network-coding.c
Auto-merging net/batman-adv/multicast.c
CONFLICT (add/add): Merge conflict in net/batman-adv/multicast.c
Auto-merging net/batman-adv/main.h
CONFLICT (content): Merge conflict in net/batman-adv/main.h
Auto-merging net/batman-adv/distributed-arp-table.c
warning: inexact rename detection was skipped due to too many files.
warning: you may want to set your merge.renamelimit variable to at least 1268 and retry the command.
Automatic merge failed; fix conflicts and then commit the result.

You seem to have a bunch of unrelated things in this tree.
