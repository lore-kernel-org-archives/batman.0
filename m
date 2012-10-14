Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 14 Oct 2012 22:48:50 +0800
References: <1349609655-15988-1-git-send-email-sven@narfation.org>
In-Reply-To: <1349609655-15988-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201210142248.50484.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Mark best gateway in
	transtable_global debugfs
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
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Sunday, October 07, 2012 19:34:15 Sven Eckelmann wrote:
> The transtable_global debug file can show multiple entries for a single
> client when multiple gateways exist. The chosen gateway isn't marked in
> the list and therefore the user cannot easily debug the situation when
> there is a problem with the currently used gateway.
> 
> The best gateway is now marked with "*" and secondary gateways are marked
> with "+".
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  translation-table.c |   80
> +++++++++++++++++++++++++++++++++++---------------- 1 file changed, 56
> insertions(+), 24 deletions(-)

Applied in revision 1421221.

Thanks,
Marek
