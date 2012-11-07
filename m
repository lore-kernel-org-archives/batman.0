Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 8 Nov 2012 04:14:48 +0800
References: <1352199923-16653-1-git-send-email-ordex@autistici.org>
 <1352199923-16653-5-git-send-email-ordex@autistici.org>
In-Reply-To: <1352199923-16653-5-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201211080414.49449.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 4/5] batman-adv: send ROAMING_ADV once
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

On Tuesday, November 06, 2012 19:05:22 Antonio Quartulli wrote:
> If a client roaming has already been advertised, the node should
> prevent it from doing the same more than once. To achieve this, the
> node has to check the ROAM flag on the global client: if this is set
> already, then the ROAMING_ADV for this client has already been sent.
> 
> This should be merged with changes done by ("batman-adv: roaming
> handling mechanism redesign")
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  translation-table.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Applied in revision b8416c2.

Thanks,
Marek
