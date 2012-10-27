Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 27 Oct 2012 21:35:05 +0800
References: <1350505737-32105-1-git-send-email-siwu@hrz.tu-chemnitz.de>
 <1350560862-2155-1-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1350560862-2155-1-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201210272135.06160.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv4] batman-adv: Fix broadcast duplist for
	fragmentation
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
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

On Thursday, October 18, 2012 19:47:42 Simon Wunderlich wrote:
> If the skb is fragmented, the checksum must be computed on the
> individual fragments, just using skb->data may fail on fragmented
> data. Instead of doing linearizing the packet, use the new
> batadv_crc32 to do that more efficiently- it should not hurt
> replacing the old crc16 by the new crc32.
> 
> Reported-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> ---
> PATCHv2: change uint32_t to __be32
> PATCHv3: this time also changed in types.h
> PATCHv4: also compile if bla is disabled
> ---
>  bridge_loop_avoidance.c |   18 +++++++-----------
>  bridge_loop_avoidance.h |    6 ++----
>  routing.c               |   10 +++-------
>  types.h                 |    2 +-
>  4 files changed, 13 insertions(+), 23 deletions(-)

Applied in revision da14489.

Thanks,
Marek
