Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 18 Apr 2013 00:04:56 +0800
References: <1366213483-10120-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1366213483-10120-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201304180004.56720.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: move
	batadv_slide_own_bcast_window to bat_iv_ogm.c
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

On Wednesday, April 17, 2013 23:44:43 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> batadv_slide_own_bcast_window() is used only in bat_iv_ogm.c
> and it is currently touching only batman_iv specific
> attributes.
> 
> Move it into bat_iv_ogm.c and make it static.
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
> 
> v2:
> - added kernel doc
> 
>  bat_iv_ogm.c | 37 ++++++++++++++++++++++++++++++++++++-
>  routing.c    | 29 -----------------------------
>  routing.h    |  1 -
>  3 files changed, 36 insertions(+), 31 deletions(-)

Applied in revision 1ba0222.

Thanks,
Marek
