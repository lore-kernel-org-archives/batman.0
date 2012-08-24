Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 24 Aug 2012 23:59:20 +0200
References: <1345451209-8898-1-git-send-email-sven@narfation.org>
In-Reply-To: <1345451209-8898-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201208242359.21231.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: Remove extra check in
	batadv_bit_get_packet
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

On Monday, August 20, 2012 10:26:47 Sven Eckelmann wrote:
> batadv_bit_get_packet checks for all common situations before it decides
> that the new received packet indicates that the host was restarted. This
> extra condition check at the end of the function is not necessary because
> this condition is always true.
> 
> This patch addresses Coverity #712296: Logically dead code
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  bitarray.c |   23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)

Applied in revision d2da57c.

Thanks,
Marek
