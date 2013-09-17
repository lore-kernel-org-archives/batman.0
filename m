Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 17 Sep 2013 22:14:12 +0800
Message-ID: <3462153.sTp4aSuc5O@diderot>
In-Reply-To: <1378919684-374-1-git-send-email-antonio@meshcoding.com>
References: <1378919684-374-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: set the TAG flag for
	the vid passed to BLA
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
Cc: Antonio Quartulli <antonio@open-mesh.org>, Antonio Quartulli <antonio@open-mesh.com>

On Wednesday 11 September 2013 19:14:44 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> When receiving or sending a packet a packet on a VLAN, the
> vid has to be marked with the TAG flag in order to make any
> component in batman-adv understand that the packet is coming
> from a really tagged network.
> 
> This fix the Bridge Loop Avoidance behaviour which was not
> able to send announces over VLAN interfaces.
> 
> Introduced by 0b1da1765fdb00ca5d53bc95c9abc70dfc9aae5b
> ("batman-adv: change VID semantic in the BLA code")
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.org>
> ---
>  soft-interface.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied in revision 5922104.

Thanks,
Marek

