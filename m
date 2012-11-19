Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 19 Nov 2012 16:15:00 +0800
References: <1353312104-29333-1-git-send-email-ordex@autistici.org>
 <1353312104-29333-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1353312104-29333-2-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201211191615.01755.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 2/3] batman-adv: unify and properly
	print hex values
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

On Monday, November 19, 2012 16:01:43 Antonio Quartulli wrote:
> Values are printed in hexadecimal format in several points in the
> code, but they are not printed using the same format string.
> 
> This patches unifies the format used for such numbers so that they
> look the same everywhere.
> 
> Given the fact that all the variables printed as hexadecimal are 16
> bit long, this is the chosen printing format: %#.4x
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  bat_iv_ogm.c            |  2 +-
>  bridge_loop_avoidance.c | 18 +++++++++---------
>  translation-table.c     |  2 +-
>  3 files changed, 11 insertions(+), 11 deletions(-)

Applied in revision 6dc9df5.

Thanks,
Marek
