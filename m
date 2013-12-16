Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 16 Dec 2013 16:10:55 +0100
References: <52AB5A13.2050709@altermundi.net>
In-Reply-To: <52AB5A13.2050709@altermundi.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201312161610.55548.sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] alfred: fix batadv-vis invocation in
	init.d script
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
To: b.a.t.m.a.n@lists.open-mesh.org

> broken (wouldn't start, failing silently) since the following commit:
>  * "renamed vis to batadv-vis to avoid collisions with other vis binaries"
> which renamed only some instances of the "vis" command
> 
> Signed-off-by: Gui Iribarren <gui@altermundi.net>
Thanks Guido!

I've applied your patches, resvision 0a7457d and aee1e4f in openwrt-feed-
alfred.git and revisions 47a466e and e2cfab7 in git@github.com:openwrt-
routing/packages.git.

Thanks, 
    Simon
