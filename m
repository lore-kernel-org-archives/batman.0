Return-Path: <davem@davemloft.net>
Date: Sun, 31 May 2015 01:08:05 -0700 (PDT)
Message-Id: <20150531.010805.867337412648153602.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1432890328-8247-1-git-send-email-antonio@meshcoding.com>
References: <1432890328-8247-1-git-send-email-antonio@meshcoding.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] pull request: batman-adv 2015-05-29
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
Date: Fri, 29 May 2015 11:05:12 +0200

> after quite some time of silence (mostly due to me being rather busy and not
> because we did not have any active development) here you have my first batch
> intended for net-next/linux-4.1.
> 
> In this patchset you have quite some code cleanup and style fixes. A big chunk
> of the cleanup work has been performed by Markus Pargmann, followed by a couple
> of checkpatch fixes brought by Marek Lindner.
> 
> Then we have a patch by Sven Eckelmann that disables some of the features we had
> enabled by default, because not all the users having them enabled at compile
> time are aware of those.
> For example distributions like debian enables any compile-time option
> without asking the user, thus having him using all these features without his
> explicit consent with potentially unexpected behaviours. Therefore the decision
> to disable by default not-so-user-safe options.

Pulled, thanks Antonio.
