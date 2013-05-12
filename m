Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 12 May 2013 15:53:29 +0800
References: <1367997686-12331-1-git-send-email-sven@narfation.org>
In-Reply-To: <1367997686-12331-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201305121553.30034.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [Bonus-PATCH 10/9] batman-adv-devel: Don't
	overwrite batctl's CFLAGS
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

On Wednesday, May 08, 2013 15:21:25 Sven Eckelmann wrote:
> The batctl makefile has CFLAGS which change the behavior of the compiler.
> This includes important things like the C-dialect used or whether the
> compiler can ignore aliasing problems during the optimization step.
> 
> The OpenWRT build environment should not overwrite these settings without a
> good reason. Most of these reasons can probably directly be fixed upstream.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  batman-adv-devel/Makefile | 3 ---
>  1 file changed, 3 deletions(-)

Applied in revision 110ca73.

Thanks,
Marek
