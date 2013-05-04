Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 4 May 2013 18:37:10 +0800
References: <1367416439-11487-1-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1367416439-11487-1-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201305041837.10817.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: remove vis support
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

On Wednesday, May 01, 2013 21:53:59 Simon Wunderlich wrote:
> As the kernel module will not have support for this feature, we can also
> drop support from batctl. Keep the old parameter to point current users
> to alfred.
> 
> Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> ---
>  Makefile     |    2 +-
>  README       |   93 -----------------
>  debug.c      |   26 +++++
>  debug.h      |    2 +-
>  main.c       |    4 +-
>  man/batctl.8 |   12 ---
>  sys.c        |    6 --
>  sys.h        |    1 -
>  vis.c        |  314
> ----------------------------------------------------------
> vis.h        |   23 -----
>  10 files changed, 29 insertions(+), 454 deletions(-)
>  delete mode 100644 vis.c
>  delete mode 100644 vis.h

Applied in revision bdddaea.

Thanks,
Marek
