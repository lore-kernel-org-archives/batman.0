Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 11 Sep 2013 18:56:28 +0800
Message-ID: <1472420.0v00foOB9B@diderot>
In-Reply-To: <1378847522-13776-4-git-send-email-sven@narfation.org>
References: <1378847522-13776-1-git-send-email-sven@narfation.org>
 <1378847522-13776-4-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [B.A.T.M.A.N.] [PATCH 03/11] batctl: Avoid assigning const
	buffer to non-const pointer
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

On Tuesday, September 10, 2013 11:11:54 PM Sven Eckelmann wrote:
> Strings in C are tried to be saved in the .rodata by the compiler/linker.
> This section is readonly as the name suggests. Pointer to these strings
> should therefore be const.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  functions.c | 8 +++++---
>  functions.h | 5 +++--
>  2 files changed, 8 insertions(+), 5 deletions(-)

Applied in revision 55509e5.

Thanks,
Marek

