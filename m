Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 25 Apr 2013 13:38:01 +0800
References: <1366814272-21120-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1366814272-21120-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201304251338.01441.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH respin 1/2] batman-adv: use CRC32C
	instead of CRC16 in TT code
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

On Wednesday, April 24, 2013 22:37:51 Antonio Quartulli wrote:
> CRC32C has to be preferred to CRC16 because of its possible
> HW native support and because of its less likely probability
> of collision. With this change the Translation Table
> component now uses CRC32C to compute the Local and Global
> Table checksum.
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  packet.h            |  4 +--
>  translation-table.c | 71
> ++++++++++++++++++++++++++++-------------------------
> types.h             |  4 +--
>  3 files changed, 42 insertions(+), 37 deletions(-)

Applied in revision c5e7a06.

Thanks,
Marek
