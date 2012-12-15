Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 15 Dec 2012 16:21:25 +0800
References: <50BF086A.4020505@web.de>
In-Reply-To: <50BF086A.4020505@web.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201212151621.25822.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: indicate successful termination
	when -h is used
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

On Wednesday, December 05, 2012 16:40:10 Moritz Warning wrote:
> The return value of batctl -h indicates failure while
> it should indicate a successful execution.
> 
> 
> Signed-off-by: Moritz Warning <moritzwarning@web.de>
> ---
> From: Moritz Warning <moritzwarning@web.de>
> Subject: [PATCH] batctl: change return value to indicate successful
>  termination when -h is used
> 
> ---
>  main.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Applied in revision 1932d4e.

Thanks,
Marek
