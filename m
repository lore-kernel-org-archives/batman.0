Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 18 Oct 2012 18:01:44 +0800
References: <1350550112-5857-1-git-send-email-sven@narfation.org>
In-Reply-To: <1350550112-5857-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201210181801.44889.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Fix regression in bla
	multiline comment style
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

On Thursday, October 18, 2012 16:48:31 Sven Eckelmann wrote:
> 4c1721b39c8a77c99e8f4de97b5d5d112006406c ("batman-adv: Fix potential
> broadcast BLA-duplicate-check race condition") introduced a comment with
> the wrong line ending.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> Please merge in next
> 
>  bridge_loop_avoidance.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied in revision 5276048.

Thanks,
Marek
