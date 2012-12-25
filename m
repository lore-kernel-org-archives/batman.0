Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 25 Dec 2012 21:40:57 +0800
References: <1355577056-28833-1-git-send-email-ordex@autistici.org>
 <1356437677-21893-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1356437677-21893-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201212252140.57466.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: a delayed_work has to be
	initialised once
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

On Tuesday, December 25, 2012 20:14:37 Antonio Quartulli wrote:
> A delayed_work struct does not need to be initialized each
> every time before being enqueued. Therefore the
> INIT_DELAYED_WORK() macro should be used during the
> initialization process only.
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
> 
> v2:
> * add defines for workier period lengths
> 
> 
>  bridge_loop_avoidance.c | 18 ++++++------------
>  main.h                  |  2 ++
>  originator.c            | 17 ++++++++---------
>  send.c                  |  5 +++--
>  translation-table.c     | 14 +++++---------
>  vis.c                   | 20 ++++++++------------
>  6 files changed, 32 insertions(+), 44 deletions(-)

Applied in revision ecee9b7.

Thanks,
Marek
