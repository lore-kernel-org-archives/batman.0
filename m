Return-Path: <davem@davemloft.net>
Date: Fri, 15 Dec 2017 11:08:14 -0500 (EST)
Message-Id: <20171215.110814.964778107754316141.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20171215114320.13645-4-sw@simonwunderlich.de>
References: <20171215114320.13645-1-sw@simonwunderlich.de>
 <20171215114320.13645-4-sw@simonwunderlich.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 03/20] batman-adv: Add License-Filename
 to GPL-2.0 files
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org

From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 15 Dec 2017 12:43:03 +0100

> The FSFE REUSE practices [1] recommend to add a "License-Filename" tag to
> files which don't contain the complete license text. The GPL-2.0 files
> usually only have a small notice at the beginning of the file. The longer
> license is usually stored in a separate file and therefore should be
> referenced accordingly.

Nothing else in entire kernel tree uses this.

I strongly discourage you from doing something at this level that is
not in accordance with some kind of precendence or official
recommendation for the rest of the kernel project.

If you want this to start happening, discuss it on a global scale
on lkml.

I'm definitely not pulling this tree with these changes in it.

Sorrry.
