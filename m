Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 23 Sep 2012 15:52:34 +0800
References: <1347553126-13816-1-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1347553126-13816-1-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201209231552.35216.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: wait multiple periods before
	activating bla
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
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

On Friday, September 14, 2012 00:18:46 Simon Wunderlich wrote:
> For some reasons (bridge forward delay, network device setup order, etc)
> the initial bridge loop avoidance announcement packets may be lost. This
> may lead to problems in finding other backbone gws, and therfore create
> loops in the startup time.
> 
> Fix this by extending the waiting periods to 3 (define can be changed)
> before allowing broadcast traffic.
> 
> Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> ---
>  bridge_loop_avoidance.c |    9 ++++++++-
>  main.h                  |    1 +
>  types.h                 |    1 +
>  3 files changed, 10 insertions(+), 1 deletion(-)

Applied in revision bafd3f4.

Thanks,
Marek
