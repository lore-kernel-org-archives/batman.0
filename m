Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 8 May 2013 13:04:15 +0800
References: <1367931069-7177-1-git-send-email-sven@narfation.org>
 <1367931069-7177-3-git-send-email-sven@narfation.org>
In-Reply-To: <1367931069-7177-3-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201305081304.15303.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/9] batctl: Add CFLAGS to the linker step
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

On Tuesday, May 07, 2013 20:51:02 Sven Eckelmann wrote:
> The GCC manual states for different parameters that the options for
> compilation must also be used when linking. The options for compilation
> are stored in CFLAGS and added to LINK.o to fix the behavior.
> 
> Option which need this are for example -fPIC/-fPIE or -flto.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  Makefile | 2 +-

Applied in revision b80d07f.

Thanks,
Marek
