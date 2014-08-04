Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 04 Aug 2014 18:26:32 +0200
Message-ID: <5564567.83o54DtWyR@bentobox>
In-Reply-To: <1407167221-10575-2-git-send-email-antonio@meshcoding.com>
References: <1407167221-10575-1-git-send-email-antonio@meshcoding.com>
 <1407167221-10575-2-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix out-of-order
	fragmentation support
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
To: Antonio Quartulli <antonio@meshcoding.com>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net, Marek Lindner <mareklindner@neomailbox.ch>

On Monday 04 August 2014 17:47:01 Antonio Quartulli wrote:
> This problem was introduced in 9b3eab61754d74a93c9840c296013fe3b4a1b606
> ("batman-adv: Receive fragmented packets and merge").

This is not a commit id from the kernel tree but the one from your out-of-tree 
repository at http://git.open-mesh.org/batman-adv.git . 
610bfc6bc99bc83680d190ebc69359a05fc7f605 seems to be the one of Martin's 
commit when it was applied in the kernel repository.

Kind regards,
	Sven
