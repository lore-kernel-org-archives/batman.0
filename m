Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 13 Sep 2013 18:51:05 +0800
Message-ID: <4024628.apkocGBlCt@diderot>
In-Reply-To: <1378847522-13776-7-git-send-email-sven@narfation.org>
References: <1378847522-13776-1-git-send-email-sven@narfation.org>
 <1378847522-13776-7-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [B.A.T.M.A.N.] [PATCH 06/11] batctl: Remove legacy types u64
	and caddr_t
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

On Tuesday 10 September 2013 23:11:57 Sven Eckelmann wrote:
> The definition of u64 was not obtained from the correct source to always use
> 64 bit. Instead uint64_t can be used.
> 
> Also caddr_t is obsolete BSDism and void* should be used instead.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  ioctl.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

Applied in revision 0a88d31.

Thanks,
Marek

