Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 18 May 2012 16:26:46 +0800
References: <1779270.uUsuEFyTM4@sven-desktop.home.narfation.org>
	<1337192605-8652-1-git-send-email-sven@narfation.org>
	<1337192605-8652-2-git-send-email-sven@narfation.org>
In-Reply-To: <1337192605-8652-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201205181626.46247.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 02/13] batman-adv: Prefix send local
	static functions with batadv_
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

On Thursday, May 17, 2012 02:23:14 Sven Eckelmann wrote:
> All non-static symbols of batman-adv were prefixed with batadv_ to avoid
> collisions with other symbols of the kernel. Other symbols of batman-adv
> should use the same prefix to keep the naming scheme consistent.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  send.c |   30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)

Applied in revision aec4e11.

Thanks,
Marek
