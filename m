Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 25 Mar 2013 16:47:15 +0800
References: <1363854209-23414-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1363854209-23414-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201303251647.15243.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH next] batman-adv: use seq_puts instead of
	seq_printf when the format is constant
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

On Thursday, March 21, 2013 16:23:29 Antonio Quartulli wrote:
> As reported by checkpatch, seq_puts has to be preferred with
> respect to seq_printf when the format is a constant string
> (no va_args)
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
> 
> However checkpatch seems to be implementing this check in a wrong way:
> multi-line seq_printf are reported like having no arguments after the
> format.
> 
> Cheers,
> 
> 
>  gateway_client.c | 2 +-
>  main.c           | 2 +-
>  network-coding.c | 8 ++++----
>  originator.c     | 4 ++--
>  vis.c            | 4 ++--
>  5 files changed, 10 insertions(+), 10 deletions(-)

Applied in revision 174cf3a.

Thanks,
Marek
