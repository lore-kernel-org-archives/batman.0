Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 24 Sep 2013 20:34:32 +0800
Message-ID: <2412289.Q50TmYPdjC@diderot>
In-Reply-To: <1379873305-1292-1-git-send-email-antonio@meshcoding.com>
References: <1379873305-1292-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [B.A.T.M.A.N.] [PATCH next] batman-adv: fix usage and
	declaration of batadv_bandwidth_units
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

On Sunday 22 September 2013 20:08:25 Antonio Quartulli wrote:
> Name in declaration does not reflect the one reporte din the kernel doc.
> Moreover a variable storing an enum should be of type enum rather than
> int (this helps the compiler to spott possible mistakes)
> 
> Introduced by 0853ec7fafe0a195754454832993c6b35e22b842
> ("batman-adv: tvlv - gateway download/upload bandwidth container")
> 
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
>  gateway_common.c | 3 ++-
>  gateway_common.h | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)

Applied in revision 8b3e7b9.

Thanks,
Marek

