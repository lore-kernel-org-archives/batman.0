Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 27 Apr 2013 13:44:46 +0800
References: <1366879046-24507-1-git-send-email-siwu@hrz.tu-chemnitz.de>
 <1366879046-24507-4-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1366879046-24507-4-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201304271344.46535.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 3/6] batman-adv: reorder packet types
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

On Thursday, April 25, 2013 16:37:23 Simon Wunderlich wrote:
> Reordering the packet type numbers allows us to handle unicast
> packets in a general way - even if we don't know the specific packet
> type, we can still forward it. There was already code handling
> this for a couple of unicast packets, and this is the more
> generalized version to do that.
> 
> Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> ---
>  main.c    |   20 +++++++++++++++-----
>  packet.h  |   34 +++++++++++++++++++++++++---------
>  routing.c |   28 ++++++++++++++++++++++++++++
>  routing.h |    2 ++
>  4 files changed, 70 insertions(+), 14 deletions(-)

Applied in revision 3bcf1e1.

Thanks,
Marek
