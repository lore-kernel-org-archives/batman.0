Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 13 Sep 2013 19:26:05 +0800
Message-ID: <2155416.Juq5VGKGyK@diderot>
In-Reply-To: <1378847522-13776-12-git-send-email-sven@narfation.org>
References: <1378847522-13776-1-git-send-email-sven@narfation.org>
 <1378847522-13776-12-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [B.A.T.M.A.N.] [PATCH 11/11] batctl: Don't use hyphen for
	parameter in manpage
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

On Tuesday 10 September 2013 23:12:02 Sven Eckelmann wrote:
> By default, "-" chars are interpreted as hyphens (U+2010) by groff, not as
> minus signs (U+002D). Since options to programs use minus signs (U+002D),
> this means for example in UTF-8 locales that you cannot cut and paste
> options, nor search for them easily.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  man/batctl.8 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in revision b64f1c8.

Thanks,
Marek

