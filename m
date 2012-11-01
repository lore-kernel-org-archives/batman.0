Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 1 Nov 2012 12:47:01 +0800
References: <1351521488-17271-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1351521488-17271-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201211011247.01523.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: free the dat hash only if
	not NULL
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

On Monday, October 29, 2012 22:38:08 Antonio Quartulli wrote:
> It could be the case that the user tries to disable DAT when it is already
> disabled. To prevent kernel oops, batadv_dat_hash_free() has to check for
> the hash table pointer being different from NULL before to try to free it.
> 
> This was introduced by ("batman-adv: Distributed ARP Table - add runtime
> switch")
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  distributed-arp-table.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied in revision 59f8434.

Thanks,
Marek
