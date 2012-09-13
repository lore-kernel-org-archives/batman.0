Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 13 Sep 2012 19:13:15 +0800
References: <201209092051.09078.lindner_marek@yahoo.de>
 <1347222477-24144-1-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1347222477-24144-1-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201209131913.16430.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 2/2] batman-adv: allow bla traffic only
	after first worker period
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

On Monday, September 10, 2012 04:27:57 Simon Wunderlich wrote:
> When adding a backbone gateway for the first time, it might not yet
> be known in the backbone, and therefore we should not forward
> broadcasts yet. This behaviour is the same as when sending a request
> to another backbone gw because of a CRC mismatch. The backbone gw
> will operate normal after the next periodic bla work.
> 
> Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> ---
>  bridge_loop_avoidance.c |   20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)

Applied in revision e344097.

Thanks,
Marek
