Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 13 Sep 2012 19:06:58 +0800
References: <1347180406-12475-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1347180406-12475-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201209131906.59005.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: prevent using any virtual
	device created on batman-adv as hard-interface
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

On Sunday, September 09, 2012 16:46:46 Antonio Quartulli wrote:
> Any virtual device created on top of a batman-adv mesh interface must be
> prevented to be used to create a new mesh network (this would lead to an
> unwanted batman-over-batman configuration)
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
> 
> v2:
> - added check for !parent_dev with WARN_ON()
> 
> 
>  hard-interface.c | 41 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)

Applied in revision 3d48811.

Thanks,
Marek
