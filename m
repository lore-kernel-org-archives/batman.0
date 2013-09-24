Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 24 Sep 2013 20:11:33 +0800
Message-ID: <8965066.XXOQnxaeDQ@diderot>
In-Reply-To: <1379869771-17797-1-git-send-email-sven@narfation.org>
References: <1379860946-32669-3-git-send-email-sven@narfation.org>
 <1379869771-17797-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 3/4] batctl: Replace /proc/net/arp
	based resolver with rtnl
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
Cc: Sven Eckelmann <sven@narfation.org>

On Sunday 22 September 2013 19:09:31 Sven Eckelmann wrote:
> The /proc/net/arp based solution to resolve mac addresses from IP adresses
> is limited to IPv4 addresses. The table for IPv6 addresses to MAC addresses
> is only available through rtnetlink. rtnetlink also provides the IPv4
> neighbor table and should therefore should be prefered over the
> /proc/net/arp solution to build an infrastructure for further work on the
> resolver.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> V2:
>  * optimize for large ARP caches
> 
>  functions.c | 251
> +++++++++++++++++++++++++++++++++++++++++++++--------------- 1 file
> changed, 188 insertions(+), 63 deletions(-)

Applied in revision 4885dc1.

Thanks,
Marek

