Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 22 Dec 2011 20:27:45 +0800
References: <1324380794-2971-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1324380794-2971-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201112222027.45322.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: convert time_after instances
	to has_timed_out
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

On Tuesday, December 20, 2011 19:33:14 Marek Lindner wrote:
> To increase readability the has_timed_out() functions has been introduced.
> This patch converts existing time_after() calls to use this wrapper
> function (if applicable).
> 
> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> ---
>  originator.c     |   11 ++++-------
>  routing.c        |    3 +--
>  soft-interface.c |    4 ++--
>  vis.c            |    3 +--
>  4 files changed, 8 insertions(+), 13 deletions(-)

Applied in revision a7fdb84.

Regards,
Marek
