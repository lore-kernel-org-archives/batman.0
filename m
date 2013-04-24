Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 24 Apr 2013 22:29:26 +0800
References: <1366724403-29629-1-git-send-email-lindner_marek@yahoo.de>
 <1366724403-29629-6-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1366724403-29629-6-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201304242229.27092.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 5/7] batman-adv: tvlv - convert tt data
	sent within OGMs
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

On Tuesday, April 23, 2013 21:40:01 Marek Lindner wrote:
> The translation table meta data (version number, crc checksum, etc)
> as well as the translation table diff propgated within OGMs now uses
> the newly introduced tvlv infrastructure.
> 
> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> ---
>  bat_iv_ogm.c        |   44 +++-------
>  packet.h            |   51 ++++++++---
>  translation-table.c |  238
> ++++++++++++++++++++++++++++----------------------- translation-table.h
> |    8 +-
>  types.h             |    2 +-
>  5 files changed, 186 insertions(+), 157 deletions(-)

Applied in revision 8405301.

Regards,
Marek
