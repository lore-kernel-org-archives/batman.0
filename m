Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 18 Apr 2013 20:43:10 +0800
References: <1366136543-16916-1-git-send-email-ordex@autistici.org>
 <1366136543-16916-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1366136543-16916-2-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201304182043.10972.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: move
	BATADV_TT_CLIENT_TEMP to higher bit
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
Cc: Antonio Quartulli <ordex@autistici.org>

On Wednesday, April 17, 2013 02:22:23 Antonio Quartulli wrote:
> Client flags from bit 0 to 7 are sent over the wire.
> BATADV_TT_CLIENT_TEMP is not sent therefore it has occupy
> an higher bit so to avoid wasting positions used by flags
> sent within packets
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  packet.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Marek Lindner <lindner_marek@yahoo.de>

Cheers,
Marek
