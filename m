Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 15 Nov 2012 00:37:40 +0800
References: <1352886828-24651-1-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1352886828-24651-1-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201211150037.40973.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: pass value in batadv_hash_bytes
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

On Wednesday, November 14, 2012 17:53:48 Simon Wunderlich wrote:
> Passing the hash value by reference creates unneeded overhead. Pass by
> value instead.
> 
> Reported-by: David Miller <davem@davemloft.net>
> Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> ---
>  bridge_loop_avoidance.c |    8 ++++----
>  hash.h                  |   12 ++++++++----
>  2 files changed, 12 insertions(+), 8 deletions(-)

Applied in revision 803bae0.

Thanks,
Marek
