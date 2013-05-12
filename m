Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 12 May 2013 15:56:06 +0800
References: <1367997686-12331-1-git-send-email-sven@narfation.org>
 <1367997686-12331-2-git-send-email-sven@narfation.org>
In-Reply-To: <1367997686-12331-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201305121556.06749.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [Bonus-PATCH 11/9] batman-adv-devel: Remove
	unused parameters from MAKE_BATCTL_ARGS
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
Cc: Sven Eckelmann <sven@narfation.org>

On Wednesday, May 08, 2013 15:21:26 Sven Eckelmann wrote:
> The NODEBUG, UNAME and STRIP parameter aren't used in batctl's Makefile.
> Removing them should be safe.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  batman-adv-devel/Makefile | 3 ---
>  1 file changed, 3 deletions(-)

Applied in revision ffa6898.

Thanks,
Marek
