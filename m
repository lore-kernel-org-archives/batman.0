Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 5 Jun 2013 17:01:06 +0800
References: <1369739668-3692-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1369739668-3692-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201306051701.06861.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 1/2] batman-adv: implement
	batadv_tt_entries
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

On Tuesday, May 28, 2013 19:14:27 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> Implement batadv_tt_entries() to get the number of entries
> fitting in a given amount of bytes. This computation is done
> several times in the code and therefore it is useful to have
> an helper function.
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  translation-table.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)

Applied in revision f3ec6b3.

Thanks,
Marek
