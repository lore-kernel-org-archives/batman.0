Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 4 Jun 2013 17:23:28 +0800
References: <1369734587-13104-1-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1369734587-13104-1-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201306041723.28549.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: remove useless find_router
	look up
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
Cc: Simon Wunderlich <simon@open-mesh.com>

On Tuesday, May 28, 2013 17:49:47 Simon Wunderlich wrote:
> From: Simon Wunderlich <simon@open-mesh.com>
> 
> This is not used anymore with the new fragmentation, and it might
> actually mess up the bonding code because find_router() assumes it
> is only called once per packet.
> 
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> ---
> This patch was originally part of the RFC series
> "add network wide multi interface optimization", but since it is
> just a fix it is resent as PATCH to be applied now.
> ---
>  send.c |   29 ++++++++---------------------
>  1 file changed, 8 insertions(+), 21 deletions(-)

Applied in revision 87d4a28.

Thanks,
Marek
