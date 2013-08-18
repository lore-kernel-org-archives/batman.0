Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 18 Aug 2013 22:06:45 +0800
References: <1376822403-3383-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1376822403-3383-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201308182206.45373.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: fix variable name in
	compat code
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Antonio Quartulli <ordex@autistici.org>

On Sunday, August 18, 2013 18:40:03 Antonio Quartulli wrote:
> compat code introduced by
> 0d941e82ab5f92faf33bee6abdde519056f3ac2d
> ("batman-adv: Unmap fragment page once iterator is done")
> is declaring a variable having the same name of one used in
> the batman-adv code. Rename it to prevent sparse warnings.
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  compat.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied in revision e39bc52.

Thanks,
Marek
