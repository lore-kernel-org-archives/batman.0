Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 1 Jul 2010 17:33:47 +0200
References: <1277920995-25503-1-git-send-email-linus.luessing@web.de>
	<1277936963-29179-2-git-send-email-linus.luessing@web.de>
In-Reply-To: <1277936963-29179-2-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201007011733.48472.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: Add timeout filtering option for
	originators
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Thursday 01 July 2010 00:29:22 Linus L=C3=BCssing wrote:
>  batctl/debug.c     |   23 ++++++++++++++++++++---
>  batctl/functions.c |    9 ++++++++-
>  batctl/functions.d |   40 ++++++++++++++++++++++++++++++++++++++++
>  batctl/functions.h |    3 ++-
>  batctl/sys.c       |    8 ++++----
>  5 files changed, 74 insertions(+), 9 deletions(-)
>  create mode 100644 batctl/functions.d

The float variant looks much better!
Would you mind sending this patch again without functions.d ?
How about mentioning this feature in the man page ?

Cheers,
Marek
