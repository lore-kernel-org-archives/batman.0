Return-Path: <davem@davemloft.net>
Date: Mon, 25 Jun 2012 16:19:33 -0700 (PDT)
Message-Id: <20120625.161933.730861831753419928.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1340607284-29950-1-git-send-email-ordex@autistici.org>
References: <1340607284-29950-1-git-send-email-ordex@autistici.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] pull request: batman-adv 2012-06-25
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
To: ordex@autistici.org
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 25 Jun 2012 08:54:24 +0200

> this is another set of changes intended for net-next/linux-3.6.
> 
> This patchset is entirely composed by "namespace renaming" patches.
> 
> Please, let me know if there is any problem.

Pulled, but you really, _REALLY_, should have let me pull 'net'
into 'net-next' to resolve the conflicts in translation-table.c
before sending this work to me.

I did that merge before getting to this pull request and did my
best merging things together.

But I know I made mistakes, so please send me whatever fixups
are necessary.

Thanks.
