Return-Path: <davem@davemloft.net>
Date: Wed, 20 Dec 2017 14:39:46 -0500 (EST)
Message-Id: <20171220.143946.211997742797133128.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20171220110124.13117-1-sw@simonwunderlich.de>
References: <20171220110124.13117-1-sw@simonwunderlich.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 00/19] pull request for net-next:
 batman-adv 2017-12-20
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: sw@simonwunderlich.de
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 20 Dec 2017 12:01:05 +0100

> here is the updated feature/cleanup pull request of batman-adv to go
> into net-next. Compared to batman-adv 2017-12-15 pull request, we have 
> dropped the 'batman-adv: Add License-Filename to GPL-2.0 files' as per
> your suggestion.
> 
> Please pull or let me know of any problem!

Pulled, but there was a minor docbook annotation conflict I had to
address.

This pull added () to the function names in the docbook comments,
but this overlapped with the fix of a variable name in the docbook
info for the same function.

It was trivial, but please take a look.

Thanks.
