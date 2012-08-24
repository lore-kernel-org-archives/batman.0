Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 25 Aug 2012 00:19:55 +0200
References: <1345451209-8898-1-git-send-email-sven@narfation.org>
 <1345451209-8898-3-git-send-email-sven@narfation.org>
In-Reply-To: <1345451209-8898-3-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201208250019.56062.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: Only increase refcounter
	once for alternate router
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

On Monday, August 20, 2012 10:26:49 Sven Eckelmann wrote:
> The test whether we can use a router for alternating bonding should only be
> done once because it is already known that it is still usable and will not
> be deleted from the list soon.
> 
> This patch addresses Coverity #712285: Unchecked return value
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  routing.c |   23 ++++++++---------------
>  1 file changed, 8 insertions(+), 15 deletions(-)

Applied in revision 534f242.

Thanks,
Marek
