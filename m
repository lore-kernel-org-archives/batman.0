Return-Path: <xiyuyang19@fudan.edu.cn>
Date: Wed, 15 Apr 2020 19:03:30 +0800
From: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Subject: Re: [PATCH] batman-adv: Fix refcnt leak in
 batadv_show_throughput_override
Message-ID: <20200415110330.GA71449@sherlly>
References: <1586939510-69461-1-git-send-email-xiyuyang19@fudan.edu.cn>
 <28340414.QPzbqP6r4N@bentobox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28340414.QPzbqP6r4N@bentobox>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, yuanxzhang@fudan.edu.cn, kjlu@umn.edu, Xin Tan <tanxin.ctf@gmail.com>

On Wed, Apr 15, 2020 at 11:04:02AM +0200, Sven Eckelmann wrote:
> On Wednesday, 15 April 2020 10:31:50 CEST Xiyu Yang wrote:
> [...]
> > Fix this issue by calling batadv_hardif_put() before the
> [...]
> 
> Thanks, fixes for batadv_store_throughput_override [1] and 
> batadv_show_throughput_override [2] were applied. I've also added the missing 
> Fixes: line to both patches.
> 
> May I ask whether you are still a user of the deprecated sysfs interface or 
> did you find this in an automated fashion?
> 
> Thanks,
> 	Sven
> 
> [1] https://git.open-mesh.org/linux-merge.git/commit/cd339d8b14cd895d8333d94d832b05f67f00eefc
> [2] https://git.open-mesh.org/linux-merge.git/commit/3d3e548f74fe51aee9a3c9e297518a2655dbc642

Thanks for your confirmation! We are looking for some automated ways to find this kind of bug.

