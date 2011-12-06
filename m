Return-Path: <onelektra@gmx.net>
From: elektra <onelektra@gmx.net>
Date: Tue, 6 Dec 2011 20:53:53 +0100
References: <1323197832-1791-1-git-send-email-sven@narfation.org>
In-Reply-To: <1323197832-1791-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201112062053.53909.onelektra@gmx.net>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batmand: Don't override CPPFLAGS set by
	user
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


> Users or build servers may want to enable preprocessor specific options
>  like -D_FORTIFY_SOURCE=2 that are usually placed in CPPFLAGS. The batmand
>  makefile should not override these options to add own preprocessor
>  variables.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Applied in 9cd7382.

Thanks!

Cheers,
Elektra
