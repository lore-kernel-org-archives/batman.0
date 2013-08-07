Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 7 Aug 2013 19:27:22 +0800
References: <1375215385-606-1-git-send-email-ordex@autistici.org>
 <1375215385-606-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1375215385-606-2-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201308071927.22294.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv9 1/2] batman-adv: lock around TT
	operations to avoid sending inconsistent data
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
Cc: Antonio Quartulli <antonio@open-mesh.com>, Antonio Quartulli <ordex@autistici.org>

On Wednesday, July 31, 2013 04:16:24 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> A TT response may be prepared and sent while the local or
> global translation table is getting updated.
> 
> The worst case is when one of the tables is accessed after
> its content has been recently updated but the metadata
> (TTVN/CRC) has not yet. In this case the reader will get a
> table content which does not match the TTVN/CRC.
> This will lead to an inconsistent state and so to a TT
> recovery.
> 
> To avoid entering this situation, put a lock around those TT
> operations recomputing the metadata and around the TT
> Response creation (the latter is the only reader that
> accesses the metadata together with the table).
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  main.c              |  1 +
>  originator.c        |  1 +
>  translation-table.c | 23 +++++++++++++++++++----
>  types.h             | 13 +++++++++++++
>  4 files changed, 34 insertions(+), 4 deletions(-)

Applied in revision 1583626.

Thanks,
Marek
