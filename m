Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 9 Jan 2013 15:26:33 +0800
References: <1357479895-12659-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1357479895-12659-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201301091526.33889.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batctl: man page - fix undefined macro
	warning
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Sunday, January 06, 2013 21:44:55 Marek Lindner wrote:
> A line beginning with ' or . in a groff file has a special meaning and
> cannot be used for literal text. Instead the interpreter will try to
> execute it and fail doing so. A zero-width space or reformatting the
> paragraph can be used as simple workaround.
> 
> This problem was detected using: LC_ALL=en_US.UTF-8 MANROFFSEQ=''
> MANWIDTH=80 man --warnings -E UTF-8 -l -Tutf8 -Z man/batctl.8
> 
> >/dev/null
> 
> Reported-by: Pau Koning <paukoning@gmail.com>
> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> ---
>  v2:
>      * Use different approach to solve issue as first attempt was too
>        obscure.
> 
>  man/batctl.8 |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Applied in revision ad16305.

Regards,
Marek
