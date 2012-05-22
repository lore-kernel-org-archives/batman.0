Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 22 May 2012 12:43:06 +0800
References: <1337413075-8853-1-git-send-email-sven@narfation.org>
	<1337504138-8209-1-git-send-email-sven@narfation.org>
In-Reply-To: <1337504138-8209-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201205221243.06594.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: Remove batadv_ vararg
	inline functions
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

On Sunday, May 20, 2012 16:55:38 Sven Eckelmann wrote:
> gcc doesn't support the inlining of functions using vararg. Sparse fails to
> build the source when having such functions marked using the keyword
> "inline".
> 
> This problem was introduced in 3b896e321c49e3cbbfd540f537c007db883c3900
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> I've decided that we should it revert for now and hope for a better
> solution in the future. The old patch didn't worked at all for .._DEBUG=y
> all builds.
> 
>  bat_debugfs.c |    5 ++++-
>  main.h        |   39 +++++++++++++--------------------------
>  2 files changed, 17 insertions(+), 27 deletions(-)

Applied in revision dfacdc0.

Thanks,
Marek
