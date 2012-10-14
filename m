Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 14 Oct 2012 22:54:08 +0800
References: <1349787611-18102-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1349787611-18102-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201210142254.08728.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix DAT packet counting
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

On Tuesday, October 09, 2012 21:00:11 Antonio Quartulli wrote:
> DAT packets must be counted before any batadv_dat_snoop_incoming_*
> invocation otherwise the code flow can jump the counters increment at all
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  routing.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied in revision 2b105ca.

Thanks,
Marek
