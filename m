Return-Path: <davem@davemloft.net>
Date: Fri, 08 Jul 2011 08:46:42 -0700 (PDT)
Message-Id: <20110708.084642.1953457077503391470.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <201107080039.05143.lindner_marek@yahoo.de>
References: <1310078023-28958-1-git-send-email-lindner_marek@yahoo.de>
	<201107080039.05143.lindner_marek@yahoo.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] pull request: batman-adv 2011-07-08
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 8 Jul 2011 00:39:04 +0200

> The following changes since commit 44c4349a2a117b22a5c4087f2ac9faf10c575e17:
> 
>   batman-adv: Replace version info instead of appending them (2011-07-05 14:48:56 +0200)
> 
> are available in the git repository at:
>   git://git.open-mesh.org/linux-merge.git batman-adv/next
> 
> Antonio Quartulli (4):
>       batman-adv: initialise last_ttvn and tt_crc for the orig_node structure
>       batman-adv: keep local table consistency for further TT_RESPONSE
>       batman-adv: keep global table consistency in case of roaming
>       batman-adv: request the full table if tt_crc doesn't match

Pulled.

You may want to make the tt_response_fill_table() callback return
'bool' if it's just returning what amounts to true/false values.
