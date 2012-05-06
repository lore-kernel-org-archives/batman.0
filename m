Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 6 May 2012 20:36:36 +0800
References: <1336116752-585-1-git-send-email-sven@narfation.org>
	<1336217249-16071-1-git-send-email-sven@narfation.org>
	<1336217249-16071-2-git-send-email-sven@narfation.org>
In-Reply-To: <1336217249-16071-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201205062036.36873.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 2/2] batman-adv: Return error codes
	instead of -1 on failures
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Saturday, May 05, 2012 19:27:28 Sven Eckelmann wrote:
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  bat_sysfs.c             |    2 +-
>  bridge_loop_avoidance.c |    6 +++---
>  main.c                  |   27 ++++++++++++++++-----------
>  originator.c            |   18 +++++++++---------
>  translation-table.c     |   24 ++++++++++++++----------
>  vis.c                   |    8 ++++----
>  6 files changed, 47 insertions(+), 38 deletions(-)

Applied in revision 2f29426.

Thanks,
Marek
