Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 8 Aug 2013 12:53:22 +0800
References: <1375914091-2808-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1375914091-2808-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201308081253.23071.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: make the TT CRC logic VLAN
	specific
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

On Thursday, August 08, 2013 06:21:31 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> This change allows nodes to handle the TT table on a
> per-VLAN basis. This is needed because nodes may have to
> store only some of the global entries advertised by another
> node.
> 
> In this scenario such nodes would re-create only a partial
> global table and would not be able to compute a correct CRC
> anymore.
> 
> This patch splits the logic and introduces one CRC per VLAN.
> In this way a node fetching only some entries belonging to
> some VLANs is still able to compute the needed CRCs and
> still check the table correctness.
> 
> With this patch the shape of the TVLV-TT is changed too
> because now a node needs to advertise all the CRCs of all
> the VLANs that it is wired to.
> 
> The debug output of the local Translation Table now shows
> the CRC along with each entry since there is not a common
> value for the entire table anymore.
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  packet.h | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)

Applied in revision 38ae8d7.

Thanks,
Marek
