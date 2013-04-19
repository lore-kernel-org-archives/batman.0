Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 19 Apr 2013 18:15:20 +0800
References: <1366290781-15376-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1366290781-15376-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201304191815.20374.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: pass a 16bit long flag
	argument to tt_global_add()
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

On Thursday, April 18, 2013 21:13:01 Antonio Quartulli wrote:
> it may be the case that we want to store some local TT client flags in a
> global entry, therefore the tt_global_add needs to get a proper argument
> for this
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
> 
> v2:
> - add tt_global_add() kernel doc
> 
>  translation-table.c | 19 +++++++++++++++++--
>  translation-table.h |  2 +-
>  2 files changed, 18 insertions(+), 3 deletions(-)

Applied with minor rewording in revision 0ff0af1.

Cheers,
Marek
