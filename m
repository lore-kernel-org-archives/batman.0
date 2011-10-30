Return-Path: <davem@davemloft.net>
Date: Sun, 30 Oct 2011 03:07:45 -0400 (EDT)
Message-Id: <20111030.030745.1245988853394270780.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1319875606-7794-1-git-send-email-lindner_marek@yahoo.de>
References: <1319875606-7794-1-git-send-email-lindner_marek@yahoo.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] pull request: batman-adv 2011-10-29
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
To: lindner_marek@yahoo.de
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, stable@kernel.org

From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 29 Oct 2011 10:06:43 +0200

>   git://git.open-mesh.org/linux-merge.git batman-adv/maint

Pulled, but long term you should shore up your datastructures to
handle that issue in patch #3.

Make a common header:

	struct tt_entry_common {
		u8 addr[ETH_ALEN];
		struct hlist_node hash_entry;
	};

Then use that at the beginning of both structures:

	struct tt_local_entry {
		struct tt_entry_common common;
		unsigned long last_seen;
		...
	};

	struct tt_global_entry {
		struct tt_entry_comomn common;
		struct orig_node *orig_node;
		...
	};

And &p->common is what gets passed into tt_response_fill_table().
