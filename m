Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 19 May 2012 00:01:21 +0800
References: <1337192605-8652-12-git-send-email-sven@narfation.org>
	<1337354173-23825-1-git-send-email-sven@narfation.org>
In-Reply-To: <1337354173-23825-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201205190001.22040.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Prefix bat_sysfs local
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

On Friday, May 18, 2012 23:16:13 Sven Eckelmann wrote:
> All non-static symbols of batman-adv were prefixed with batadv_ to avoid
> collisions with other symbols of the kernel. Other symbols of batman-adv
> should use the same prefix to keep the naming scheme consistent.
> 
> This was actually part of patch used to create the commit
> 98881e49493eb1a6ae2330d861386432064b2222.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> 
> This is the alternative version of this patch... that keeps the
> functionality for ELP
> 
>  bat_sysfs.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Applied in revision 34f20d6.

Thanks,
Marek
