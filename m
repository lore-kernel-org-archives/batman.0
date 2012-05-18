Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 18 May 2012 20:44:33 +0800
References: <1779270.uUsuEFyTM4@sven-desktop.home.narfation.org>
	<1337192605-8652-1-git-send-email-sven@narfation.org>
	<1337192605-8652-8-git-send-email-sven@narfation.org>
In-Reply-To: <1337192605-8652-8-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201205182044.33574.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 08/13] batman-adv: Mark only locally used
	symbol batadv_tt_local_crc as static
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

On Thursday, May 17, 2012 02:23:20 Sven Eckelmann wrote:
> 29ccfec94d51f7725124786e29d023b212920661 changed the translation table code
> in such a way that it doesn't use the symbol tt_local_crc outside of
> translation-table.c
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  translation-table.c |    2 +-
>  translation-table.h |    1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)

Applied in revision e47eadc.

Thanks,
Marek
