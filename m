Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 11 Sep 2013 18:49:24 +0800
Message-ID: <2718336.kvyubBO8lj@diderot>
In-Reply-To: <1378847522-13776-2-git-send-email-sven@narfation.org>
References: <1378847522-13776-1-git-send-email-sven@narfation.org>
 <1378847522-13776-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [B.A.T.M.A.N.] [PATCH 01/11] batctl: Fix possible buffer
	overflow when using strncat
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

On Tuesday, September 10, 2013 11:11:52 PM Sven Eckelmann wrote:
> The length field (n) of strncat is used to specify the length of the buffer
> without the \0 delimiter. strncat will add it even when it will write it to
> the limit of n bytes was written.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  bat-hosts.c | 2 +-
>  functions.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Applied in revision f1e262c.

Thanks,
Marek

