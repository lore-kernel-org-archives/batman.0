Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 27 Jan 2013 13:29:58 +0800
References: <1358252239-15417-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1358252239-15417-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201301271329.58758.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: don't use !! in bool
	conversion
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

On Tuesday, January 15, 2013 20:17:19 Antonio Quartulli wrote:
> In C standard any expression different from 0 will be converted to
> 'true' when casting to bool (whatever is the length of the value).
> Therefore all the "!!" conversions can be removed.
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
> 
> * v2:
>  - commit message reworded
> 
> 
>  translation-table.c | 4 ++--
>  unicast.c           | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)

Applied in revision a365cf4.

Thanks,
Marek
