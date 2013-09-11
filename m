Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 11 Sep 2013 18:53:56 +0800
Message-ID: <22609254.lRWkHh0nWU@diderot>
In-Reply-To: <1378847522-13776-3-git-send-email-sven@narfation.org>
References: <1378847522-13776-1-git-send-email-sven@narfation.org>
 <1378847522-13776-3-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [B.A.T.M.A.N.] [PATCH 02/11] batctl: Fix inconsistent use of
	_GNU_SOURCE
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

On Tuesday, September 10, 2013 11:11:53 PM Sven Eckelmann wrote:
> Either all or no source file should define _GNU_SOURCE to avoid incompatible
> types or function declarations.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  Makefile    | 1 +
>  bat-hosts.c | 1 -
>  functions.c | 1 -
>  3 files changed, 1 insertion(+), 2 deletions(-)

Applied in revision db34e02.

Thanks,
Marek

