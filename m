Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 24 Apr 2013 22:32:05 +0800
References: <1366724403-29629-1-git-send-email-lindner_marek@yahoo.de>
 <1366724403-29629-8-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1366724403-29629-8-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201304242232.06002.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 7/7] batman-adv: tvlv - convert roaming
	adv packet to use tvlv unicast packets
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

On Tuesday, April 23, 2013 21:40:03 Marek Lindner wrote:
> Instead of generating roaming specific packets the TVLV unicast API is
> used to send roaming information.
> 
> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> ---
>  main.c              |    2 -
>  packet.h            |   19 +++++-----
>  routing.c           |   42 ---------------------
>  translation-table.c |  102
> ++++++++++++++++++++++++++++++++++++--------------- 4 files changed, 83
> insertions(+), 82 deletions(-)

Applied in revision 3de4e64.

Regards,
Marek
