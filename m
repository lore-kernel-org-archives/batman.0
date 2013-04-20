Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 20 Apr 2013 23:50:50 +0800
References: <1364976860-13225-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1364976860-13225-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201304202350.50286.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: use the proper header
	len when checking the TTVN
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

On Wednesday, April 03, 2013 16:14:20 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> Unicast packet might be of type either UNICAST or
> UNICAST4ADDR.
> In the two cases the header size is different, but the
> mechanism checking the TTVN field was assuming it to be
> always of the same type (UNICAST), so failing to access the
> inner Ethernet header in case of UNICAST4ADDR.
> 
> Fix this by passing the real header length as argument.
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  routing.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

Applied in revision 9b96ecb.

Thanks,
Marek
