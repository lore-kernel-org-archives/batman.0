Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 19 Nov 2012 16:17:22 +0800
References: <1353312104-29333-1-git-send-email-ordex@autistici.org>
 <1353312104-29333-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1353312104-29333-3-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201211191617.23637.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 3/3] batman-adv: remove useless
	assignment in tt_local_add()
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

On Monday, November 19, 2012 16:01:44 Antonio Quartulli wrote:
> The flag field of the tt_local_entry->common structure in
> tt_local_add() is first assigned NO_FLAGS and then TT_CLIENT_NEW so
> nullifying the first operation. For this reason it is safe to remove
> the first assignment.
> 
> This was introuduced by ("batman-adv: keep local table consistency for
> further TT_RESPONSE")
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  translation-table.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)

Applied in revision 1f59c6d.

Thanks,
Marek
