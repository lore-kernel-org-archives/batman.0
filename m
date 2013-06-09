Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 9 Jun 2013 22:02:32 +0800
References: <1370340711-1399-1-git-send-email-ordex@autistici.org>
 <1370340711-1399-5-git-send-email-ordex@autistici.org>
In-Reply-To: <1370340711-1399-5-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201306092202.32313.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 04/13] batman-adv: make the GW module
	correctly talk to the new VLAN-TT
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
Cc: Antonio Quartulli <antonio@open-mesh.com>, Antonio Quartulli <ordex@autistici.org>

On Tuesday, June 04, 2013 18:11:42 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> The gateway code is now adapted in order to correctly
> interact with the Translation Table component by using the
> vlan ID
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  gateway_client.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)

Applied in revision 9a40777.

Thanks,
Marek
