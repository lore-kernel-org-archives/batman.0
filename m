Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 15 May 2012 19:28:25 +0800
References: <1336840447-6580-1-git-send-email-sven@narfation.org>
	<1336840447-6580-4-git-send-email-sven@narfation.org>
In-Reply-To: <1336840447-6580-4-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201205151928.25462.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 04/18] batman-adv: Prefix
	bridge_loop_avoidance local static functions with batadv_
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

On Sunday, May 13, 2012 00:33:53 Sven Eckelmann wrote:
> All non-static symbols of batman-adv were prefixed with batadv_ to avoid
> collisions with other symbols of the kernel. Other symbols of batman-adv
> should use the same prefix to keep the naming scheme consistent.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  bridge_loop_avoidance.c |  320
> +++++++++++++++++++++++++---------------------- 1 file changed, 168
> insertions(+), 152 deletions(-)

Applied in revision 7039674.

Thanks,
Marek
