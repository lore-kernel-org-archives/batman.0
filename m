Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 24 Sep 2013 20:29:58 +0800
Message-ID: <1453473.lopdlyuPuQ@diderot>
In-Reply-To: <1379873908-1766-2-git-send-email-antonio@meshcoding.com>
References: <1379873908-1766-1-git-send-email-antonio@meshcoding.com>
 <1379873908-1766-2-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2 next] batman-adv: fix orig
	capabilities numbering (NetCod)
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

On Sunday 22 September 2013 20:18:28 Antonio Quartulli wrote:
> Use bit 1 after bit 0.
> 
> Introduced by 7dd9d8992b0c197ba656a6d9a70966cea10fc2d9
> ("batman-adv: tvlv - add network coding container")
> 
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
>  types.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in revision 4e458f4.

Thanks,
Marek

