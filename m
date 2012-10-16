Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 16 Oct 2012 17:21:38 +0800
References: <1350374680-8103-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1350374680-8103-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201210161721.38400.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 1/2] batman-adv: support array of
	debugfs general attributes
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

On Tuesday, October 16, 2012 16:04:39 Antonio Quartulli wrote:
> This patch adds support for an array of debugfs general (not soft_iface
> specific) attributes. With this change it will be possible to add more
> general attributes by simply appending them to the array without touching
> the rest of the code.
> 
> Reported-by: Marek Lindner <lindner_marek@yahoo.de>
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> Acked-by: Sven Eckelmann <sven@narfation.org>
> ---
> 
> v2:
>  - fixed kernel-doc
> v3:
>  - added report-by
> 
>  debugfs.c | 34 +++++++++++++++++++++++++---------
>  1 file changed, 25 insertions(+), 9 deletions(-)

Applied in revision dfb5f80.

Thanks,
Marek
