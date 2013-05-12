Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 12 May 2013 16:21:06 +0800
References: <1367931069-7177-1-git-send-email-sven@narfation.org>
 <1367931069-7177-10-git-send-email-sven@narfation.org>
In-Reply-To: <1367931069-7177-10-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201305121621.06970.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 5/9] batman-adv-devel: Enable Link-time
	optimization
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

On Tuesday, May 07, 2013 20:51:09 Sven Eckelmann wrote:
> Link-time optimization allows to move parts of the optimization from the
> single source file to the global source view. This is done by emitting the
> GIMPLE representation in each object file and analyzing it again during
> the link step.
> 
> This reduces the binary size by around 6% on mipsel (this includes parts
> which were also removed by garbage collection).
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  batman-adv-devel/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied in revision e25de79.

Thanks,
Marek
