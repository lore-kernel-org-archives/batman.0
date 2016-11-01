Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 1 Nov 2016 01:46:19 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20161101004619.GC3264@otheros>
References: <1637163.TC9CcXIrIP@sven-edge>
 <20161031073629.31819-4-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161031073629.31819-4-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 4/6] batman-adv: Revert "compat: Move
 netlink const compat to coccinelle"
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

On Mon, Oct 31, 2016 at 08:36:27AM +0100, Sven Eckelmann wrote:
> The coccinelle in Debian Jessie seems to be broken. It fails to parse
> the patches and thus makes it impossible to use the out-of-tree
> module in these systems. Therefore drop it for now.
> 
> This reverts commit 2f9f52d1dfc417201028cc65f91aaddc5eaf493a.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  Makefile                             |  3 ++-
>  compat-patches/0002-genl-const.INFO  | 15 ---------------
>  compat-patches/0002-genl-const.cocci | 10 ----------
>  compat-patches/replacements.sh       |  9 +++++++++
>  4 files changed, 11 insertions(+), 26 deletions(-)
>  delete mode 100644 compat-patches/0002-genl-const.INFO
>  delete mode 100644 compat-patches/0002-genl-const.cocci
>  create mode 100755 compat-patches/replacements.sh
> 

684d4cad930d97902 ("batman-adv: Remove replacement compat script")
needs to be reverted first before this patch applies cleanly,
doesn't it?
