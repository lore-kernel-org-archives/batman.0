Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 24 Sep 2013 20:09:13 +0800
Message-ID: <1750733.3MepXfCQX9@diderot>
In-Reply-To: <1379860946-32669-2-git-send-email-sven@narfation.org>
References: <1379860946-32669-1-git-send-email-sven@narfation.org>
 <1379860946-32669-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/4] batctl: Reduce IPv4 focus of mac
	resolve functions
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

On Sunday 22 September 2013 16:42:24 Sven Eckelmann wrote:
> The first implementation of the IP translation functions in
> cb75e019e74fc11f9547dadd51abbf3c9df2c5e7 ("batctl: Allow to use IPv4
> addresses for ping/traceroute") had is focus on implementing it only for
> IPv4. This is a limitation when other layer 3 protocols are used.
> 
> For example, a port to IPv6 would either have to copy the functionality or
> do a major refactoring when implementing the it resolv functionality. This
> is not necessary when the functions already expect different layer 3
> protocols in the first place and make it easy to find the right place to
> modify them.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  functions.c | 86
> ++++++++++++++++++++++++++++++++++++++++++++----------------- 1 file
> changed, 63 insertions(+), 23 deletions(-)

Applied in revision daf6aa6.

Thanks,
Marek

