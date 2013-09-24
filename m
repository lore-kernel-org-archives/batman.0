Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 24 Sep 2013 20:36:47 +0800
Message-ID: <3258645.grhyDvuPSX@diderot>
In-Reply-To: <1379872942-2803-1-git-send-email-antonio@meshcoding.com>
References: <1379872942-2803-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [B.A.T.M.A.N.] [PATCH next] batman-adv: make gw_init() return
	void
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

On Sunday 22 September 2013 20:02:22 Antonio Quartulli wrote:
> gw_init does not return anything other than 0
> (despite the kernel doc says something different..).
> Change it to void and fix the kernel doc.
> 
> Introduced-by 0853ec7fafe0a195754454832993c6b35e22b842
> ("batman-adv: tvlv - gateway download/upload bandwidth container")
> 
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
>  gateway_common.c | 5 +----
>  gateway_common.h | 2 +-
>  main.c           | 4 +---
>  3 files changed, 3 insertions(+), 8 deletions(-)

Applied in revision b34050b.

Thanks,
Marek

