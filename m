Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 1 Dec 2012 21:27:59 +0800
References: <1354161285-1992-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1354161285-1992-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201212012127.59855.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: don't print the last_seen
	time for bat0 TT local entry
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

On Thursday, November 29, 2012 11:54:45 Antonio Quartulli wrote:
> bat0 MAC address will never deleted from the local translation table,
> therefore printing its last_Seen time is useless and will also produce
> ugly output and eventually a variable overflow.
> 
> This was introduced by 59cb0861498776c62bd17584c31f34477fa301a0
> ("batman-adv: improve local translation table output")
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  translation-table.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Applied in revision 1572732.

Thanks,
Marek
