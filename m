Return-Path: <davem@davemloft.net>
Date: Tue, 17 Apr 2012 22:47:46 -0400 (EDT)
Message-Id: <20120417.224746.802445483718191876.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1334663907-22725-11-git-send-email-ordex@autistici.org>
References: <1334663907-22725-1-git-send-email-ordex@autistici.org>
	<1334663907-22725-11-git-send-email-ordex@autistici.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 10/11] batman-adv: print OGM seq numbers
 as unsigned long
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
Date: Tue, 17 Apr 2012 13:58:26 +0200

> OGM sequence numbers are declared as uint32_t and so they have to printed
> using %u instead of %d in order to avoid wrong representations.
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>

Fix this commit message subject, "%u" is "unsigned int" not
"unsigned long"

"unsigned long" would be "%lu"
