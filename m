Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 2 Sep 2012 16:32:46 +0800
References: <1345885079-23652-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1345885079-23652-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201209021632.47039.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 1/2] batctl: rename bisect to bisect_iv
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Saturday, August 25, 2012 16:57:58 Marek Lindner wrote:
> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> ---
>  Makefile     |    2 +-
>  README       |   34 +-
>  bisect.c     | 1596
> ----------------------------------------------------------
> bisect.h     |   97 ----
>  bisect_iv.c  | 1596
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> bisect_iv.h  |   97 ++++
>  main.c       |   10 +-
>  man/batctl.8 |   14 +-
>  8 files changed, 1722 insertions(+), 1724 deletions(-)
>  delete mode 100644 bisect.c
>  delete mode 100644 bisect.h
>  create mode 100644 bisect_iv.c
>  create mode 100644 bisect_iv.h

Applied in revision ac02d8a.

Regards,
Marek
